-- Query di partenza che seleziona i cicli che sono associati a pi� articoli
SELECT DISTINCT A.PD18_CODART_MG66, A.PD18_CODCICLO, B.*
FROM PD18_ARTPROD A
INNER JOIN PD48_CICLI B ON
B.PD48_DITTA_CG18=A.PD18_DITTA_CG18 AND
B.PD48_CICLO_PD52=A.PD18_CODCICLO
WHERE A.PD18_CODCICLO IS NOT NULL AND PD48_IDDISBA_PD95 IS NULL
AND A.PD18_CODART_MG66<>A.PD18_CODCICLO
	AND A.PD18_CODCICLO IN (SELECT C.PD18_CODCICLO FROM PD18_ARTPROD C
													GROUP BY C.PD18_CODCICLO
													HAVING COUNT(C.PD18_CODART_MG66)>1 )
ORDER BY 1

-- Inserisco le testate dei cicli sulla PD52
INSERT INTO PD52_ANAGCICLI (PD52_DITTA_CG18, PD52_CODICE, PD52_VERSIONE, PD52_DESCR) 
(SELECT DISTINCT A.PD18_DITTA_CG18, A.PD18_CODART_MG66, '0', SUBSTRING(MG87_DESCART,1,40)
FROM PD18_ARTPROD A
INNER JOIN PD48_CICLI B ON
B.PD48_DITTA_CG18=A.PD18_DITTA_CG18 AND
B.PD48_CICLO_PD52=A.PD18_CODCICLO
LEFT OUTER JOIN MG87_ARTDESC ON
MG87_DITTA_CG18=A.PD18_DITTA_CG18 AND
MG87_CODART_MG66=A.PD18_CODART_MG66
WHERE A.PD18_CODCICLO IS NOT NULL AND PD48_IDDISBA_PD95 IS NULL
AND A.PD18_CODART_MG66<>A.PD18_CODCICLO
	AND A.PD18_CODCICLO IN (SELECT C.PD18_CODCICLO FROM PD18_ARTPROD C
													GROUP BY C.PD18_CODCICLO
													HAVING COUNT(C.PD18_CODART_MG66)>1 )
AND NOT EXISTS (SELECT 1 FROM PD52_ANAGCICLI WHERE PD52_CODICE=A.PD18_CODART_MG66)
)

-- Inserisco le righe dei cicli sulla PD48
INSERT INTO [PD48_CICLI]
           ([PD48_DITTA_CG18]
           ,[PD48_CICLO_PD52]
           ,[PD48_VERSIONE_PD52]
           ,[PD48_SEQFASE]
           ,[PD48_CODFASE_PD12]
           ,[PD48_PROGFASE]
           ,[PD48_INDTIPOPROV]
           ,[PD48_IDDISBA_PD95]
           ,[PD48_CODREP_PD07]
           ,[PD48_CODFORN_CG44]
           ,[PD48_MACCHINA_PD08]
           ,[PD48_DATINIVAL]
           ,[PD48_DATFINVAL]
           ,[PD48_TMACSETUP]
           ,[PD48_INDUMSETUP]
           ,[PD48_FORMSETUP_PD24]
           ,[PD48_TMACLAV]
           ,[PD48_INDUMLAV]
           ,[PD48_FORMLAV_PD24]
           ,[PD48_NUMPEZZIUM]
           ,[PD48_TATTESA]
           ,[PD48_INDUMATTESA]
           ,[PD48_INDUMCODA]
           ,[PD48_TCODA]
           ,[PD48_ARTATTR_PD26]
           ,[PD48_VARATTR_PD26]
           ,[PD48_KIT_PD56]
           ,[PD48_NOTA]
           ,[PD48_COSTOCICLO]
           ,[PD48_IDENTPROG]
           ,[PD48_PERCATTFSUCC]
           ,[PD48_PERCREND]
           ,[PD48_IDMEDIA_CG99]
           ,[PD48_TTOTLAV]
           ,[PD48_INDUMTOTLAV]
           ,[PD48_NUMPEZSETUP]
           ,[PD48_FORMTOT_PD24]
           ,[PD48_DESCRFASE]
           ,[PD48_INDTIPOFASE]
           ,[PD48_TEMPOCRITICO]
           ,[PD48_VALENZAMINIMA]
           ,[PD48_VALENZAMASSIMA]
           ,[PD48_LIVELLO1]
           ,[PD48_LIVELLO2]
           ,[PD48_LIVELLO3]
           ,[PD48_LIVELLO4]
           ,[PD48_LIVELLO5]
           ,[PD48_SQPREP_PD10]
           ,[PD48_SQLAV_PD10]
           ,[PD48_NUMIMPRONTE]
           ,[PD48_INDESCLCICLOAP])
