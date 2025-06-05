<?php

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class LoginAttemptMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next,  $decayMinutes = 60)
    {
        /**
         * $decayMinutes: tiempo que se almacena en cache
         */
        if (!$request->filled('usuario') || !$request->filled('password')) {
            return response()->json([
                'message' => 'Debes completar el usuario y la contraseña.'
            ], 422);
        }

        $user_key = mb_strtolower(trim($request->usuario ?? 'ne'));

        // $key = 'login_attempts:' . $request->ip() . ':' . $user_key;
        $key = 'login_attempts:' . $user_key;

        $existe_user = User::where("usuario", $request->usuario)->get()->first();

        if ($existe_user && $existe_user->acceso == 0) {
            Cache::forget($key);
            Cache::forget($key . ':blocked');
            return response()->JSON(['error' => 'Cuenta bloqueada. Debe contactarse con el administrador del sistema']);
        }

        $response = $next($request);
        if (Cache::has($key . ':blocked')) {
            $unlockTime = Cache::get($key . ':blocked'); // Hora exacta de desbloqueo
            $minutesLeft = now()->diffInMinutes($unlockTime, false); // Tiempo restante
            $secondsLeft = now()->diffInSeconds($unlockTime, false) % 60; // Tiempo restante

            if ($minutesLeft > 0 || $secondsLeft > 0) {
                return response()->json([
                    'error' => "Intento fallido de inicio de sesión. Debe esperar $minutesLeft mins. y $secondsLeft segs.",
                    'blocked_until' => $unlockTime
                ]);
            }
        }

        $attempts = Cache::has($key) ? Cache::get($key) + 1 : 1;
        Cache::put($key, $attempts, now()->addMinutes($decayMinutes));
        $maxAttempts = 3;
        $blockDuration = 5;
        if ($existe_user && !Auth::check()) {
            if (Cache::has($key)) {
                // 7mo intento
                if (Cache::get($key) == 7) {
                    $blockDuration = 1440; // 24 horas
                    if ($existe_user) {
                        $existe_user->b_auth = 1;
                        $existe_user->acceso = 0;
                        $existe_user->save();
                    }
                    // Cache::add($key . ':blocked', true, now()->addMinutes($blockDuration));
                    return response()->JSON(['error' => 'Cuenta bloqueada por intentos fallidos de inicio de sesión. Debe contactarse con el administrador del sistema']);
                }
                // 6to intento
                if (Cache::get($key) == 6) {
                    $blockDuration = 5;
                    $unlockTime = now()->addMinutes($blockDuration);
                    Cache::add($key . ':blocked', $unlockTime, now()->addMinutes($blockDuration));
                    return response()->JSON(['error' => "Intento fallido de inicio de sesión. Acceso bloqueado durante $blockDuration minutos"]);
                }
                // 3er intento
                if (Cache::get($key) == 3) {
                    $blockDuration = 1;
                    $unlockTime = now()->addMinutes($blockDuration);
                    Cache::add($key . ':blocked', $unlockTime, now()->addMinutes($blockDuration));
                    return response()->JSON(['error' => "Intento fallido de inicio de sesión. Acceso bloqueado durante $blockDuration minuto"]);
                }
            }

            // reducir los 3 intentos restantes despues del block. min 1
            if ($attempts > 3) {
                $attempts -= 3;
            }
            $intentos_resantes = (int)$maxAttempts - (int)$attempts;

            if ($intentos_resantes == 0) {
                Cache::add($key . ':blocked', true, now()->addMinutes($blockDuration));
                return response()->JSON(['error' => 'Cuenta bloqueada por intentos fallidos de inicio de sesión. Debe contactarse con el administrador del sistema']);
            }
            return response()->JSON(['error' => $intentos_resantes . ' intentos restantes']);
        }

        if (Auth::check()) {
            Cache::forget($key);
            Cache::forget($key . ':blocked');
        }

        return $response;
    }
}
