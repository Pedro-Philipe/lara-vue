<?php

namespace App\Modules\Conta\Model;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class AAutenticacao extends Authenticatable implements JWTSubject
{
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims(): array
    {
        return [
            'user' => [
                'no_nome' => $this->no_nome,
                'ds_email' => $this->ds_email,
                'dh_cadastro' => $this->dh_cadastro->format('Y-m-d H:i:s'),
                'dh_ultima_atualizacao' => $this->dh_ultima_atualizacao->format('Y-m-d H:i:s'),
                'st_ativo' => $this->st_ativo,
                'nu_cpf' => $this->nu_cpf,
                'perfil' => $this->perfil,
                'co_usuario' => $this->co_usuario,
            ]
        ];
    }

    protected function gerarCodigo(string $string): string
    {
        return sha1(mt_rand(1, 999) . time() . $string);
    }
}
