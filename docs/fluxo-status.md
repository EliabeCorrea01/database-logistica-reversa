# Fluxo de Status da Logística Reversa

Este documento descreve o fluxo de estados de uma peça dentro do sistema de logística reversa da concessionária.

Cada peça registrada no sistema passa por uma sequência de status até a conclusão do processo de garantia ou devolução à fábrica.

---

## Estados possíveis

REGISTRADA  
Peça foi registrada no sistema por um funcionário.

EM_ANALISE  
A peça está sendo analisada pela equipe responsável.

APROVADA  
A devolução foi aprovada para envio à fábrica.

REPROVADA  
A devolução foi recusada após análise.

AGUARDANDO_ENVIO  
A peça foi aprovada e está aguardando envio à fábrica.

ENVIADA_FABRICA  
A peça foi enviada para a fábrica.

RESSARCIDA  
A fábrica aprovou a devolução e realizou o ressarcimento.

CANCELADA  
O processo foi cancelado por erro ou inconsistência.

---

## Fluxo padrão do processo

REGISTRADA
↓
EM_ANALISE
↓
APROVADA
↓
AGUARDANDO_ENVIO
↓
ENVIADA_FABRICA
↓
RESSARCIDA

---

## Rastreabilidade

Cada mudança de status é registrada na tabela:

status_movimentacao

Essas informações incluem:

- status anterior
- novo status
- usuário responsável pela alteração
- data e hora da alteração

Além disso, alterações importantes também são registradas na tabela:

logs_alteracao

Isso garante auditoria completa do sistema.
