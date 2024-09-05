<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalidaProducto extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id", "cantidad", "fecha_salida", "tipo_salida_id", "descripcion",
        "fecha_registro",
    ];

    protected $appends = ["nombre_producto", "nombre_producto_full"];

    public function getNombreProductoAttribute()
    {
        return $this->producto->nombre;
    }

    public function getNombreProductoFullAttribute()
    {
        return $this->producto->codigo . ' | ' . $this->producto->nombre . ' | ' . $this->producto->medida;
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }

    public function tipo_salida()
    {
        return $this->belongsTo(TipoSalida::class, 'tipo_salida_id');
    }
}
