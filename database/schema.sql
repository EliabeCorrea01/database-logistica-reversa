CREATE DATABASE IF NOT EXISTS logistica_reversa;
USE logistica_reversa;

-- Tabela de usuários (funcionários e supervisores)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('FUNCIONARIO','SUPERVISOR') NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de registro de peças com defeito
CREATE TABLE pecas_devolucao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao_peca VARCHAR(200) NOT NULL,
    numero_nf VARCHAR(50) NOT NULL,
    vendedor_id INT,
    motivo_defeito TEXT,
    foto_evidencia VARCHAR(255),
    status ENUM('REGISTRADA','EM_ANALISE','APROVADA','REPROVADA','ENVIADA_FABRICA','FINALIZADA') DEFAULT 'REGISTRADA',
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    prazo_envio DATE,

    FOREIGN KEY (vendedor_id) REFERENCES usuarios(id)
);

-- Histórico de mudanças de status
CREATE TABLE historico_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    peca_id INT,
    status_anterior VARCHAR(50),
    status_novo VARCHAR(50),
    alterado_por INT,
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (peca_id) REFERENCES pecas_devolucao(id),
    FOREIGN KEY (alterado_por) REFERENCES usuarios(id)
);

-- Logs gerais do sistema
CREATE TABLE logs_alteracao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabela_afetada VARCHAR(100),
    registro_id INT,
    campo VARCHAR(100),
    valor_antigo TEXT,
    valor_novo TEXT,
    alterado_por INT,
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (alterado_por) REFERENCES usuarios(id)
);
