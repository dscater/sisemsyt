<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FechaStock extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id", "fecha", "stock",
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }
}