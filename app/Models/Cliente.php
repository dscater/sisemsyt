<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre", "ci", "ci_exp", "nit", "fono", "correo", "dir",
        "fecha_registro",
    ];

    protected $appends = ["full_ci"];

    public function getFullCiAttribute()
    {
        return $this->ci . ' ' . $this->ci_exp;
    }
}
