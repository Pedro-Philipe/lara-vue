<?php

namespace App\Modules\Conta\Model;

use Illuminate\Database\Eloquent\Model;

class Perfil extends Model
{
    const CODIGO_ADMINISTRADOR = 777;

    protected $table = 'tb_perfil';
    protected $primaryKey = 'co_perfil';

    protected $fillable = [
        'no_perfil',
        'ds_perfil',
        'st_ativo',
    ];

    public $timestamps = FALSE;

    public function usuario(){
        return $this->belongsTo(
            \App\Modules\Conta\Model\Usuario::class,
            'co_usuario',
            'co_usuario'
        );
    }

}
