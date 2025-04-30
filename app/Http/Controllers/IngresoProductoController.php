<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\KardexProducto;
use App\Models\Producto;
use App\Services\HistorialAccionService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class IngresoProductoController extends Controller
{
    public $validacion = [
        'producto_id' => 'required',
        'proveedor_id' => 'required',
        'precio_compra' => 'required|numeric|min:0.01',
        'lote' => 'required',
        'fecha_fabricacion' => 'required',
        'cantidad' => 'required|integer|min:1',
        'tipo_ingreso_id' => 'required',
        'descripcion' => 'required|min:2|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ0-9]+$/u',
    ];

    public $mensajes = [
        'descripcion.min' => 'Debes ingresar al menos :min caracteres',
        'descripcion.regex' => 'Debes ingresar solo texto',
        "precio_compra.required" => "Este campo es obligatorio",
        "precio_compra.numeric" => "Debes ingresar un valor númerico",
        "precio_compra.min" => "Debes ingresar un valor mayor o igual a :min",
        "cantidad.required" => "Este campo es obligatorio",
        "cantidad.integer" => "Debes ingresar un valor entero",
        "cantidad.min" => "Debes ingresar un valor mayor o igual a :min",
    ];
    private $modulo = "INGRESO DE PRODUCTOS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function index(Request $request)
    {
        $ingreso_productos = IngresoProducto::with("producto")
            ->with("proveedor")
            ->with("tipo_ingreso")
            ->where("status", 1)
            ->orderBy("id", "desc")
            ->get();
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

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN INGRESO DE PRODUCTO", $nuevo_ingreso_producto);

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

                $old_ingreso_producto = clone $ingreso_producto;
                $ingreso_producto->update(array_map('mb_strtoupper', $request->all()));

                // INCREMENTAR STOCK
                Producto::incrementarStock($ingreso_producto->producto, $ingreso_producto->cantidad);

                // actualizar kardex
                $kardex = KardexProducto::where("producto_id", $ingreso_producto->producto_id)
                    ->where("tipo_registro", "INGRESO")
                    ->where("registro_id", $ingreso_producto->id)
                    ->where("status", 1)
                    ->get()->first();
                KardexProducto::actualizaRegistrosKardex($kardex->id, $kardex->producto_id);

                // registrar accion
                $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN INGRESO DE PRODUCTO", $old_ingreso_producto, $ingreso_producto);

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

            // descontar el stock
            Producto::decrementarStock($ingreso_producto->producto, $ingreso_producto->cantidad);
            $old_ingreso_producto = clone $ingreso_producto;
            // $ingreso_producto->delete();
            $ingreso_producto->status = 0;
            $ingreso_producto->save();

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN INGRESO DE PRODUCTO", $old_ingreso_producto);

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
