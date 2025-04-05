<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockMinimo extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id",
        "fecha",
        "stock_min",
        "status",
    ];

    protected $appends = ["fecha_txt", "created_txt", "updated_txt"];


    public function getCreatedTxtAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->created_at));
    }

    public function getUpdatedTxtAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->updated_at));
    }

    public function getFechaTxtAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }
}
