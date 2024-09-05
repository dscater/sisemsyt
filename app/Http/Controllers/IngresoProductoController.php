<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\KardexProducto;
use App\Models\Producto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class IngresoProductoController extends Controller
{
    public $validacion = [
        'producto_id' => 'required',
        'proveedor_id' => 'required',
        'precio_compra' => 'required|numeric',
        'lote' => 'required',
        'fecha_fabricacion' => 'required',
        'fecha_caducidad' => 'required',
        'cantidad' => 'required|numeric',
        'tipo_ingreso_id' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $ingreso_productos = IngresoProducto::with("producto")->with("proveedor")->with("tipo_ingreso")->get();
        return response()->JSON(['ingreso_productos' => $ingreso_productos, 'total' => count($ingreso_productos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear IngresoProducto
            $request["fecha_registro"] = date("Y-m-d");
            $nuevo_ingreso_producto = IngresoProducto::create(array_map('mb_strtoupper', $request->all()));

            // registrar kardex
            KardexProducto::registroIngreso("INGRESO", $nuevo_ingreso_producto->id, $nuevo_ingreso_producto->producto, $nuevo_ingreso_producto->cantidad, $nuevo_ingreso_producto->producto->precio, $nuevo_ingreso_producto->descripcion);

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_ingreso_producto, "ingreso_productos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN INGRESO DE PRODUCTO',
                'datos_original' => $datos_original,
                'modulo' => 'INGRESO DE PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'ingreso_producto' => $nuevo_ingreso_producto,
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

    public function update(Request $request, IngresoProducto $ingreso_producto)
    {
        $request->validate($this->validacion, $this->mensajes);
        if ($request->producto_id != $ingreso_producto->producto_id) {
            return response()->JSON([
                'sw' => false,
                'message' => "Error, los datos enviados son incorrectos",
            ], 500);
        } else {
            DB::beginTransaction();
            try {
                // descontar el stock
                Producto::decrementarStock($ingreso_producto->producto, $ingreso_producto->cantidad);

                $datos_original = HistorialAccion::getDetalleRegistro($ingreso_producto, "ingreso_productos");
                $ingreso_producto->update(array_map('mb_strtoupper', $request->all()));

                // INCREMENTAR STOCK
                Producto::incrementarStock($ingreso_producto->producto, $ingreso_producto->cantidad);

                // actualizar kardex
                $kardex = KardexProducto::where("producto_id", $ingreso_producto->producto_id)
                    ->where("tipo_registro", "INGRESO")
                    ->where("registro_id", $ingreso_producto->id)
                    ->get()->first();
                KardexProducto::actualizaRegistrosKardex($kardex->id, $kardex->producto_id);

                $datos_nuevo = HistorialAccion::getDetalleRegistro($ingreso_producto, "ingreso_productos");
                HistorialAccion::create([
                    'user_id' => Auth::user()->id,
                    'accion' => 'MODIFICACIÓN',
                    'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN INGRESO DE PRODUCTO',
                    'datos_original' => $datos_original,
                    'datos_nuevo' => $datos_nuevo,
                    'modulo' => 'INGRESO DE PRODUCTOS',
                    'fecha' => date('Y-m-d'),
                    'hora' => date('H:i:s')
                ]);

                DB::commit();

                return response()->JSON([
                    'sw' => true,
                    'ingreso_producto' => $ingreso_producto,
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
    }

    public function show(IngresoProducto $ingreso_producto)
    {
        return response()->JSON([
            'sw' => true,
            'ingreso_producto' => $ingreso_producto
        ], 200);
    }

    public function destroy(IngresoProducto $ingreso_producto)
    {
        DB::beginTransaction();
        try {
            $eliminar_kardex = KardexProducto::where("tipo_registro", "INGRESO")
                ->where("registro_id", $ingreso_producto->id)
                ->where("producto_id", $ingreso_producto->producto_id)
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

            // descontar el stock
            Producto::decrementarStock($ingreso_producto->producto, $ingreso_producto->cantidad);
            $datos_original = HistorialAccion::getDetalleRegistro($ingreso_producto, "ingreso_productos");
            $ingreso_producto->delete();

            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN INGRESO DE PRODUCTO',
                'datos_original' => $datos_original,
                'modulo' => 'INGRESO DE PRODUCTOS',
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
