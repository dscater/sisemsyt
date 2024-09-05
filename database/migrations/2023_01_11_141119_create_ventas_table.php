<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVentasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ventas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("caja_id");
            $table->unsignedBigInteger("cliente_id");
            $table->string("nit", 155);
            $table->decimal("total", 24, 2);
            $table->string("tipo_venta");
            $table->string("estado");
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("sucursal_id")->on("sucursals")->references("id");
            $table->foreign("cliente_id")->on("clientes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ventas');
    }
}
