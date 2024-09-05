<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFechaStocksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fecha_stocks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("producto_id");
            $table->date("fecha");
            $table->double("stock");
            $table->timestamps();

            $table->foreign("producto_id")->references("id")->on("productos")->onDelete("cascade");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('fecha_stocks');
    }
}
