-- Regra de Fraude por Velocidade (3 transações no mesmo cartão em até 60 segundos)
INSERT INTO desafio_fraud_detected
SELECT 
    card_id,
    COUNT(*) as transaction_count,
    MAX(event_time) as last_transaction_time
FROM 
    TRANSACTIONS
MATCH_RECOGNIZE (
    PARTITION BY card_id
    ORDER BY event_time
    MEASURES
        T3.event_time as alert_time
    PATTERN (T1 T2 T3)
    WITHIN INTERVAL '60' SECOND
    DEFINE
        T2 AS TRUE,
        T3 AS TRUE
)
GROUP BY card_id;
