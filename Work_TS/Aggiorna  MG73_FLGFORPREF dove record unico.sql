
UPDATE MG73_ARTCLIFOR SET MG73_FLGFORPREF = 1
WHERE MG73_TIPOCF_CG44 = 1 
AND MG73_CODART_MG66 IN (
						SELECT MG73_CODART_MG66
						FROM MG73_ARTCLIFOR
						GROUP BY MG73_CODART_MG66
						HAVING COUNT(MG73_CODART_MG66) = 1
						)