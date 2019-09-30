<?php


namespace App\Modules\Conselho\Mail\Conselho;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use App\Modules\Conselho\Model\Conselho as ConselhoModel;

class CadastroRecursoHabilitacaoSucesso extends Mailable
{
    use Queueable,
        SerializesModels;

    protected $conselho;
    protected $dsRecurso;

    public function __construct(array $conselho)
    {
        $this->conselho = $conselho;
    }

    public function build()
    {
        return $this->subject('Ministério da Cidadania - Recurso enviado com sucesso')
            ->view('conselho::conselho.email.cadastro-recurso-habilitacao-sucesso')
            ->with([
                'conselho' => $this->conselho,
            ]);
    }
}
