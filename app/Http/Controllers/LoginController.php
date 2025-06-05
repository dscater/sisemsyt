<?php

namespace App\Http\Controllers;

use App\Mail\CodigoAuthMail;
use App\Models\Configuracion;
use App\Models\Notificacion;
use App\Models\NotificacionUser;
use App\Models\Producto;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use PragmaRX\Google2FA\Google2FA;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            "usuario" => "required",
            "password" => "required|string|min:1",
        ], [
            "usuario.required" => "Debes completar el campo usuario",
            "password.required" => "Debes completar el campo contraseña",
            "password.min" => "Debes completar el campo contraseña"
        ]);


        $usuario = $request->usuario;
        $password = $request->password;
        $res = Auth::attempt(['usuario' => $usuario, 'password' => $password, 'acceso' => 1, 'status' => 1, 'b_auth' => 0]);
        if ($res) {
            self::notificacion1();
            self::notificacion2();
            self::notificacion3();
            $user = User::where("usuario", $usuario)->get()->first();
            if ($user) {
                if ($user->b_auth == 1 || $user->acceso == 0) {
                    Auth::logout();
                    return response()->JSON(["error" => "La cuenta a sido bloqueda por seguridad. Contactese con el administrador del sistema"]);
                }
            }

            $up = false;
            if ($user->update_password == 0) {
                $up = true;
            }

            return response()->JSON([
                'user' => Auth::user(),
                "up" => $up,
                "url_up" => route("updatePassword"),
            ], 200);
        }

        return response()->JSON([], 401);
    }

    public function updatePassword()
    {
        return view("updatePassword");
    }

    public function logout()
    {
        // $user = User::find(Auth::user()->id);
        // $user->google2fa_secret = NULL;
        // $user->save();

        session()->forget('2fa_authenticated');
        Auth::logout();
        return response()->JSON(['code' => 204], 204);
    }

    public static function notificacion1()
    {
        $fecha_actual = date("Y-m-d");
        $hora = date("H:i:s");

        // Obtener productos cuyo stock actual está entre stock_min y stock_min + 3
        $productos = Producto::whereBetween('stock_actual', [DB::raw('stock_min'), DB::raw('stock_min + 3')])->get();

        $usuarios = User::all();
        foreach ($productos as $producto) {
            // $notificacion = Notificacion::where("tipo", "A 3 STOCK MINIMO")
            $notificacion = Notificacion::where("tipo", "LLEGANDO A STOCK MINIMO")
                ->where("fecha", $fecha_actual)
                ->where("registro_id", $producto->id)
                ->first(); // Usamos first() directamente

            if (!$notificacion) {
                $notificacion = Notificacion::create([
                    "tipo" => "LLEGANDO A STOCK MINIMO",
                    // "tipo" => "A 3 STOCK MINIMO",
                    "registro_id" => $producto->id,
                    "descripcion" => "EL PRODUCTO " . $producto->nombre . " SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO",
                    "fecha" => $fecha_actual,
                    "hora" => $hora,
                ]);
            }

            foreach ($usuarios as $user) {
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)
                    ->first();

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
            $notificacion = Notificacion::where("tipo", "DEBAJO STOCK MINIMO")
                ->where("fecha", $fecha_actual)
                ->where("registro_id", $producto->id)
                ->get()->first();
            if (!$notificacion) {
                $notificacion =  Notificacion::create([
                    "tipo" => "DEBAJO STOCK MINIMO",
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



    // public static function notificacion1()
    // {
    //     $fecha_actual = date("Y-m-d");
    //     $hora = date("H:i:s");

    //     $productos = Producto::whereRaw('stock_min = stock_actual - 5')->get();
    //     $usuarios = User::all();
    //     foreach ($productos as $producto) {
    //         $notificacion = Notificacion::where("tipo", "A 5 STOCK MINIMO")
    //             ->where("fecha", $fecha_actual)
    //             ->where("registro_id", $producto->id)
    //             ->get()->first();
    //         if (!$notificacion) {
    //             $notificacion =  Notificacion::create([
    //                 "tipo" => "A 5 STOCK MINIMO",
    //                 "registro_id" => $producto->id,
    //                 "descripcion" => "EL PRODUCTO " . $producto->nombre . " SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO",
    //                 "fecha" => $fecha_actual,
    //                 "hora" => $hora,
    //             ]);
    //         }
    //         foreach ($usuarios as $user) {
    //             $notificacion_user = NotificacionUser::where("user_id", $user->id)
    //                 ->where("notificacion_id", $notificacion->id)->get()->first();
    //             if (!$notificacion_user) {
    //                 NotificacionUser::create([
    //                     "notificacion_id" => $notificacion->id,
    //                     "user_id" => $user->id,
    //                 ]);
    //             }
    //         }
    //     }
    // }

    // AUTHENTIFACION 2FA

    /**
     * Generar QR de autenticacion
     *
     * @param Request $request
     * @return void
     */
    public function genera2fa(Request $request)
    {
        if (Auth::check()) {
            $user = Auth::user();
            if (!$user->google2fa_secret) {
                $google2fa = new Google2FA();
                $secret = $google2fa->generateSecretKey();

                // Encriptar y guardar secret
                $user->google2fa_secret = Crypt::encryptString($secret);
                $user->save();
            } else {
                $secret = Crypt::decryptString($user->google2fa_secret);
            }

            // Generar URL para el QR
            $QR_url = "otpauth://totp/" . config('app.name') . ":" . $user->email .
                "?secret=" . $secret . "&issuer=" . config('app.name');

            // Generar la imagen QR
            $qrCode = QrCode::size(200)->generate($QR_url);

            return response()->json([
                'message' => 'Escanea este código QR con Google Authenticator',
                'secret' => $secret,
                'qr_code' => $qrCode, // Enviar QR en Base64 o como SVG
            ]);
        }
        return response()->json([
            'message' => 'Vuelve a iniciar sesión',
        ], 422);
    }

    public function verificar2fa(Request $request)
    {
        $request->validate([
            'code' => 'required|numeric',
        ]);

        $user = Auth::user();
        $google2fa = new Google2FA();

        // Desencriptar el secret antes de verificar
        $secret = Crypt::decryptString($user->google2fa_secret);

        $isValid = $google2fa->verifyKey($secret, $request->code);

        if ($isValid) {
            session(['2fa_authenticated' => true]); // Marcar sesión autenticada
            return response()->json(['message' => '2FA validado correctamente', 'user' => $user]);
        }

        return response()->json(['error' => 'Código incorrecto'], 422);
    }

    public function verificaLogin(Request $request)
    {
        $user = Auth::user();
        if ($user) {
            if ($user->update_password == 0 && !isset($request["updatePassword"])) {
                session()->forget('2fa_authenticated');
                Auth::logout();
            }
        }

        return response()->JSON(Auth::check());
    }
}
