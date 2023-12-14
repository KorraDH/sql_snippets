alter function FN_TEX_Corpo 
(@ditta decimal(5,0), 
@numreg char(12) 
)

RETURNS VARCHAR(Max)
as

BEGIN
--DECLARE @ditta Numeric
--DECLARE @numreg varchar(25)
DECLARE @riga decimal(6,0)
DECLARE @codice varchar(25)
DECLARE @descrizione varchar(90)
DECLARE @Risultato varchar(8000)
DECLARE @Qta decimal(14,3)
SET @Risultato = ''

--set @ditta = 1
--set @numreg = '201200046750'

DECLARE db_cursor CURSOR FOR  
SELECT Do30_PROGVISUASTA, DO30_CODART_MG66, MG87_DESCART, Do30_QTA1 FROM DO30_DOCCORPO
INNER JOIN MG87_ARTDESC  ON MG87_DITTA_CG18 = DO30_DITTA_CG18 AND MG87_CODART_MG66 = DO30_CODART_MG66 AND MG87_OPZIONE_MG5E = '' AND MG87_LINGUA_MG52 = ''
WHERE Do30_DITTA_CG18 = @Ditta AND Do30_NUMREG_CO99 = @numreg
ORDER BY Do30_PROGVISUASTA 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @riga, @codice, @descrizione  , @Qta

WHILE @@FETCH_STATUS = 0   
BEGIN   
    --PRINT @Codice + ' ' + @Descrizione
    --SELECT @Risultato =  ltrim(@Risultato) + char(10) + convert(varchar(3),@riga) + ' - ' + rtrim(ltrim(@Codice)) + ' - ' + rtrim(ltrim(@Descrizione)) + ' - Qta: ' + CONVERT(varchar(10) , @qta)
    SELECT @Risultato =  ltrim(@Risultato) + char(10) + rtrim(ltrim(@Codice)) + ' - ' + rtrim(ltrim(@Descrizione)) + ' - Qta: ' + CONVERT(varchar(10) , @qta)

FETCH NEXT FROM db_cursor INTO @riga, @Codice, @Descrizione, @qta
END   

CLOSE db_cursor   
DEALLOCATE db_cursor
--SELECT @Risultato = ltrim(@Risultato) + char(10) + 'FINE'
--print @Risultato
--print len(@Risultato)
return  ltrim(@Risultato)

END