(SELECT DISTINCT B.PD48_DITTA_CG18, A.PD18_CODART_MG66, B.[PD48_VERSIONE_PD52]
           ,B.[PD48_SEQFASE]
           ,B.[PD48_CODFASE_PD12]
           ,B.[PD48_PROGFASE]
           ,B.[PD48_INDTIPOPROV]
           ,B.[PD48_IDDISBA_PD95]
           ,B.[PD48_CODREP_PD07]
           ,B.[PD48_CODFORN_CG44]
           ,B.[PD48_MACCHINA_PD08]
           ,B.[PD48_DATINIVAL]
           ,B.[PD48_DATFINVAL]
           ,B.[PD48_TMACSETUP]
           ,B.[PD48_INDUMSETUP]
           ,B.[PD48_FORMSETUP_PD24]
           ,B.[PD48_TMACLAV]
           ,B.[PD48_INDUMLAV]
           ,B.[PD48_FORMLAV_PD24]
           ,B.[PD48_NUMPEZZIUM]
           ,B.[PD48_TATTESA]
           ,B.[PD48_INDUMATTESA]
           ,B.[PD48_INDUMCODA]
           ,B.[PD48_TCODA]
           ,B.[PD48_ARTATTR_PD26]
           ,B.[PD48_VARATTR_PD26]
           ,B.[PD48_KIT_PD56]
           ,B.[PD48_NOTA]
           ,B.[PD48_COSTOCICLO]
           ,B.[PD48_IDENTPROG]
           ,B.[PD48_PERCATTFSUCC]
           ,B.[PD48_PERCREND]
           ,B.[PD48_IDMEDIA_CG99]
           ,B.[PD48_TTOTLAV]
           ,B.[PD48_INDUMTOTLAV]
           ,B.[PD48_NUMPEZSETUP]
           ,B.[PD48_FORMTOT_PD24]
           ,B.[PD48_DESCRFASE]
           ,B.[PD48_INDTIPOFASE]
           ,B.[PD48_TEMPOCRITICO]
           ,B.[PD48_VALENZAMINIMA]
           ,B.[PD48_VALENZAMASSIMA]
           ,B.[PD48_LIVELLO1]
           ,B.[PD48_LIVELLO2]
           ,B.[PD48_LIVELLO3]
           ,B.[PD48_LIVELLO4]
           ,B.[PD48_LIVELLO5]
           ,B.[PD48_SQPREP_PD10]
           ,B.[PD48_SQLAV_PD10]
           ,B.[PD48_NUMIMPRONTE]
           ,B.[PD48_INDESCLCICLOAP]
FROM PD18_ARTPROD A
INNER JOIN PD48_CICLI B ON
B.PD48_DITTA_CG18=A.PD18_DITTA_CG18 AND
B.PD48_CICLO_PD52=A.PD18_CODCICLO
WHERE A.PD18_CODCICLO IS NOT NULL AND PD48_IDDISBA_PD95 IS NULL
AND A.PD18_CODART_MG66<>A.PD18_CODCICLO
	AND A.PD18_CODCICLO IN (SELECT C.PD18_CODCICLO FROM PD18_ARTPROD C
													GROUP BY C.PD18_CODCICLO
													HAVING COUNT(C.PD18_CODART_MG66)>1 )
)

-- Associo i nuovi cicli sulla PD18
UPDATE PD18_ARTPROD SET PD18_CODCICLO = PD18_CODART_MG66
WHERE PD18_CODART_MG66 IN ( SELECT DISTINCT A.PD18_CODART_MG66
							FROM PD18_ARTPROD A
							WHERE A.PD18_CODCICLO IS NOT NULL 
							AND A.PD18_CODART_MG66<>A.PD18_CODCICLO
								AND A.PD18_CODCICLO IN (SELECT C.PD18_CODCICLO FROM PD18_ARTPROD C
																				GROUP BY C.PD18_CODCICLO
																				HAVING COUNT(C.PD18_CODART_MG66)>1 )
)