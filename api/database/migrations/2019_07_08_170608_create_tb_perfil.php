<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTbPerfil extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        Schema::table('tb_perfil', function (Blueprint $table) {

            $table->integer(
                'co_perfil',
                true,
                true
            );
            #@todo está como text
            $table->string('no_perfil', 255);
            $table->string('ds_perfil', 255);
            $table->boolean('st_ativo')->default(true);

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        \App\Modules\Conta\Model\Perfil::truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');
//        Schema::drop('tb_perfil');
    }
}
