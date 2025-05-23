<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\library\numero_a_letras\src\NumeroALetras;
use App\Models\Configuracion;
use App\Models\DetalleVenta;
use App\Models\Devolucion;
use App\Models\DevolucionDetalle;
use App\Models\HistorialAccion;
use App\Models\KardexProducto;
use App\Models\Venta;
use App\Models\Producto;
use App\Models\SucursalStock;
use App\Services\HistorialAccionService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use PDF;

class VentaController extends Controller
{
    public $validacion = [
        "cliente_id" => "required",
        "descuento" => "required|numeric|min:0|max:100",
        "nom_fac" => "required|string|min:1|max:100",
        "nit_fac" => "required|string|min:1|max:100",
        "total_final" => "required",
    ];
    private $modulo = "VENTAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function index()
    {
        $ventas = Venta::with("cliente")->where("status", 1)->orderBy("created_at", "desc")->get();
        if (Auth::user()->tipo == 'VENDEDOR') {
            $ventas = Venta::with("cliente")->where("user_id", Auth::user()->id)->where("status", 1)->orderBy("created_at", "desc")->get();
        }

        return response()->JSON(["ventas" => $ventas, "total" => count($ventas)]);
    }

    public function ventas_caja(Request $request)
    {
        $ventas = Venta::where("caja_id", $request->id)->where("status", 1)->get();
        return response()->JSON($ventas);
    }

