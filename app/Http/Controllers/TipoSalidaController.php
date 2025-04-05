<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\SalidaProducto;
use App\Models\TipoSalida;
use App\Services\HistorialAccionService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TipoSalidaController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'descripcion' => 'required|min:2|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.min' => 'Debes ingresar al menos :min caracteres',
        'nombre.regex' => 'Debes ingresar solo texto',
        'descripcion.required' => 'Este campo es obligatorio',
        'descripcion.min' => 'Debes ingresar al menos :min caracteres',
        'descripcion.regex' => 'Debes ingresar solo texto',
    ];

    private $modulo = "TIPO DE SALIDAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function index(Request $request)
    {
        $tipo_salidas = TipoSalida::where("status", 1)->get();
        return response()->JSON(['tipo_salidas' => $tipo_salidas, 'total' => count($tipo_salidas)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear TipoSalida
            $request["fecha_registro"] = date("Y-m-d");
            $nuevo_tipo_salida = TipoSalida::create(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN TIPO DE SALIDA", $nuevo_tipo_salida);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'tipo_salida' => $nuevo_tipo_salida,
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

    public function update(Request $request, TipoSalida $tipo_salida)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $old_tipo_salida = clone $tipo_salida;
            $tipo_salida->update(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN TIPO DE SALIDA", $old_tipo_salida, $tipo_salida);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'tipo_salida' => $tipo_salida,
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

    public function show(TipoSalida $tipo_salida)
    {
        return response()->JSON([
            'sw' => true,
            'tipo_salida' => $tipo_salida
        ], 200);
    }

    public function destroy(TipoSalida $tipo_salida)
    {
        DB::beginTransaction();
        try {
            $existe = SalidaProducto::where("tipo_salida_id", $tipo_salida->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $old_tipo_salida = clone $tipo_salida;
            $tipo_salida->status = 0;
            $tipo_salida->save();

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN TIPO DE SALIDA", $old_tipo_salida);

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
