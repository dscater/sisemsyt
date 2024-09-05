<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSalidaProductosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('salida_productos', function (Blueprint $table) {
            $table->id();
            $table->string("lugar");
            $table->unsignedBigInteger("producto_id");
            $table->integer("cantidad");
            $table->unsignedBigInteger("tipo_salida_id");
            $table->text("descripcion")->nullable();
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("producto_id")->on("productos")->references("id");
            $table->foreign("tipo_salida_id")->on("tipo_salidas")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('salida_productos');
    }
}
