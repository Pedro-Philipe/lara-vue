CREATE SCHEMA "default";

CREATE TABLE tb_email (
	co_email             integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	ds_email             varchar(255)   ,
	st_divulgar          bool   ,
	st_ativo             bool   ,
	CONSTRAINT pk_tb_email_co_email PRIMARY KEY ( co_email )
 );

CREATE TABLE tb_funcionalidade (
	co_funcionalidade    integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_funcionalidade    varchar(255)  NOT NULL ,
	ds_funcionalidade    varchar(255)   ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_tb_funcionalidades_co_funcionalidade PRIMARY KEY ( co_funcionalidade )
 );

CREATE TABLE tb_grupo (
	co_grupo             integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	CONSTRAINT pk_tb_grupo_co_grupo PRIMARY KEY ( co_grupo )
 );

CREATE TABLE tb_menu (
	co_menu              integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_menu              varchar(255)  NOT NULL ,
	no_rota              varchar(255)   ,
	ds_menu              varchar(255)   ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_tb_menu_co_menu PRIMARY KEY ( co_menu )
 );

CREATE TABLE tb_natureza (
	co_natureza          integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_natureza          integer  NOT NULL ,
	CONSTRAINT pk_tb_natureza_co_natureza PRIMARY KEY ( co_natureza )
 );

COMMENT ON TABLE tb_natureza IS '1 - Público\n2 - Privado sem fins lucrativo';

CREATE TABLE tb_perfil (
	co_perfil            integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_perfil            varchar(255)  NOT NULL ,
	ds_perfil            varchar(255)   ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_tb_perfil_co_perfil PRIMARY KEY ( co_perfil )
 );

CREATE TABLE tb_regiao (
	co_regiao            integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_regiao            text  NOT NULL ,
	CONSTRAINT pk_tb_regiao_co_regiao PRIMARY KEY ( co_regiao )
 );

COMMENT ON TABLE tb_regiao IS 'SUL\nNORTE\nNORDESTE\nSUDESTE\nCENTRO-OESTE';

CREATE TABLE tb_telefone (
	co_telefone          integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	ds_telefone          text  NOT NULL ,
	st_divulgar          bool  NOT NULL ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_tb_telefone_co_telefone PRIMARY KEY ( co_telefone )
 );

CREATE TABLE tb_tipo_arquivo (
	co_tipo_arquivo      integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_tipo_arquivo      varchar(255)  NOT NULL ,
	CONSTRAINT pk_tb_tipo_documento_co_tipo_documento PRIMARY KEY ( co_tipo_arquivo )
 );

CREATE TABLE tb_tipo_entidade (
	co_tipo_entidade     integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_tipo_entidade     varchar(255)  NOT NULL ,
	co_natureza          integer  NOT NULL ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_tb_tipo_entidade_co_tipo_entidade PRIMARY KEY ( co_tipo_entidade ),
	CONSTRAINT fk_tb_tipo_entidade FOREIGN KEY ( co_natureza ) REFERENCES tb_natureza( co_natureza )
 );

COMMENT ON TABLE tb_tipo_entidade IS '-- natureza publica\n1 - Prefeitura;\n2 - Secretaria;\n3 - Universidade.\n\n-- natureza privada sem fins lucrativos\n4 - Associação Privada;\n5 - Confederação;\n6 - Clube;\n7 - Federação;\n8 -  Fundação Privada;\n9 - Instituto;\n10 - Liga;\n11 - ONG;\n12 - Sindicato;\n13 - Universidade.';

CREATE TABLE tb_tipo_vinculo (
	co_tipo_vinculo      integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_tipo_vinculo      varchar(255)   ,
	st_status            bool   ,
	CONSTRAINT pk_tb_tipo_vinculo_co_tipo_vinculo PRIMARY KEY ( co_tipo_vinculo )
 );

COMMENT ON TABLE tb_tipo_vinculo IS '- Proponente\n- Presidente;\n- Vice-Presidente;\n- Consultor;\n- Diretor;\n- Secretário;\n- Comodoro;';

CREATE TABLE tb_uf (
	co_uf                integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_uf                text  NOT NULL ,
	no_sigla_uf          text  NOT NULL ,
	co_regiao            integer  NOT NULL ,
	CONSTRAINT pk_tb_uf_co_uf PRIMARY KEY ( co_uf ),
	CONSTRAINT fk_regiao_uf FOREIGN KEY ( co_regiao ) REFERENCES tb_regiao( co_regiao )
 );

