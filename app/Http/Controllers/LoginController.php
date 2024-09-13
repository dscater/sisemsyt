<?php

namespace App\Http\Controllers;

use App\Models\Notificacion;
use App\Models\NotificacionUser;
use App\Models\Producto;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $usuario = $request->usuario;
        $password = $request->password;
        $res = Auth::attempt(['usuario' => $usuario, 'password' => $password, 'acceso' => 1]);
        if ($res) {
            self::notificacion1();
            self::notificacion2();
            self::notificacion3();

            return response()->JSON([
                'user' => Auth::user(),
            ], 200);
        }

        return response()->JSON([], 401);
    }

    public function logout()
    {
        Auth::logout();
        return response()->JSON(['code' => 204], 204);
    }

    public static function notificacion1()
    {
        $fecha_actual = date("Y-m-d");
        $hora = date("H:i:s");

        $productos = Producto::whereRaw('stock_min = stock_actual - 5')->get();
        $usuarios = User::all();
        foreach ($productos as $producto) {
            $notificacion = Notificacion::where("tipo", "A 5 STOCK MINIMO")
                ->where("fecha", $fecha_actual)
                ->where("registro_id", $producto->id)
                ->get()->first();
            if (!$notificacion) {
                $notificacion =  Notificacion::create([
                    "tipo" => "A 5 STOCK MINIMO",
                    "registro_id" => $producto->id,
                    "descripcion" => "EL PRODUCTO " . $producto->nombre . " SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO",
                    "fecha" => $fecha_actual,
                    "hora" => $hora,
                ]);
            }
            foreach ($usuarios as $user) {
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
    }

    public static function notificacion2()
    {
        $fecha_actual = date("Y-m-d");
        $hora = date("H:i:s");
        $productos = Producto::whereRaw('stock_min = stock_actual')->get();
        $usuarios = User::all();
        foreach ($productos as $producto) {
            $notificacion = Notificacion::where("tipo", "STOCK MINIMO")
                ->where("fecha", $fecha_actual)
                ->where("registro_id", $producto->id)
                ->get()->first();
            if (!$notificacion) {
                $notificacion =  Notificacion::create([
                    "tipo" => "STOCK MINIMO",
                    "registro_id" => $producto->id,
                    "descripcion" => "EL PRODUCTO " . $producto->nombre . " SE ENCUENTRA EN STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO",
                    "fecha" => $fecha_actual,
                    "hora" => $hora,
                ]);
            }
            foreach ($usuarios as $user) {
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
    }

    public static function notificacion3()
    {
        $fecha_actual = date("Y-m-d");
        $hora = date("H:i:s");
        $productos = Producto::whereRaw('stock_min < stock_actual')->get();
        $usuarios = User::all();
        foreach ($productos as $producto) {
            $notificacion = Notificacion::where("tipo", "STOCK MINIMO")
                ->where("fecha", $fecha_actual)
                ->where("registro_id", $producto->id)
                ->get()->first();
            if (!$notificacion) {
                $notificacion =  Notificacion::create([
                    "tipo" => "STOCK MINIMO",
                    "registro_id" => $producto->id,
                    "descripcion" => "ALERTA URGENTE EL PRODUCTO " . $producto->nombre . " SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA",
                    "fecha" => $fecha_actual,
                    "hora" => $hora,
                ]);
            }
            foreach ($usuarios as $user) {
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
    }
}
