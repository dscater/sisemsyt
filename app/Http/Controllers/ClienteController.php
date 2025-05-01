<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\HistorialAccion;
use App\Services\HistorialAccionService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class ClienteController extends Controller
{
    public $validacion = [
        'nombre' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'ci' => 'required|numeric|digits_between:7,20|unique:clientes,ci',
        'ci_exp' => 'required',
        'fono' => 'required',
        'nit' => 'required|numeric|unique:clientes,nit',
        'correo' => 'required|email',
        'dir' => 'required|regex:/^[\pL\s\.\'\"\#\,0-9áéíóúÁÉÍÓÚñÑ]+$/uu',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.regex' => 'Debes ingresar solo texto',
        'ci.required' => 'Este campo es obligatorio',
        'ci.numeric' => 'Debes ingresar solo números',
        'ci.digits_between' => 'Debes ingresar por lo menos 7 dígitos',
        'ci.unique' => 'Este número de C.I. ya fue registrado',
        'ci_exp.required' => 'Este campo es obligatorio',
        'nit.required' => 'Este campo es obligatorio',
        'nit.numeric' => 'Debes ingresar solo números',
        'nit.unique' => 'Este NIT ya fue registrado',
        'fono.required' => 'Este campo es obligatorio',
        'fono.numeric' => 'El formato del texto es incorrecto',
        'fono.digits_between' => 'Debes ingresar por lo menos 7 dígitos',
        'correo.required' => 'Este campo es obligatorio',
        'correo.email' => 'El formato del texto debe ser de un correo',
        'dir.required' => 'Este campo es obligatorio',
        'dir.regex' => 'El formato del texto es incorrecto',
    ];
    private $modulo = "CLIENTES";

    public function __construct(private HistorialAccionService $historialAccionService) {}
    public function index(Request $request)
    {
        $clientes = Cliente::where("status", 1)->orderBy("id", "desc")->get();
        return response()->JSON(['clientes' => $clientes, 'total' => count($clientes)], 200);
    }

    public function store(Request $request)
    {
        if (isset($request["venta"])) {
            $this->validacion["fono"] = "nullable";
            $this->validacion["correo"] = "nullable|email";
            $this->validacion["dir"] = "nullable|regex:/^[\pL\s\.\'\"\#\,0-9áéíóúÁÉÍÓÚñÑ]+$/uu";
            $request["fono"] = $request["fono"] ?? NULL;
        }

        $request->validate($this->validacion, $this->mensajes);
        $telefonos = explode(';', $request->input('fono'));
        $errores = [];
        if (!isset($request["venta"])) {
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
        }
        if (!empty($errores)) {
            return response()->json(['errors' => $errores], 422);
        }

        DB::beginTransaction();
        try {
            // crear Cliente
            $request["fecha_registro"] = date("Y-m-d");
            $nuevo_cliente = Cliente::create(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CLIENTE", $nuevo_cliente);

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
        $this->validacion["ci"] = "required|numeric|digits_between:7,20|unique:clientes,ci," . $cliente->id;
        $this->validacion["nit"] = "required|numeric|unique:clientes,nit," . $cliente->id;
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
            $old_cliente = clone $cliente;
            $cliente->update(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CLIENTE", $old_cliente, $cliente);

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
            $old_cliente = clone $cliente;
            $cliente->status = 0;
            $cliente->save();
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CLIENTE", $old_cliente);
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
