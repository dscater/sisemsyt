<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\TipoIngreso;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TipoIngresoController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $tipo_ingresos = TipoIngreso::all();
        return response()->JSON(['tipo_ingresos' => $tipo_ingresos, 'total' => count($tipo_ingresos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear TipoIngreso
            $nuevo_tipo_ingreso = TipoIngreso::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_tipo_ingreso, "tipo_ingresos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN TIPO DE INGRESO',
                'datos_original' => $datos_original,
                'modulo' => 'TIPO DE INGRESOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

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
            $datos_original = HistorialAccion::getDetalleRegistro($tipo_ingreso, "tipo_ingresos");
            $tipo_ingreso->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($tipo_ingreso, "tipo_ingresos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN TIPO DE INGRESO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'TIPO DE INGRESOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

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

            $datos_original = HistorialAccion::getDetalleRegistro($tipo_ingreso, "tipo_ingresos");
            $tipo_ingreso->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN TIPO DE INGRESO',
                'datos_original' => $datos_original,
                'modulo' => 'TIPO DE INGRESOS',
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
