<?php

namespace App\Http\Controllers;

use App\Models\Alerta;
use App\Models\Cliente;
use App\Models\HistorialAccion;
use App\Models\MaestroRegistro;
use App\Models\Nota;
use App\Models\Notificacion;
use App\Models\Venta;
use App\Models\Producto;
use App\Models\SeguimientoAprobado;
use App\Models\SeguimientoRectificacion;
use App\Models\SeguimientoTramite;
use App\Models\Tcont;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:4',
        'paterno' => 'required|min:4',
        'ci' => 'required|numeric|digits_between:4, 20|unique:users,ci',
        'ci_exp' => 'required',
        'dir' => 'required|min:4',
        'fono' => 'required|min:1',
        'tipo' => 'required',
        'acceso' => 'required',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.min' => 'Debes ingressar al menos 4 carácteres',
        'paterno.required' => 'Este campo es obligatorio',
        'paterno.min' => 'Debes ingresar al menos 4 carácteres',
        'ci.required' => 'Este campo es obligatorio',
        'ci.numeric' => 'Debes ingresar un valor númerico',
        'ci.unique' => 'Este número de C.I. ya fue registrado',
        'ci_exp.required' => 'Este campo es obligatorio',
        'dir.required' => 'Este campo es obligatorio',
        'dir.min' => 'Debes ingresar al menos 4 carácteres',
        'fono.required' => 'Este campo es obligatorio',
        'fono.min' => 'Debes ingresar al menos 4 carácteres',
        'cel.required' => 'Este campo es obligatorio',
        'cel.min' => 'Debes ingresar al menos 4 carácteres',
        'tipo.required' => 'Este campo es obligatorio',
        'correo' => 'nullable|email|unique:users,correo',
    ];

    public $permisos = [
        'ADMINISTRADOR' => [
            'usuarios.index',
            'usuarios.create',
            'usuarios.edit',
            'usuarios.destroy',

            'proveedors.index',
            'proveedors.create',
            'proveedors.edit',
            'proveedors.destroy',

            'productos.index',
            'productos.create',
            'productos.edit',
            'productos.destroy',

            'categorias.index',
            'categorias.create',
            'categorias.edit',
            'categorias.destroy',

            'tipo_ingresos.index',
            'tipo_ingresos.create',
            'tipo_ingresos.edit',
            'tipo_ingresos.destroy',

            'ingreso_productos.index',
            'ingreso_productos.create',
            'ingreso_productos.edit',
            'ingreso_productos.destroy',

            'tipo_salidas.index',
            'tipo_salidas.create',
            'tipo_salidas.edit',
            'tipo_salidas.destroy',

            'salida_productos.index',
            'salida_productos.create',
            'salida_productos.edit',
            'salida_productos.destroy',

            'clientes.index',
            'clientes.create',
            'clientes.edit',
            'clientes.destroy',

            'ventas.index',
            'ventas.create',
            'ventas.edit',
            'ventas.destroy',

            'configuracion.index',
            'configuracion.edit',

            "analisis_inventarios",
            "analisis_proveedores",
            "analisis_ventas",
            "analisis_clientes",
            "analisis_suministro",
            "analisis_consumo",

            "notificacion_users.index",

            'reportes.usuarios',
            'reportes.kardex',
            'reportes.ventas',
            'reportes.stock_productos',
            'reportes.historial_acciones',
        ],
        'GERENCIA' => [
            "analisis_inventarios",
            "analisis_proveedores",
            "analisis_ventas",
            "analisis_clientes",

            'reportes.kardex',
            'reportes.ventas',
            'reportes.stock_productos',
            'reportes.historial_acciones',
        ],
        'SUPERVISOR' => [
            'proveedors.index',
            'proveedors.create',
            'proveedors.edit',
            'proveedors.destroy',

            'productos.index',
            'productos.create',
            'productos.edit',
            'productos.destroy',

            'categorias.index',
            'categorias.create',
            'categorias.edit',
            'categorias.destroy',

            'tipo_ingresos.index',
            'tipo_ingresos.create',
            'tipo_ingresos.edit',
            'tipo_ingresos.destroy',

            'ingreso_productos.index',
            'ingreso_productos.create',
            'ingreso_productos.edit',
            'ingreso_productos.destroy',

            'tipo_salidas.index',
            'tipo_salidas.create',
            'tipo_salidas.edit',
            'tipo_salidas.destroy',

            'salida_productos.index',
            'salida_productos.create',
            'salida_productos.edit',
            'salida_productos.destroy',

            'clientes.index',
            'clientes.create',
            'clientes.edit',
            'clientes.destroy',

            'ventas.index',
            'ventas.create',
            'ventas.edit',
            'ventas.destroy',

            "analisis_inventarios",
            "analisis_proveedores",
            "analisis_ventas",
            "analisis_clientes",

            'reportes.kardex',
            'reportes.ventas',
            'reportes.stock_productos',
            'reportes.historial_acciones',
        ],
        'VENDEDOR' => [
            'clientes.index',
            'clientes.create',
            'clientes.edit',
            'clientes.destroy',

            'ventas.index',
            'ventas.create',
            'ventas.edit',

            'reportes.kardex',
            'reportes.ventas',
            'reportes.stock_productos',
        ],
    ];


    public function index(Request $request)
    {
        $usuarios = User::where('id', '!=', 1)->get();
        return response()->JSON(['usuarios' => $usuarios, 'total' => count($usuarios)], 200);
    }

    public function store(Request $request)
    {
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }

        $request->validate($this->validacion, $this->mensajes);
        $cont = 0;
        do {
            $nombre_usuario = User::getNombreUsuario($request->nombre, $request->paterno);
            if ($cont > 0) {
                $nombre_usuario = $nombre_usuario . $cont;
            }
            $request['usuario'] = $nombre_usuario;
            $cont++;
        } while (User::where('usuario', $nombre_usuario)->get()->first());
        $request['password'] = 'NoNulo';
        $request['fecha_registro'] = date('Y-m-d');

        DB::beginTransaction();
        try {
            // crear el Usuario
            $nuevo_usuario = User::create(array_map('mb_strtoupper', $request->except('foto')));
            $nuevo_usuario->password = Hash::make($request->ci);
            $nuevo_usuario->save();
            $nuevo_usuario->foto = 'default.png';
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . '_' . $nuevo_usuario->usuario . '.' . $file->getClientOriginalExtension();
                $nuevo_usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $nuevo_usuario->correo = mb_strtolower($nuevo_usuario->correo);
            $nuevo_usuario->save();

            if ($nuevo_usuario->tipo == 'CAJA') {
                $nuevo_usuario->caja_usuario()->create([
                    "caja_id" => $request->caja_id,
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_usuario, "users");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN USUARIO',
                'datos_original' => $datos_original,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $nuevo_usuario,
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

    public function update(Request $request, User $usuario)
    {
        $this->validacion['ci'] = 'required|min:4|numeric|unique:users,ci,' . $usuario->id;
        $this->validacion['correo'] = 'nullable|email|unique:users,correo,' . $usuario->id;
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }
        if ($request->tipo == 'CAJA') {
            $this->validacion['caja_id'] = 'required';
        }

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($usuario, "users");
            $usuario->update(array_map('mb_strtoupper', $request->except('foto')));
            if ($usuario->correo == "") {
                $usuario->correo = NULL;
            }

            if ($request->hasFile('foto')) {
                $antiguo = $usuario->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/users/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $usuario->usuario . '.' . $file->getClientOriginalExtension();
                $usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $usuario->correo = mb_strtolower($usuario->correo);
            $usuario->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($usuario, "users");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN USUARIO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $usuario,
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

    public function show(User $usuario)
    {
        return response()->JSON([
            'sw' => true,
            'usuario' => $usuario
        ], 200);
    }

    public function actualizaContrasenia(User $usuario, Request $request)
    {
        $request->validate([
            'password_actual' => ['required', function ($attribute, $value, $fail) use ($usuario, $request) {
                if (!\Hash::check($request->password_actual, $usuario->password)) {
                    return $fail(__('La contraseña no coincide con la actual.'));
                }
            }],
            'password' => 'required|confirmed|min:4',
            'password_confirmation' => 'required|min:4'
        ]);


        DB::beginTransaction();
        try {
            $usuario->password = Hash::make($request->password);
            $usuario->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'La contraseña se actualizó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function actualizaFoto(User $usuario, Request $request)
    {
        DB::beginTransaction();
        try {

            if ($request->hasFile('foto')) {
                $antiguo = $usuario->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/users/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $usuario->usuario . '.' . $file->getClientOriginalExtension();
                $usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $usuario->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $usuario,
                'msj' => 'Foto actualizada con éxito'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroy(User $usuario)
    {
        DB::beginTransaction();
        try {
            $antiguo = $usuario->foto;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/users/' . $antiguo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($usuario, "users");
            $usuario->delete();

            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN USUARIO',
                'datos_original' => $datos_original,
                'modulo' => 'USUARIOS',
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

    public function getPermisos(User $usuario)
    {
        $tipo = $usuario->tipo;
        return response()->JSON($this->permisos[$tipo]);
    }

    public function getInfoBox()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];
        if (in_array('usuarios.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Usuarios',
                'cantidad' => count(User::where('id', '!=', 1)->get()),
                'color' => 'bg-info',
                'icon' => 'fas fa-users',
            ];
        }
        if (in_array('clientes.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Clientes',
                'cantidad' => count(User::where('id', '!=', 1)->get()),
                'color' => 'bg-success',
                'icon' => 'fas fa-users',
            ];
        }

        if (in_array('ventas.index', $this->permisos[$tipo])) {
            $ventas = Venta::all();
            $array_infos[] = [
                'label' => 'Ventas',
                'cantidad' => count($ventas),
                'color' => 'bg-primary',
                'icon' => 'fas fa-cash-register',
            ];
        }

        if (in_array('productos.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Productos',
                'cantidad' => count(Producto::all()),
                'color' => 'bg-danger',
                'icon' => 'fas fa-box',
            ];
        }

        return response()->JSON($array_infos);
    }

    public function userActual()
    {
        return response()->JSON(Auth::user());
    }

    public function getUsuario(User $usuario)
    {
        return response()->JSON($usuario);
    }
}
