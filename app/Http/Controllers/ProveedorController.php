<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\Proveedor;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ProveedorController extends Controller
{
    public $validacion = [
        'razon_social' => 'required',
        'fono' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $proveedors = Proveedor::all();
        return response()->JSON(['proveedors' => $proveedors, 'total' => count($proveedors)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Proveedor
            $request["fecha_registro"] = date("Y-m-d");
            $nuevo_proveedor = Proveedor::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_proveedor, "proveedors");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PROVEEDOR',
                'datos_original' => $datos_original,
                'modulo' => 'PROVEEDORES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'proveedor' => $nuevo_proveedor,
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

    public function update(Request $request, Proveedor $proveedor)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($proveedor, "proveedors");
            $proveedor->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($proveedor, "proveedors");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PROVEEDOR',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PROVEEDORES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'proveedor' => $proveedor,
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

    public function show(Proveedor $proveedor)
    {
        return response()->JSON([
            'sw' => true,
            'proveedor' => $proveedor
        ], 200);
    }

    public function destroy(Proveedor $proveedor)
    {
        DB::beginTransaction();
        try {
            $ingresos = IngresoProducto::where("proveedor_id", $proveedor->id)->get();
            if (count($ingresos) > 0) {
                throw new Exception("No es posible eliminar este registro porque esta siendo utlizado");
            }

            $datos_original = HistorialAccion::getDetalleRegistro($proveedor, "proveedors");
            $proveedor->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PROVEEDOR',
                'datos_original' => $datos_original,
                'modulo' => 'PROVEEDORES',
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
