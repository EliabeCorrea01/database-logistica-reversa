USE logistica_reversa;

DELIMITER $$

CREATE PROCEDURE sp_alterar_status_peca (
  IN p_peca_id INT,
  IN p_novo_status VARCHAR(40),
  IN p_usuario_id INT,
  IN p_observacao VARCHAR(255)
)
BEGIN
  DECLARE v_status_atual VARCHAR(40);

  -- 1) Buscar status atual
  SELECT status_atual
    INTO v_status_atual
  FROM pecas_devolucao
  WHERE id = p_peca_id;

  -- 2) Atualizar status na tabela principal
  UPDATE pecas_devolucao
  SET status_atual = p_novo_status
  WHERE id = p_peca_id;

  -- 3) Registrar histórico de status
  INSERT INTO status_movimentacao (peca_id, status_anterior, status_novo, alterado_por, observacao)
  VALUES (p_peca_id, v_status_atual, p_novo_status, p_usuario_id, p_observacao);

  -- 4) Registrar log de alteração (campo status_atual)
  INSERT INTO logs_alteracao (entidade, entidade_id, campo, valor_anterior, valor_novo, alterado_por)
  VALUES ('pecas_devolucao', p_peca_id, 'status_atual', v_status_atual, p_novo_status, p_usuario_id);
END $$

DELIMITER ;
