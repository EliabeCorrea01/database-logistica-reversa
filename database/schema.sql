CREATE DATABASE IF NOT EXISTS logistica_reversa;
USE logistica_reversa;

-- Usuários do sistema (Funcionário / Supervisor)
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  tipo_usuario ENUM('FUNCIONARIO','SUPERVISOR') NOT NULL,
  ativo TINYINT(1) NOT NULL DEFAULT 1,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Registro principal: devolução/garantia da peça
CREATE TABLE IF NOT EXISTS pecas_devolucao (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao_peca VARCHAR(200) NOT NULL,
  codigo_peca VARCHAR(60) NULL,

  -- EXIGÊNCIA: NF obrigatória
  numero_nf_origem VARCHAR(60) NOT NULL,

  vendedor_id INT NOT NULL,                 -- funcionário responsável
  motivo_defeito VARCHAR(255) NOT NULL,

  -- Upload de evidência (o front vai salvar o caminho/URL)
  evidencia_path VARCHAR(255) NULL,

  -- Fluxo de status (Q6)
  status_atual ENUM(
    'REGISTRADA',
    'EM_ANALISE',
    'APROVADA',
    'REPROVADA',
    'AGUARDANDO_ENVIO',
    'ENVIADA_FABRICA',
    'RESSARCIDA',
    'CANCELADA'
  ) NOT NULL DEFAULT 'REGISTRADA',

  data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  -- usado no “semáforo” do dashboard (Q5)
  prazo_envio_fabrica DATE NULL,

  atualizado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT fk_peca_vendedor
    FOREIGN KEY (vendedor_id) REFERENCES usuarios(id)
);

-- Rastreabilidade do fluxo: histórico de mudanças de status
CREATE TABLE IF NOT EXISTS status_movimentacao (
  id INT AUTO_INCREMENT PRIMARY KEY,
  peca_id INT NOT NULL,
  status_anterior VARCHAR(40) NOT NULL,
  status_novo VARCHAR(40) NOT NULL,
  alterado_por INT NOT NULL,
  alterado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  observacao VARCHAR(255) NULL,

  CONSTRAINT fk_mov_peca
    FOREIGN KEY (peca_id) REFERENCES pecas_devolucao(id),
  CONSTRAINT fk_mov_user
    FOREIGN KEY (alterado_por) REFERENCES usuarios(id)
);

-- EXIGÊNCIA: Logs de alteração (quem alterou e quando)
CREATE TABLE IF NOT EXISTS logs_alteracao (
  id INT AUTO_INCREMENT PRIMARY KEY,
  entidade VARCHAR(60) NOT NULL,         -- ex: 'pecas_devolucao'
  entidade_id INT NOT NULL,
  campo VARCHAR(60) NOT NULL,            -- ex: 'status_atual'
  valor_anterior VARCHAR(255) NULL,
  valor_novo VARCHAR(255) NULL,
  alterado_por INT NOT NULL,
  alterado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_log_user
    FOREIGN KEY (alterado_por) REFERENCES usuarios(id)
);