CREATE TABLE tb_usuario (
	co_usuario           integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_cpf               text  NOT NULL ,
	no_email             varchar  NOT NULL ,
	ds_senha             varchar(255)  NOT NULL ,
	dt_nascimento        date  NOT NULL ,
	ds_codigo_ativacao   varchar(255)   ,
	dt_cadastro          date  NOT NULL ,
	dt_ultima_atualizacao date DEFAULT current_date  ,
	st_ativo             bool DEFAULT true NOT NULL ,
	CONSTRAINT pk_usuario_co_usuario PRIMARY KEY ( co_usuario )
 );

COMMENT ON COLUMN tb_usuario.no_email IS 'E-mail do Usuario';

COMMENT ON COLUMN tb_usuario.ds_senha IS 'Senha do Usuario';

COMMENT ON COLUMN tb_usuario.ds_codigo_ativacao IS 'Hash utilizado para ativação do Usuario';

COMMENT ON COLUMN tb_usuario.st_ativo IS 'Situação do Usuario';

CREATE TABLE rl_menu_funcionalidade (
	co_menu_funcionalidade integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_menu              integer  NOT NULL ,
	co_funcionalidade    integer  NOT NULL ,
	CONSTRAINT pk_rl_menu_funcionalidade_co_menu_funcionalidade PRIMARY KEY ( co_menu_funcionalidade ),
	CONSTRAINT fk_menu_funcionalidade_menu FOREIGN KEY ( co_menu ) REFERENCES tb_menu( co_menu )  ,
	CONSTRAINT fk_menu_funcionalidade FOREIGN KEY ( co_funcionalidade ) REFERENCES tb_funcionalidade( co_funcionalidade )
 );

CREATE TABLE rl_perfil_menu (
	co_perfil_menu       integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_perfil            integer  NOT NULL ,
	co_menu              integer  NOT NULL ,
	CONSTRAINT pk_rl_perfil_menu_co_perfil_menu PRIMARY KEY ( co_perfil_menu ),
	CONSTRAINT fk_perfil_menu_perfil FOREIGN KEY ( co_perfil ) REFERENCES tb_perfil( co_perfil )  ,
	CONSTRAINT fk_perfil_menu_menu FOREIGN KEY ( co_menu ) REFERENCES tb_menu( co_menu )
 );

CREATE TABLE rl_usuario_perfil (
	co_usuario_perfil    integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_usuario           integer  NOT NULL ,
	co_perfil            integer  NOT NULL ,
	st_perfil_atual      bool DEFAULT true ,
	CONSTRAINT pk_rl_usuario_perfil_co_usuario_perfil PRIMARY KEY ( co_usuario_perfil ),
	CONSTRAINT fk_usuario_perfil_usuario FOREIGN KEY ( co_usuario ) REFERENCES tb_usuario( co_usuario )  ,
	CONSTRAINT fk_usuario_perfil_perfil FOREIGN KEY ( co_perfil ) REFERENCES tb_perfil( co_perfil )
 );

CREATE TABLE tb_agente (
	co_agente            integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	tp_pessoa            integer  NOT NULL ,
	nu_cpf_cnpj          varchar(255)  NOT NULL ,
	no_nome              varchar(255)  NOT NULL ,
	no_razao_social      varchar(255)   ,
	co_tipo_entidade     integer  NOT NULL ,
	no_site              varchar(255)   ,
	dt_cadastro          date   ,
	dt_atualizacao       date DEFAULT current_date NOT NULL ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_agente_co_agente PRIMARY KEY ( co_agente ),
	CONSTRAINT fk_agente_tipo_entidade FOREIGN KEY ( co_tipo_entidade ) REFERENCES tb_tipo_entidade( co_tipo_entidade )
 );

COMMENT ON COLUMN tb_agente.tp_pessoa IS '1 - Jurídica\n2 - Física';

CREATE TABLE tb_arquivo (
	co_arquivo           integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_tipo_arquivo      integer  NOT NULL ,
	no_arquivo           integer  NOT NULL ,
	ds_url_caminho       text  NOT NULL ,
	no_extensao          varchar(255)   ,
	CONSTRAINT pk_tb_agente_documentos_co_agente_documentos PRIMARY KEY ( co_arquivo ),
	CONSTRAINT fk_arquivo_tipo_arquivo FOREIGN KEY ( co_tipo_arquivo ) REFERENCES tb_tipo_arquivo( co_tipo_arquivo )
 );

CREATE TABLE tb_cidade (
	co_cidade            integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	no_cidade            varchar(255)  NOT NULL ,
	co_uf                integer  NOT NULL ,
	CONSTRAINT pk_tb_cidade_co_cidade PRIMARY KEY ( co_cidade ),
	CONSTRAINT fk_uf_cidade FOREIGN KEY ( co_uf ) REFERENCES tb_uf( co_uf )
 );

