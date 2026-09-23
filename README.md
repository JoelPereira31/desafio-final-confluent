# Pipeline de Pagamentos em Tempo Real - Desafio Final

Pipeline de streaming end-to-end implementado no Confluent Cloud, utilizando CDC (Postgres), Schema Registry, Flink SQL para enriquecimento e regras de fraude em tempo real, finalizando com governança e operação.

---

## 🏛️ Camada 1: Fundação
Criação do ambiente de trabalho isolado e do cluster no Confluent Cloud, garantindo a segurança através do princípio do menor privilégio com Identidades de Serviço (Service Accounts).

* **Ambiente**: `desafio-final`
* **Cluster**: `desafio-basic` (AWS / us-east-1)
* **Identidades**: `desafio-producer` (escrita) e `desafio-consumer` (leitura)

**Evidência de Configuração:**
```bash
confluent iam service-account list
confluent iam acl list --service-account <ID_DA_SA>
