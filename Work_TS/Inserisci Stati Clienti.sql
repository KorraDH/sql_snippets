INSERT INTO [dbo].[CO4H_STATIATTUALI]
           ([CO4H_GUID]
           ,[CO4H_IDSTATO_CO4C]
           ,[CO4H_DATAVALIDITA]
           ,[CO4H_IDFLUSSO_CO4B]
           ,[CO4H_INDAUTH]
           ,[CO4H_AUTO])

SELECT 
CG44_CLIFOR.CG44_GUID, 
10002,							--ID STATO
'2016-06-17 00:00:00.000',		--DATA VALIDITA' STATO
10001,							--ID FLUSSO
0, 
0
FROM CG44_CLIFOR
INNER JOIN MG19_CLIFORVA ON
MG19_DITTA_CG18=CG44_DITTA_CG18 AND
MG19_TIPOCF_CG44=CG44_TIPOCF AND
MG19_CLIFOR_CG44=CG44_CLIFOR
WHERE CG44_TIPOCF = 0 AND MG19_DATADISMIS IS NULL
AND NOT EXISTS ( SELECT 1 FROM CO4H_STATIATTUALI WHERE CO4H_GUID=CG44_GUID)
