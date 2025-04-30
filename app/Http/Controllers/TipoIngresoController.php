<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\TipoIngreso;
use App\Services\HistorialAccionService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TipoIngresoController extends Controller
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
    private $modulo = "TIPO DE INGRESOS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function index(Request $request)
    {
        $tipo_ingresos = TipoIngreso::where("status", 1)
            ->orderBy("id", "desc")->get();
        return response()->JSON(['tipo_ingresos' => $tipo_ingresos, 'total' => count($tipo_ingresos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear TipoIngreso
            $nuevo_tipo_ingreso = TipoIngreso::create(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN TIPO DE INGRESO", $nuevo_tipo_ingreso);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'tipo_ingreso' => $nuevo_tipo_ingreso,
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

    public function update(Request $request, TipoIngreso $tipo_ingreso)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $old_tipo_ingreso = clone $tipo_ingreso;
            $tipo_ingreso->update(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN TIPO DE INGRESO", $old_tipo_ingreso, $tipo_ingreso);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'tipo_ingreso' => $tipo_ingreso,
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

    public function show(TipoIngreso $tipo_ingreso)
    {
        return response()->JSON([
            'sw' => true,
            'tipo_ingreso' => $tipo_ingreso
        ], 200);
    }

    public function destroy(TipoIngreso $tipo_ingreso)
    {
        DB::beginTransaction();
        try {
            $existe = IngresoProducto::where("tipo_ingreso_id", $tipo_ingreso->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $old_tipo_ingreso = clone $tipo_ingreso;
            // $tipo_ingreso->delete();
            $tipo_ingreso->status = 0;
            $tipo_ingreso->save();
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN TIPO DE INGRESO", $old_tipo_ingreso);
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
