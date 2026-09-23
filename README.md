# Pipeline de Pagamentos em Tempo Real - Desafio Final

Pipeline de streaming end-to-end implementado no Confluent Cloud, utilizando CDC (Postgres), Schema Registry, Flink SQL para enriquecimento e regras de fraude em tempo real, finalizando com governança e operação.

---

## 🏛️ Camada 1: Fundação
Criação do ambiente de trabalho isolado e do cluster no Confluent Cloud, garantindo a segurança através do princípio do menor privilégio com Identidades de Serviço (Service Accounts).

* **Ambiente**: `desafio-final`
* **Cluster**: `desafio-basic` (AWS / us-east-1)
* **Identidades**: `desafio-producer` (escrita) e `desafio-consumer` (leitura)

**Evidência de Configuração:**
```
bash
confluent iam service-account list
confluent iam acl list --service-account <ID_DA_SA>
```

📜 Camada 2: Contrato de Dados (Schema Registry)
Definição dos esquemas utilizando Avro para garantir a governança e a compatibilidade dos dados ao longo do tempo.

Evolução de Schema: Configurado e testado no modo BACKWARD para permitir alterações seguras em produção sem quebrar os consumidores legados.

Evidências de Compatibilidade:

Aceitação de campo novo: Adicionado com valor padrão (default), validado com sucesso pelo Schema Registry.

Rejeição de alteração incompatível: Bloqueio na remoção de campos obrigatórios para manter a integridade do contrato.

🔄 Camada 3: Ingestão (CDC com Postgres)
Captura de alterações em tempo real no banco de dados relacional (PostgreSQL) utilizando o conector Debezium CDC (PostgresCdcSourceV2). O arquivo de configuração encontra-se no diretório connectors/cdc.json deste repositório.

Tabelas monitoradas: customers, accounts, cards, merchants, transactions.

Tipos de eventos capturados:

op=c (INSERT): Inclusão de novas transações.

op=u (UPDATE): Atualizações de status e cadastros.

op=d (DELETE): Exclusões monitoradas.

⚡ Camada 4: Processamento (Flink SQL)
Processamento contínuo em stream utilizando Flink SQL para cruzar dados e aplicar regras de negócio complexas. Os códigos dos scripts estão disponíveis na pasta sql/.

Regra de Fraude: Detecção por velocidade (MATCH_RECOGNIZE) implementada no arquivo sql/02-fraud-detection.sql, identificando 3 transações no mesmo cartão em um intervalo de até 60 segundos.

⚙️ Camada 5: Operação
Resumo dos pilares operacionais do pipeline:

Observabilidade: Monitoramento contínuo de latência e consumo de bytes via métricas de ecossistema.

Segurança: Mapeamento rigoroso de Service Accounts e ACLs restritivas por tópico.

Custos: Arquitetura planejada em cluster Basic para otimização de recursos em ambiente de desenvolvimento.

Confiabilidade: Garantia de entrega idempotente e tratamento de falhas no fluxo de mensageria.

🧹 Limpeza do Ambiente (Teardown)
Procedimento padrão para encerramento de recursos e prevenção de cobranças utilizando scripts de automação (teardown.sh).
