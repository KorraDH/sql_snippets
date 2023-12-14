--Query per trovare il numero di riga nel caso si ripetano le stesse condizioni
--Nell'esempio seguente mi serve per ciclare sui cicli importati e trovare un nuovo codice fase
--se esso è duplicato all'interno del ciclo

SELECT COD_CICLO, SEQ,	ROW_NUMBER() OVER (PARTITION BY COD_CICLO, COD_FASE ORDER BY COD_CICLO, SEQ, COD_FASE) AS ID, 
COD_FASE,	(COD_FASE - 1 + ROW_NUMBER() OVER (PARTITION BY COD_CICLO, COD_FASE ORDER BY COD_CICLO, SEQ, COD_FASE)) AS NEW_COD_FASE
--, *
FROM _WAL_CICLI
ORDER BY COD_CICLO, SEQ


-- Eventualmente, con la medesima sintassi, si può utilizzare il camndo RANK() o DENSE_RANK() per fare numerazioni progressive.
