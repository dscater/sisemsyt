<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('productos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo", 255);
            $table->string("nombre", 255);
            $table->string("medida", 255);
            $table->unsignedBigInteger("categoria_id");
            $table->unsignedBigInteger("grupo_id");
            $table->decimal("precio", 24, 2);
            $table->decimal("precio_mayor", 24, 2);
            $table->integer("stock_min");
            $table->enum("descontar_stock", ["SI", "NO"]);
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("grupo_id")->on("grupos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('productos');
    }
}
