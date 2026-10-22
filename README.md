# TP I – Integração de Sistemas de Informação

**Autor:** Nuno Filipe Martins Macedo, n.º 31536 (LESI)

**Vídeo de demonstração:** https://drive.google.com/file/d/1Agk5HjLyUx4heihLvDerddqY-LfCRbaV/view?usp=drive_link

**Repositório Git:** https://github.com/Nuno123456789/ISI_Nuno_Macedo_31536_LESIPL.git

## Descrição

Processo ETL em KNIME para monitorizar a produção industrial: junta dados de PostgreSQL, CSV, JSON e XML, valida-os, calcula o OEE (máquinas) e o OLE (operadores) e mostra os resultados num dashboard Grafana. Os dados são simulados com Node-RED.

## Ficheiros

| Pasta | Conteúdo |
| --- | --- |
| `doc/` | Relatório (`31536_doc.pdf`) |
| `dataintegration/` | Workflow KNIME `ETL_Monitorizacao_Producao` |
| `data/input/` | Dados de entrada (CSV, JSON e XML) e cópia da base de dados (`producao.sql`) |
| `data/output/` | Indicadores exportados (CSV e JSON) e logs |
| `src/` | Fluxo Node-RED, Grafana (docker-compose e dashboard) e script SQL de teste |

## Ferramentas

KNIME 5.12, PostgreSQL 18, Node-RED 5, Grafana 11.2 e Docker Desktop.

## Como executar

1. Criar a base de dados `Producao` e restaurar a cópia:
   ```
   pg_restore -U postgres -d Producao data/input/producao.sql
   ```
2. Importar `src/node-red/Flow_final.json` no Node-RED, definir `PROJETO_DIR` com o caminho desta pasta e fazer *Deploy*.
3. Importar o workflow `dataintegration/ETL_Monitorizacao_Producao` no KNIME, escrever a password do PostgreSQL nos nós *PostgreSQL Connector* e fazer *Reset all* + *Execute all*.
4. Na pasta `src/grafana`, executar `docker compose up -d`, abrir http://localhost:3000 e importar o dashboard.
