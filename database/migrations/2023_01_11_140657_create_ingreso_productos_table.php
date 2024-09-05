<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateIngresoProductosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ingreso_productos', function (Blueprint $table) {
            $table->id();
            $table->string("lugar");
            $table->unsignedBigInteger("producto_id");
            $table->unsignedBigInteger("proveedor_id");
            $table->decimal("precio_compra");
            $table->integer("cantidad");
            $table->unsignedBigInteger("tipo_ingreso_id");
            $table->text("descripcion")->nullable();
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("producto_id")->on("productos")->references("id");
            $table->foreign("proveedor_id")->on("proveedors")->references("id");
            $table->foreign("tipo_ingreso_id")->on("tipo_ingresos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ingreso_productos');
    }
}