CREATE TABLE tb_endereco (
	co_endereco          integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	nu_cep               text  NOT NULL ,
	ds_logradouro        varchar(255)  NOT NULL ,
	nu_numero            varchar(10)   ,
	ds_complemento       varchar(255)   ,
	co_cidade            integer  NOT NULL ,
	no_municipio         varchar(255)   ,
	no_bairro            varchar(255)   ,
	st_divulgar          bool  NOT NULL ,
	st_ativo             bool DEFAULT true  ,
	CONSTRAINT pk_tb_endereco_co_endereco PRIMARY KEY ( co_endereco ),
	CONSTRAINT fk_endereco_cidade FOREIGN KEY ( co_cidade ) REFERENCES tb_cidade( co_cidade )
 );

CREATE TABLE rl_agente_agente (
	co_agente_agente     integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_agente            integer  NOT NULL ,
	co_agente_vinculado  integer  NOT NULL ,
	co_tipo_vinculo      integer  NOT NULL ,
	CONSTRAINT pk_rl_agente_agente_co_agente_agente PRIMARY KEY ( co_agente_agente ),
	CONSTRAINT fk_agente_agente FOREIGN KEY ( co_agente ) REFERENCES tb_agente( co_agente )  ,
	CONSTRAINT fk_agente_agente_vinculado FOREIGN KEY ( co_agente_vinculado ) REFERENCES tb_agente( co_agente )  ,
	CONSTRAINT fk_agente_agente_tipo_vinculo FOREIGN KEY ( co_tipo_vinculo ) REFERENCES tb_tipo_vinculo( co_tipo_vinculo )
 );

CREATE TABLE rl_agente_arquivo (
	cod_agente_arquivo   integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_arquivo           integer  NOT NULL ,
	co_agente            integer  NOT NULL ,
	CONSTRAINT pk_rl_agente_arquivo_cod_agente_arquivo PRIMARY KEY ( cod_agente_arquivo ),
	CONSTRAINT fk_rl_agente_arquivo FOREIGN KEY ( co_arquivo ) REFERENCES tb_arquivo( co_arquivo )  ,
	CONSTRAINT fk_agente_arquivo_agente FOREIGN KEY ( co_agente ) REFERENCES tb_agente( co_agente )
 );

CREATE TABLE rl_agente_email (
	co_agente_email      integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_agente            integer  NOT NULL ,
	co_email             integer  NOT NULL ,
	CONSTRAINT pk_rl_agente_email_co_agente_email PRIMARY KEY ( co_agente_email ),
	CONSTRAINT fk_agente_email_agente FOREIGN KEY ( co_agente ) REFERENCES tb_agente( co_agente )  ,
	CONSTRAINT fk_agente_email_email FOREIGN KEY ( co_email ) REFERENCES tb_email( co_email )
 );

CREATE TABLE rl_agente_endereco (
	co_agente_endereco   integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_agente            integer  NOT NULL ,
	co_endereco          integer  NOT NULL ,
	CONSTRAINT pk_rl_agente_endereco_co_agente_endereco PRIMARY KEY ( co_agente_endereco ),
	CONSTRAINT fk_agente_endereco_agente FOREIGN KEY ( co_agente ) REFERENCES tb_agente( co_agente )  ,
	CONSTRAINT fk_agente_endereco_endereco FOREIGN KEY ( co_endereco ) REFERENCES tb_endereco( co_endereco )
 );

CREATE TABLE rl_agente_telefone (
	co_agente_telefone   integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_agente            integer  NOT NULL ,
	co_telefone          integer  NOT NULL ,
	CONSTRAINT pk_rl_agente_telefone_co_agente_telefone PRIMARY KEY ( co_agente_telefone ),
	CONSTRAINT fk_agente_telefone_agente FOREIGN KEY ( co_agente ) REFERENCES tb_agente( co_agente )  ,
	CONSTRAINT fk_agente_telefone_telefone FOREIGN KEY ( co_telefone ) REFERENCES tb_telefone( co_telefone )
 );

CREATE TABLE rl_usuario_agente (
	co_usuario_agente    integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	co_usuario           integer  NOT NULL ,
	co_agente            integer  NOT NULL ,
	co_tipo_vinculo      integer  NOT NULL ,
	CONSTRAINT pk_rl_usuario_agente_co_usuario_agente PRIMARY KEY ( co_usuario_agente ),
	CONSTRAINT fk_rl_usuario FOREIGN KEY ( co_usuario ) REFERENCES tb_usuario( co_usuario )  ,
	CONSTRAINT fk_rl_agente FOREIGN KEY ( co_agente ) REFERENCES tb_agente( co_agente )  ,
	CONSTRAINT fk_usuario_agente_tipo_vinculo FOREIGN KEY ( co_tipo_vinculo ) REFERENCES tb_tipo_vinculo( co_tipo_vinculo )
 );



