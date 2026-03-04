USE logistica_reversa;

-- Usuários de exemplo
INSERT INTO usuarios (nome, email, senha_hash, tipo_usuario) VALUES
('Samuel', 'samuel@empresa.com', 'hash123', 'FUNCIONARIO'),
('Eliabe', 'eliabe@empresa.com', 'hash123', 'FUNCIONARIO'),
('Supervisor', 'supervisor@empresa.com', 'hash123', 'SUPERVISOR');

-- Peças registradas para devolução
INSERT INTO pecas_devolucao
(descricao_peca, codigo_peca, numero_nf_origem, vendedor_id, motivo_defeito, evidencia_path, status_atual, prazo_envio_fabrica)
VALUES
('Alternador', 'ALT-001', 'NF-88991', 1, 'Peça não carrega bateria', 'uploads/alt001.jpg', 'REGISTRADA', DATE_ADD(CURDATE(), INTERVAL 3 DAY)),
('Pastilha de freio', 'PFD-233', 'NF-77110', 2, 'Ruído excessivo', 'uploads/pfd233.jpg', 'AGUARDANDO_ENVIO', DATE_ADD(CURDATE(), INTERVAL 1 DAY));
