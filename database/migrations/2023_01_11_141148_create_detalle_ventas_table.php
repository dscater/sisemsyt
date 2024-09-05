<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetalleVentasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_ventas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("orden_id");
            $table->unsignedBigInteger("producto_id");
            $table->unsignedBigInteger("sucursal_stock_id");
            $table->integer("cantidad");
            $table->enum("venta_mayor", ["NO", "SI"]);
            $table->decimal("precio", 24, 2);
            $table->decimal("subtotal", 24, 2);
            $table->timestamps();

            $table->foreign("orden_id")->on("orden_ventas")->references("id");
            $table->foreign("producto_id")->on("productos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('detalle_ventas');
    }
}