    public function store(Request $request)
    {
        $request->validate(
            $this->validacion,
            [
                "nom_fac.required" => "Debes ingresar el nombre de factura",
                "nit_fac.required" => "Debes ingresar el C.I./NIT de la Factura"
            ]
        );

        DB::beginTransaction();
        try {
            $request["fecha_registro"] = date("Y-m-d");
            $request["estado"] = "CANCELADO";
            $request["user_id"] = Auth::user()->id;
            $venta = Venta::create(array_map("mb_strtoupper", $request->except("detalle_ventas", "cliente", "user")));

            $detalle_ventas = $request->detalle_ventas;
            foreach ($detalle_ventas as $value) {
                $dv = $venta->detalle_ventas()->create([
                    "producto_id" => $value["producto_id"],
                    "cantidad" => $value["cantidad"],
                    "precio" => $value["precio"],
                    "subtotal" => $value["subtotal"],
                ]);
                // registrar kardex
                KardexProducto::registroEgreso("VENTA", $dv->id, $dv->producto, $dv->cantidad, $dv->precio, "VENTA DE PRODUCTO");
            }
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA VENTA", $venta, null, ["detalle_ventas"]);
            DB::commit();
            return response()->JSON(["sw" => true, "venta" => $venta, "id" => $venta->id, "msj" => "El registro se almacenó correctamente"]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(Venta $venta)
    {
        return response()->JSON($venta->load("user")->load("cliente")->load("detalle_ventas.producto"));
    }

    public function printTicket(Venta $venta)
    {
        $oConfiguracion = Configuracion::first();
        $convertir = new NumeroALetras();
        $array_monto = explode('.', number_format($venta->total_final, 2, '.', ''));
        $literal = $convertir->convertir($array_monto[0]);
        $literal .= " " . $array_monto[1] . "/100." . " BOLIVIANOS";

        $customPaper = [0, 0, 206.0, 700.0]; // [top, left, bottom, right]

        $pdf = PDF::loadView('parcials.ticket', compact("venta", "oConfiguracion", 'literal'))->setPaper($customPaper, 'portrait');
        return $pdf->stream('ticket.pdf', array('Attachment' => 1));
    }

    public function update(Venta $venta, Request $request)
    {
        $request->validate(
            $this->validacion,
            [
                "nom_fac.required" => "Debes ingresar el nombre de factura",
                "nit_fac.required" => "Debes ingresar el C.I./NIT de la Factura"
            ]
        );

        DB::beginTransaction();
        try {
            $old_venta = clone $venta;

            $request["estado"] = "CANCELADO";
            $venta->update(array_map("mb_strtoupper", $request->except("detalle_ventas", "eliminados", "cliente", "user")));
            $detalle_ventas = $request->detalle_ventas;
            foreach ($detalle_ventas as $value) {
                if ($value["id"] == 0) {
                    $dv = $venta->detalle_ventas()->create([
                        "producto_id" => $value["producto_id"],
                        "cantidad" => $value["cantidad"],
                        "precio" => $value["precio"],
                        "subtotal" => $value["subtotal"],
                    ]);
                    // registrar kardex
                    KardexProducto::registroEgreso("VENTA", $dv->id, $dv->producto, $dv->cantidad, $dv->precio, "VENTA DE PRODUCTO");
                } else {
                    $dv = DetalleVenta::find($value["id"]);
                    // incrementar el stock
                    Producto::incrementarStock($dv->producto, $dv->cantidad);
                    // VALIDAR STOCK
                    $o_producto = Producto::findOrFail($dv->producto_id);
                    if ($o_producto->stock_actual < $dv->cantidad) {
                        throw new Exception('No es posible realizar el registro debido a que la cantidad supera al stock disponible ' . $o_producto->stock_actual);
                    }
                    $dv->update([
                        "producto_id" => $value["producto_id"],
                        "cantidad" => $value["cantidad"],
                        "precio" => $value["precio"],
                        "subtotal" => $value["subtotal"],
                    ]);
                    Producto::decrementarStock($dv->producto, $dv->cantidad);
                    // actualizar kardex
                    $kardex = KardexProducto::where("producto_id", $dv->producto_id)
                        ->where("tipo_registro", "VENTA")
                        ->where("registro_id", $dv->id)
                        ->get()->first();

                    KardexProducto::actualizaRegistrosKardex($kardex->id, $kardex->producto_id);
                }
            }

            $eliminados = $request->eliminados;
            foreach ($eliminados as $value) {
                $dv = DetalleVenta::find($value);
                $producto = Producto::find($dv->producto_id);
                // ACTUALIZAR KARDEX
                $eliminar_kardex = KardexProducto::where("tipo_registro", "VENTA")
                    ->where("registro_id", $dv->id)
                    ->where("producto_id", $dv->producto_id)
                    ->get()
                    ->first();
                $id_kardex = $eliminar_kardex->id;
                $id_producto = $eliminar_kardex->producto_id;
                $eliminar_kardex->delete();

                $anterior = KardexProducto::where("producto_id", $id_producto)
                    ->where("id", "<", $id_kardex)
                    ->get()
                    ->last();
                $actualiza_desde = null;
                if ($anterior) {
                    $actualiza_desde = $anterior;
                } else {
                    // comprobar si existen registros posteriorres al actualizado
                    $siguiente = KardexProducto::where("producto_id", $id_producto)
                        ->where("id", ">", $id_kardex)
                        ->get()->first();
                    if ($siguiente)
                        $actualiza_desde = $siguiente;
                }

                if ($actualiza_desde) {
                    // actualizar a partir de este registro los sgtes. registros
                    KardexProducto::actualizaRegistrosKardex($actualiza_desde->id, $actualiza_desde->producto_id);
                }

                // incrementar el stock
                Producto::incrementarStock($producto, $dv->cantidad);

                $dv->delete();
            }

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA VENTA", $old_venta, $venta, ["detalle_ventas"]);

            DB::commit();
            return response()->JSON(["sw" => true, "venta" => $venta, "id" => $venta->id, "msj" => "El registro se actualizó correctamente"]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroy(Venta $venta)
    {
        DB::beginTransaction();
        try {

            foreach ($venta->detalle_ventas as $dv) {
                $producto = Producto::find($dv->producto_id);
                // ACTUALIZAR KARDEX
                $eliminar_kardex = KardexProducto::where("tipo_registro", "VENTA")
                    ->where("registro_id", $dv->id)
                    ->where("producto_id", $dv->producto_id)
                    ->where("status", 1)
                    ->get()
                    ->first();
                $id_kardex = $eliminar_kardex->id;
                $id_producto = $eliminar_kardex->producto_id;
                // $eliminar_kardex->delete();
                $eliminar_kardex->status = 0;
                $eliminar_kardex->save();

                $anterior = KardexProducto::where("producto_id", $id_producto)
                    ->where("id", "<", $id_kardex)
                    ->where("status", 1)
                    ->get()
                    ->last();
                $actualiza_desde = null;
                if ($anterior) {
                    $actualiza_desde = $anterior;
                } else {
                    // comprobar si existen registros posteriorres al actualizado
                    $siguiente = KardexProducto::where("producto_id", $id_producto)
                        ->where("id", ">", $id_kardex)
                        ->where("status", 1)
                        ->get()->first();
                    if ($siguiente)
                        $actualiza_desde = $siguiente;
                }

                if ($actualiza_desde) {
                    // actualizar a partir de este registro los sgtes. registros
                    KardexProducto::actualizaRegistrosKardex($actualiza_desde->id, $actualiza_desde->producto_id);
                }

                // incrementar el stock
                Producto::incrementarStock($producto, $dv->cantidad);

                // $dv->delete();
                $dv->status = 0;
                $dv->save();
            }
            if ($venta->credito) {
                $venta->credito->delete();
            }

            $old_venta = clone $venta;
            // $venta->delete();
            $venta->status = 0;
            $venta->save();
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA VENTA", $old_venta, null, ["detalle_ventas"]);

            DB::commit();
            return response()->JSON(["sw" => true, "msj" => "El registro se eliminó correctamente"]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getLiteral(Request $request)
    {
        $convertir = new NumeroALetras();
        $array_monto = explode('.', number_format($request->total, 2, '.', ''));
        $literal = $convertir->convertir($array_monto[0]);
        $literal .= " " . $array_monto[1] . "/100." . " BOLIVIANOS";
        return response()->JSON($literal);
    }

    public function getDevolucions(Request $request)
    {
        $venta = Venta::findOrFail($request->id);
        $devolucion = Devolucion::with("devolucion_detalles.producto")->with("devolucion_detalles.detalle_orden")->where("orden_id", $request->id)->get()->first();
        $total_cantidad_devolucion = 0;
        $total_final = 0;
        $p_descuento = $venta->descuento / 100;
        $descuento = 0;
        if ($devolucion) {
            $venta = $devolucion->orden;
            $total_final = $devolucion->orden->total;
            $total_cantidad_devolucion = DevolucionDetalle::where("devolucion_id", $devolucion->id)->sum("cantidad");
            if ($total_cantidad_devolucion > 0) {
                $total_devolucion = 0;
                foreach ($venta->detalle_ventas as $do) {
                    // restar totales
                    $detalle_devolucion = DevolucionDetalle::where("detalle_orden_id", $do->id)->get()->first();
                    if ($detalle_devolucion && $detalle_devolucion->cantidad > 0) {
                        $total_devolucion += (float)$detalle_devolucion->cantidad * $do->precio;
                    }
                }
                $total_final = (float)$total_final - $total_devolucion;
            }
            $descuento = $total_final * $p_descuento;
            $total_final = $total_final - $descuento;
        } else {
            $total_final = $venta->total_final;
        }

        return response()->JSON([
            "devolucion" => $devolucion,
            "total_cantidad_devolucion" => $total_cantidad_devolucion,
            "p_descuento" => $p_descuento,
            "total_final" => number_format($total_final, 2, '.', '')
        ]);
    }

    public function pdf(Venta $venta)
    {
        $convertir = new NumeroALetras();
        $array_monto = explode('.', $venta->total);
        $literal = $convertir->convertir($array_monto[0]);
        $literal .= " " . $array_monto[1] . "/100." . " BOLIVIANOS";

        $nro_factura = (int)$venta->id;
        if ($nro_factura < 10) {
            $nro_factura = '000' . $nro_factura;
        } else if ($nro_factura < 100) {
            $nro_factura = '00' . $nro_factura;
        } else if ($nro_factura < 1000) {
            $nro_factura = '0' . $nro_factura;
        }

        $customPaper = array(0, 0, 360, 600);

        $pdf = PDF::loadView('reportes.venta', compact('venta', 'literal', 'nro_factura'))->setPaper('legal', 'landscape');
        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Usuarios.pdf');
    }
}
