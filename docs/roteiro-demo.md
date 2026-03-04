# Roteiro de Demonstração – Sistema de Logística Reversa

Este roteiro descreve os passos para demonstrar o funcionamento do banco de dados do sistema de logística reversa.

---

## 1. Criar estrutura do banco

Executar o arquivo:

schema.sql

Isso cria:

- banco de dados `logistica_reversa`
- tabelas do sistema
- chaves estrangeiras
- estrutura completa

---

## 2. Inserir dados de teste

Executar o arquivo:

seed.sql

Isso irá criar:

Usuários:
- Samuel (funcionário)
- Eliabe (funcionário)
- Supervisor

Peças de exemplo:
- Alternador
- Pastilha de freio

---

## 3. Verificar registros iniciais

Executar:

SELECT * FROM pecas_devolucao;

Isso mostra as peças cadastradas no sistema.

---

## 4. Simular mudança de status

Executar:

CALL sp_alterar_status_peca(
1,
'EM_ANALISE',
1,
'Peça enviada para análise técnica'
);

Isso altera o status da peça com id 1.

---

## 5. Verificar histórico de status

Executar:

SELECT * FROM status_movimentacao;

Resultado esperado:

- status anterior
- status novo
- usuário que alterou
- data da alteração

---

## 6. Verificar log de auditoria

Executar:

SELECT * FROM logs_alteracao;

Resultado esperado:

- entidade alterada
- campo alterado
- valor anterior
- valor novo
- usuário responsável

---

## 7. Verificar status atualizado da peça

Executar:

SELECT id, descricao_peca, status_atual
FROM pecas_devolucao;

A peça deverá aparecer com status:

EM_ANALISE

---

## Conclusão

O sistema garante:

- controle das peças devolvidas
- rastreabilidade completa das alterações
- histórico de movimentação de status
- auditoria de todas as alterações

Isso atende às exigências do projeto de logística reversa para concessionárias.
