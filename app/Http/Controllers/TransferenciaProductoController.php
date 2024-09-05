<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\HistorialAccion;
use App\Models\KardexProducto;
use App\Models\Producto;
use App\Models\SucursalStock;
use App\Models\TransferenciaProducto;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TransferenciaProductoController extends Controller
{
    public $validacion = [
        'cantidad' => 'required|numeric',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $transferencia_productos = TransferenciaProducto::with("producto")->get();
        return response()->JSON(['transferencia_productos' => $transferencia_productos, 'total' => count($transferencia_productos)], 200);
    }

    public function store(Request $request)
    {
        $this->validacion["producto_id"] = "required";
        $this->validacion["origen"] = "required";
        $this->validacion["destino"] = "required";

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear TransferenciaProducto
            $request["fecha_registro"] = date("Y-m-d");
            $nueva_transferencia_producto = TransferenciaProducto::create(array_map('mb_strtoupper', $request->all()));


            /* ***********************************************
            * DECREMENTAR EL ORIGEN E INCREMENTAR EL DESTINO *
            ************************************************ */
            // disminuir el stock del ORIGEN
            if ($nueva_transferencia_producto->origen == 'ALMACEN') {
                // VALIDAR STOCK
                $stock_producto = Almacen::where("producto_id", $request->producto_id)->get()->first();
            } else {
                $stock_producto = SucursalStock::where("producto_id", $request->producto_id)->get()->first();
            }
            // VALIDAR STOCK
            if ($stock_producto->stock_actual < $request->cantidad) {
                throw new Exception('No es posible realizar el registro debido a que la cantidad supera al stock disponible ' . $stock_producto->stock_actual);
            }

            KardexProducto::registroEgreso($nueva_transferencia_producto->origen, "TRANSFERENCIA", $nueva_transferencia_producto->id, $nueva_transferencia_producto->producto, $nueva_transferencia_producto->cantidad, $nueva_transferencia_producto->producto->precio, $nueva_transferencia_producto->descripcion);

            // incrementar el stock del DESTINO
            KardexProducto::registroIngreso($nueva_transferencia_producto->destino, "TRANSFERENCIA", $nueva_transferencia_producto->id, $nueva_transferencia_producto->producto, $nueva_transferencia_producto->cantidad, $nueva_transferencia_producto->producto->precio, $nueva_transferencia_producto->descripcion);

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_transferencia_producto, "transferencia_productos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REALIZÓ UNA TRANSFERENCIA DE PRODUCTOS',
                'datos_original' => $datos_original,
                'modulo' => 'TRANSFERENCIA DE PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'transferencia_producto' => $nueva_transferencia_producto,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, TransferenciaProducto $transferencia_producto)
    {
        $request->validate($this->validacion, $this->mensajes);


        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            if ($transferencia_producto->producto->descontar_stock == 'SI') {
                // incrementar el stock del origen
                Producto::incrementarStock($transferencia_producto->producto, $transferencia_producto->cantidad, $transferencia_producto->origen);
                $stock_producto = null;
                if ($transferencia_producto->origen == 'ALMACEN') {
                    $stock_producto = Almacen::where("producto_id", $transferencia_producto->producto_id)
                        ->get()->first();
                } else {
                    $stock_producto = SucursalStock::where("producto_id", $transferencia_producto->producto_id)
                        ->get()->first();
                }
                if ($stock_producto->stock_actual < $request->cantidad) {
                    throw new Exception('No es posible realizar el registro debido a que la cantidad supera al stock disponible ' . $stock_producto->stock_actual);
                }

                // decrementar el stock del destino
                Producto::decrementarStock($transferencia_producto->producto, $transferencia_producto->cantidad, $transferencia_producto->destino);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($transferencia_producto, "transferencia_productos");
            $transferencia_producto->update(array_map('mb_strtoupper', $request->all()));

            /* ***********************************************
                * DECREMENTAR EL ORIGEN E INCREMENTAR EL DESTINO *
                ************************************************ */
            // disminuir el stock del ORIGEN
            Producto::decrementarStock($transferencia_producto->producto, $transferencia_producto->cantidad, $transferencia_producto->origen);
            // actualizar kardex
            $kardex = KardexProducto::where("lugar", $transferencia_producto->origen)
                ->where("producto_id", $transferencia_producto->producto_id)
                ->where("tipo_registro", "TRANSFERENCIA")
                ->where("registro_id", $transferencia_producto->id)
                ->get()->first();
            KardexProducto::actualizaRegistrosKardex($kardex->id, $kardex->producto_id, $transferencia_producto->origen);

            // incrementar el stock del DESTINO
            Producto::incrementarStock($transferencia_producto->producto, $transferencia_producto->cantidad, $transferencia_producto->destino);
            // actualizar kardex
            $kardex = KardexProducto::where("lugar", $transferencia_producto->destino)
                ->where("producto_id", $transferencia_producto->producto_id)
                ->where("tipo_registro", "TRANSFERENCIA")
                ->where("registro_id", $transferencia_producto->id)
                ->get()->first();
            KardexProducto::actualizaRegistrosKardex($kardex->id, $kardex->producto_id, $transferencia_producto->destino);

            $datos_nuevo = HistorialAccion::getDetalleRegistro($transferencia_producto, "transferencia_productos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA TRANSFERENCIA DE PRODUCTOS',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'TRANSFERENCIA DE PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'transferencia_producto' => $transferencia_producto,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(TransferenciaProducto $transferencia_producto)
    {
        return response()->JSON([
            'sw' => true,
            'transferencia_producto' => $transferencia_producto
        ], 200);
    }

    public function destroy(TransferenciaProducto $transferencia_producto)
    {
        DB::beginTransaction();
        try {
            /********************
             * ORIGEN
             ******************/
            $eliminar_kardex = KardexProducto::where("lugar", $transferencia_producto->origen)
                ->where("tipo_registro", "TRANSFERENCIA")
                ->where("registro_id", $transferencia_producto->id)
                ->where("producto_id", $transferencia_producto->producto_id)
                ->get()
                ->first();
            $id_kardex = $eliminar_kardex->id;
            $id_producto = $eliminar_kardex->producto_id;
            $eliminar_kardex->delete();

            $anterior = KardexProducto::where("lugar", $transferencia_producto->origen)
                ->where("producto_id", $id_producto)
                ->where("id", "<", $id_kardex)
                ->get()
                ->last();
            $actualiza_desde = null;
            if ($anterior) {
                $actualiza_desde = $anterior;
            } else {
                // comprobar si existen registros posteriorres al actualizado
                $siguiente = KardexProducto::where("lugar", $transferencia_producto->origen)
                    ->where("producto_id", $id_producto)
                    ->where("id", ">", $id_kardex)
                    ->get()
                    ->last();
                if ($siguiente)
                    $actualiza_desde = $siguiente;
            }

            if ($actualiza_desde) {
                // actualizar a partir de este registro los sgtes. registros
                KardexProducto::actualizaRegistrosKardex($actualiza_desde->id, $actualiza_desde->producto_id, $transferencia_producto->origen, $transferencia_producto->origen_id);
            }
            // incrementar el stock
            Producto::incrementarStock($transferencia_producto->producto, $transferencia_producto->cantidad, $transferencia_producto->origen, $transferencia_producto->origen_id);

            /********************
             * DESTINO
             ******************/
            $eliminar_kardex = KardexProducto::where("lugar", $transferencia_producto->destino)
                ->where("tipo_registro", "TRANSFERENCIA")
                ->where("registro_id", $transferencia_producto->id)
                ->where("producto_id", $transferencia_producto->producto_id)
                ->get()
                ->first();
            $id_kardex = $eliminar_kardex->id;
            $id_producto = $eliminar_kardex->producto_id;
            $eliminar_kardex->delete();

            $anterior = KardexProducto::where("lugar", $transferencia_producto->destino)
                ->where("producto_id", $id_producto)
                ->where("id", "<", $id_kardex)
                ->get()
                ->last();
            $actualiza_desde = null;
            if ($anterior) {
                $actualiza_desde = $anterior;
            } else {
                // comprobar si existen registros posteriorres al actualizado
                $siguiente = KardexProducto::where("lugar", $transferencia_producto->destino)
                    ->where("producto_id", $id_producto)
                    ->where("id", ">", $id_kardex)
                    ->get()
                    ->last();
                if ($siguiente)
                    $actualiza_desde = $siguiente;
            }

            if ($actualiza_desde) {
                // actualizar a partir de este registro los sgtes. registros
                KardexProducto::actualizaRegistrosKardex($actualiza_desde->id, $actualiza_desde->producto_id, $transferencia_producto->destino, $transferencia_producto->destino_id);
            }
            // descontar el stock
            Producto::decrementarStock($transferencia_producto->producto, $transferencia_producto->cantidad, $transferencia_producto->destino, $transferencia_producto->destino_id);

            $datos_original = HistorialAccion::getDetalleRegistro($transferencia_producto, "transferencia_productos");
            $transferencia_producto->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA TRANSFERENCIA DE PRODUCTOS',
                'datos_original' => $datos_original,
                'modulo' => 'TRANSFERENCIA DE PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
