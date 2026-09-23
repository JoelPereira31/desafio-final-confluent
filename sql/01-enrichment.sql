-- Script de enriquecimento e criação de tabelas de apoio no Flink SQL
-- Une transações com dados de contas e cartões em tempo real
SELECT 
    t.transaction_id,
    t.card_id,
    t.amount,
    t.event_time
FROM transactions t;
