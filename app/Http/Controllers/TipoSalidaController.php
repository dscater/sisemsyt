<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\SalidaProducto;
use App\Models\TipoSalida;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TipoSalidaController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $tipo_salidas = TipoSalida::all();
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

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_tipo_salida, "tipo_salidas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN TIPO DE SALIDA',
                'datos_original' => $datos_original,
                'modulo' => 'TIPO DE SALIDAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

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
            $datos_original = HistorialAccion::getDetalleRegistro($tipo_salida, "tipo_salidas");
            $tipo_salida->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($tipo_salida, "tipo_salidas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN TIPO DE SALIDA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'TIPO DE SALIDAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

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

            $datos_original = HistorialAccion::getDetalleRegistro($tipo_salida, "tipo_salidas");
            $tipo_salida->delete();

            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN TIPO DE SALIDA',
                'datos_original' => $datos_original,
                'modulo' => 'TIPO DE SALIDAS',
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
