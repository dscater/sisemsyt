<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class Venta extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "cliente_id",
        "nit",
        "total",
        "descuento",
        "total_final",
        "estado",
        "fecha_registro",
        "status"
    ];

    protected $appends = ["editable", "fecha_formateado", "hora", "nro_factura", "qr", "url_ticket", "fecha_registro_t"];


    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getUrlTicketAttribute()
    {
        return route("ventas.ticket", $this->id);
    }

    public function getQrAttribute()
    {
        $codigo = $this->id . "|" . $this->cliente->nombre . "|" . $this->nit . "|" . $this->fecha_registro . "|" . $this->total_final;

        $url_base64 = "data:image/png;base64," . base64_encode(QrCode::format("png")->size(150)->generate($codigo));

        return $url_base64;
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function detalle_ventas()
    {
        return $this->hasMany(DetalleVenta::class, 'venta_id')->where("status", 1);
    }

    public function getNroFacturaAttribute()
    {
        $nro = $this->id;
        if ($nro < 10) {
            $nro = '000' . $nro;
        } elseif ($nro < 100) {
            $nro = '00' . $nro;
        } elseif ($nro < 1000) {
            $nro = '0' . $nro;
        }
        return $nro;
    }
    public function getFechaFormateadoAttribute()
    {
        return date("d/m/Y", strtotime($this->created_at));
    }

    public function getHoraAttribute()
    {
        return date("H:i", strtotime($this->created_at));
    }

    public function getEditableAttribute()
    {
        if ($this->devolucion) {
            return false;
        }
        return true;
    }
}
