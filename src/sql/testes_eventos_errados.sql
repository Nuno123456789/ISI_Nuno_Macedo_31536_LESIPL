-- Teste de validação: insere 4 eventos de produção com erros na tabela eventos_producao.
-- O KNIME (metanode "Eventos e OEE", Rule Engine) deve marcá-los como Invalido
-- e deixá-los fora do cálculo do OEE e do OLE.
-- Não altera nem apaga dados existentes.

INSERT INTO eventos_producao
    (maquina_id, data_hora, data_fim, estado, tipo_evento, motivo,
     pecas_produzidas, pecas_rejeitadas, codigo_op, operador_id,
     tempo_espera_segundos, tempo_intervencao_segundos)
VALUES
    -- 1. Paragem sem motivo (o motivo é obrigatório nas paragens)
    ('M001', '2026-10-20 00:45:00', '2026-10-20 00:46:00', 'PARADA',   'PARAGEM',  NULL,
     0, 0, '2609394', (SELECT MIN(id) FROM operadores), 60, 0),
    -- 2. Produção com motivo (na produção o motivo deve vir vazio)
    ('M002', '2026-10-20 00:45:00', '2026-10-20 00:46:00', 'PRODUCAO', 'PRODUCAO', 'Motivo indevido',
     0, 0, '2609395', (SELECT MIN(id) FROM operadores), 0, 0),
    -- 3. Tipo de evento que não existe
    ('M003', '2026-10-20 00:45:00', '2026-10-20 00:46:00', 'PARADA',   'PAUSA',    'Pausa nao prevista',
     0, 0, '2609396', (SELECT MIN(id) FROM operadores), 60, 0),
    -- 4. Estado que não existe
    ('M001', '2026-10-20 00:47:00', '2026-10-20 00:48:00', 'LIGADA',   'PRODUCAO', NULL,
     0, 0, '2609394', (SELECT MIN(id) FROM operadores), 0, 0);

-- Ver os eventos inseridos
SELECT id, maquina_id, data_hora, estado, tipo_evento, motivo
FROM eventos_producao
WHERE data_hora IN ('2026-10-20 00:45:00', '2026-10-20 00:47:00')
ORDER BY id;
