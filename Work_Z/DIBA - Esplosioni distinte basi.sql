--CREAZIONE VISTE ESPLOSIONI DISITNTE BASI

CREATE VIEW ITER_ESPL_DISBA1 AS (
SELECT 1 AS LIVELLO1, M1.DBCODICE AS ASSIEME, D1.DBCODCOM AS COD_L1, D1.DBQTADIS AS QTA_L1, D1.DB__NOTE AS NOTA_L1
, 2 AS LIVELLO2, D2.DBCODCOM AS COD_L2, D2.DBQTADIS*D1.DBQTADIS  AS QTA_L2, D2.DB__NOTE AS NOTA_L2
, 3 AS LIVELLO3, D3.DBCODCOM AS COD_L3, D3.DBQTADIS*D2.DBQTADIS*D1.DBQTADIS  AS QTA_L3,D3.DB__NOTE AS NOTA_L3
FROM SCALADISMBASE M1
INNER JOIN SCALADISTBASE D1 ON
D1.DBCODICE=M1.DBCODICE
LEFT OUTER JOIN SCALAART_ICOL A2 ON
A2.ARCODART=D1.DBCODCOM
LEFT OUTER JOIN SCALADISTBASE D2 ON
D2.DBCODICE=A2.ARCODDIS
LEFT OUTER JOIN SCALAART_ICOL A3 ON
A3.ARCODART=D2.DBCODCOM
LEFT OUTER JOIN SCALADISTBASE D3 ON
D3.DBCODICE=A3.ARCODDIS
)

GO

CREATE VIEW ITER_ESPL_DISBA2 AS (
SELECT DISTINCT ASSIEME, LIVELLO1 AS LIVELLO, COD_L1 AS CODICE, QTA_L1 AS QTA, CAST(NOTA_L1 AS VARCHAR(200)) AS NOTA
FROM ITER_ESPL_DISBA1
WHERE QTA_L1 <> 0
UNION ALL 
SELECT DISTINCT ASSIEME, LIVELLO2 AS LIVELLO, COD_L2 AS CODICE, QTA_L2 AS QTA, CAST(NOTA_L2 AS VARCHAR(200)) AS NOTA
FROM ITER_ESPL_DISBA1
WHERE QTA_L2 <> 0
UNION ALL 
SELECT DISTINCT ASSIEME, LIVELLO3 AS LIVELLO, COD_L3 AS CODICE, QTA_L3 AS QTA, CAST(NOTA_L3 AS VARCHAR(200)) AS NOTA
FROM ITER_ESPL_DISBA1
WHERE QTA_L3 <> 0
)
 
GO

--SELECT * FROM ITER_ESPL_DISBA2 WHERE ASSIEME = 'TN.004.001|001'