<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ClienteController extends Controller
{
    public $validacion = [
        'nombre' => 'required',
        'ci' => 'required',
        'ci_exp' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $clientes = Cliente::all();
        return response()->JSON(['clientes' => $clientes, 'total' => count($clientes)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

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
            $cliente->delete();
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
