<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notificacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "tipo",
        "registro_id",
        "descripcion",
        "fecha",
        "hora",
    ];

    protected $appends = ["fecha_t", "fecha_hora_t", "hace"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function getFechaHoraTAttribute()
    {
        return date("d/m/Y H:i", strtotime($this->fecha . ' ' . $this->hora));
    }

    public function getHaceAttribute()
    {
        $tiempo = $this->created_at->diffForHumans();
        return $tiempo;
    }

    // FUNCIONES
    public static function verificaNotificacionProducto($producto_id)
    {
        $fecha_actual = date("Y-m-d");
        $hora = date("H:i:s");
        $producto = Producto::find($producto_id);
        $usuarios = User::all();

        if ($producto) {
            // Validar si el stock_actual está en el rango de stock_min a stock_min + 3
            if ($producto->stock_actual >= $producto->stock_min && $producto->stock_actual <= ($producto->stock_min + 3)) {
                $notificacion = Notificacion::where("tipo", "LLEGANDO A STOCK MINIMO")
                    ->where("fecha", $fecha_actual)
                    ->where("registro_id", $producto->id)
                    ->first(); // Usamos first() directamente

                if (!$notificacion) {
                    $notificacion = Notificacion::create([
                        "tipo" => "A 3 STOCK MINIMO",
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
    }
}
