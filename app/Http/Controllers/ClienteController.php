<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class ClienteController extends Controller
{
    public $validacion = [
        'nombre' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'ci' => 'required|numeric|digits_between:7,20',
        'ci_exp' => 'required',
        'fono' => 'required',
        'nit' => 'required|numeric',
        'correo' => 'required|email',
        'dir' => 'required|regex:/^[\pL\s\.\'\"\#\,0-9áéíóúÁÉÍÓÚñÑ]+$/uu',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.regex' => 'Debes ingresar solo texto',
        'ci.required' => 'Este campo es obligatorio',
        'ci.numeric' => 'Debes ingresar solo números',
        'ci.digits_between' => 'Debes ingresar por lo menos 7 dígitos',
        'ci_exp.required' => 'Este campo es obligatorio',
        'nit.required' => 'Este campo es obligatorio',
        'nit.numeric' => 'Debes ingresar solo números',
        'fono.required' => 'Este campo es obligatorio',
        'fono.numeric' => 'El formato del texto es incorrecto',
        'fono.digits_between' => 'Debes ingresar por lo menos 7 dígitos',
        'correo.required' => 'Este campo es obligatorio',
        'correo.email' => 'El formato del texto debe ser de un correo',
        'dir.required' => 'Este campo es obligatorio',
        'dir.regex' => 'El formato del texto es incorrecto',
    ];

    public function index(Request $request)
    {
        $clientes = Cliente::where("status", 1)->get();
        return response()->JSON(['clientes' => $clientes, 'total' => count($clientes)], 200);
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
            // crear Cliente
            $request["fecha_registro"] = date("Y-m-d");
            $nuevo_cliente = Cliente::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_cliente, "clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN CLIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cliente' => $nuevo_cliente,
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

    public function update(Request $request, Cliente $cliente)
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
            $datos_original = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            $cliente->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cliente' => $cliente,
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

    public function show(Cliente $cliente)
    {
        return response()->JSON([
            'sw' => true,
            'cliente' => $cliente
        ], 200);
    }

    public function destroy(Cliente $cliente)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            $cliente->status = 0;
            $cliente->save();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'CLIENTES',
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
