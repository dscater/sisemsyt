<?php

namespace App\Http\Controllers;

use App\Models\NotificacionUser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class NotificacionUserController extends Controller
{
    public function index(Request $request)
    {

        DB::update("update `notificacions` set tipo = 'DEBAJO STOCK MINIMO' WHERE descripcion LIKE 'ALERTA URGENTE%' AND tipo='STOCK MINIMO';");

        $ultimo = 0;
        if (isset($request->ultimo)) {
            $ultimo = $request->ultimo;
        }
        $notificacion_users = NotificacionUser::with(["notificacion"])->where("user_id", Auth::user()->id)
            ->where("id", ">", $ultimo)
            ->orderBy("id", "desc")
            ->get();
        if (count($notificacion_users) > 0) {
            $ultimo = $notificacion_users[0]->id;
        }
        $sin_ver = NotificacionUser::where("user_id", Auth::user()->id)->where("visto", 0)->count();

        return response()->JSON([
            "ultimo" => $ultimo,
            "sin_ver" => $sin_ver,
            "notificacion_users" => $notificacion_users,
            'total' => count($notificacion_users),
        ]);
    }
    public function show(NotificacionUser $notificacion_user)
    {
        $notificacion_user->visto = 1;
        $notificacion_user->save();

        $notificacion_user = $notificacion_user->load(["notificacion"]);

        return response()->JSON([
            "notificacion_user" => $notificacion_user
        ]);
    }
}
