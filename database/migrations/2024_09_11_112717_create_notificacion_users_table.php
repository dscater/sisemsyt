<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNotificacionUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('notificacion_users', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("notificacion_id");
            $table->unsignedBigInteger("user_id");
            $table->integer("visto")->default(0);
            $table->timestamps();

            $table->foreign("notificacion_id")->on("notificacions")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('notificacion_users');
    }
}
