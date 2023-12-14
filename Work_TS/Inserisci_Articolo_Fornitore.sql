USE GASPARIN
GO
INSERT INTO MG73_ARTCLIFOR ([MG73_DITTA_CG18]
           ,[MG73_ARTCLIFOR]
           ,[MG73_TIPOCF_CG44]
           ,[MG73_CLIFOR_CG44]
           ,[MG73_CODART_MG66]
           ,[MG73_OPZIONE_MG5E]
           ,[MG73_FLGDESCPERS]
           ,[MG73_INDDISPROD]
           ,[MG73_DESCARTCF]
           ,[MG73_DESCARTESTCF]
           ,[MG73_INDARTSTAM]
           ,[MG73_GGCONS]
           ,[MG73_NOTEARTCF]
           ,[MG73_INDGIORNI]
           ,[MG73_IMPSPESE]
           ,[MG73_DTCREAZ]
           ,[MG73_DTULTAGG]
           ,[MG73_DTDISMISSIONE]
           ,[MG73_DTULTACQVEN]
           ,[MG73_QTA1ULACQVEN]
           ,[MG73_QTA2ULACQVEN]
           ,[MG73_COLLIULACQVEN]
           ,[MG73_FLGFORPREF]
           ,[MG73_FLGLOTTIFIX]
           ,[MG73_LOTTOMIN]
           ,[MG73_LOTTOMULT]
           ,[MG73_LOTTOMAX]
           ,[MG73_INDCALCQTACF]
           ,[MG73_FATTCONV]
           ,[MG73_CONFRIFER_MG96]
           ,[MG73_CODAFFIDABIL]
           ,[MG73_CODFLESSIBIL]
           ,[MG73_PERCSCARTI]
           ,[MG73_IDMEDIA_CG99]
           ,[MG73_PERCRIPART]
           ,[MG73_PRIORITA]
           ,[MG73_UMCF]
           ,[MG73_INDCALCPRECF])

SELECT 1, 
MG66_CODART, 1, 
3852, --CODICE FORNITORE
MG66_CODART, '',0,0,NULL,NULL,0,0,NULL,0,0,GETUTCDATE(),GETUTCDATE(),NULL,NULL,0,0,0,1,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0
FROM MG66_ANAGRART 
INNER JOIN MG87_ARTDESC ON
MG66_DITTA_CG18=MG87_DITTA_CG18 AND
MG66_CODART=MG87_CODART_MG66
WHERE 
MG66_GRUSTAT4_MG77 = 'CA' --GRUPPO STATISTICO 4

AND MG66_CODART LIKE '9124%'			--CODICE ARTICOLO (INIZIA CON...)
--AND MG87_DESCART LIKE '%PLEXIGLASS%')	--RICERCA PER DESCRIZIONE ARTICOLO
AND MG66_MARCA_MG64 = 'FESTO'			--MARCA ARTICOLO

AND NOT EXISTS (SELECT 1 
					FROM MG73_ARTCLIFOR 
					WHERE MG73_DITTA_CG18=MG66_DITTA_CG18 AND
					MG73_CODART_MG66=MG66_CODART AND
					MG73_TIPOCF_CG44 = 1
				)