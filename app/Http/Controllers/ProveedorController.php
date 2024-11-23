<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\Proveedor;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ProveedorController extends Controller
{
    public $validacion = [
        'razon_social' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'nit' => 'required|numeric|digits_between:7,20',
        'fono' => 'required',
        'dir' => 'required|regex:/^[\pL\s\.\'\"\,0-9áéíóúÁÉÍÓÚñÑ]+$/u',
        'nombre_contacto' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'descripcion' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
    ];

    public $mensajes = [
        'razon_social.required' => 'Este campo es obligatorio',
        'razon_social.regex' => 'Debes ingresar solo texto',
        'nit.required' => 'Este campo es obligatorio',
        'nit.numeric' => 'Debes ingresar un número',
        'nit.digits_between' => 'Debes ingresar minimo 7 dígitos',
        'dir.required' => 'Este campo es obligatorio',
        'dir.regex' => 'No se permiten simbolos',
        'nombre_contacto.required' => 'Este campo es obligatorio',
        'nombre_contacto.regex' => 'Debes ingresar solo texto',
        'descripcion.required' => 'Este campo es obligatorio',
        'descripcion.regex' => 'Debes ingresar solo texto',
        'fono.required' => 'Este campo es obligatorio',
        'fono.numeric' => 'Debes ingresar un número',
        'fono.digits_between' => 'Debes ingresar minimo 7 dígitos',
    ];

    public function index(Request $request)
    {
        $proveedors = Proveedor::where("status", 1)->get();
        return response()->JSON(['proveedors' => $proveedors, 'total' => count($proveedors)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $telefonos = explode(';', $request->input('fono'));
        $errores = [];
        foreach ($telefonos as $index => $telefono) {
            $data = ['telefono' => trim($telefono)];
            $validator = Validator::make($data, [
                'telefono' => 'required|numeric|digits_between:7,20',
            ]);
            if ($validator->fails()) {
                $errores["fono"][] = $validator->errors()->first('telefono');
                break;
            }
        }
        if (!empty($errores)) {
            return response()->json(['errors' => $errores], 422);
        }

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
        $telefonos = explode(';', $request->input('fono'));
        $errores = [];
        foreach ($telefonos as $index => $telefono) {
            $data = ['telefono' => trim($telefono)];
            $validator = Validator::make($data, [
                'telefono' => 'required|numeric|digits_between:7,20',
            ]);
            if ($validator->fails()) {
                $errores["fono"][] = $validator->errors()->first('telefono');
                break;
            }
        }
        if (!empty($errores)) {
            return response()->json(['errors' => $errores], 422);
        }


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
            $proveedor->status = 0;
            $proveedor->save();
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
