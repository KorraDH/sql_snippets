ALTER TRIGGER TRG_GB_AVA_DO30_INS
    ON DO30_DOCCORPO 
    AFTER INSERT 
AS 
BEGIN 
    SET NOCOUNT ON
    
	UPDATE 
		DO30_DOCCORPO
	SET 
		DO30_MAGIMP = ISNULL(MG43_NUMPERS1,0)
	FROM 
		inserted 
	INNER JOIN 
		DO30_DOCCORPO 
	ON	
		inserted.DO30_DITTA_CG18=DO30_DOCCORPO.DO30_DITTA_CG18 AND
		inserted.DO30_NUMREG_CO99=DO30_DOCCORPO.DO30_NUMREG_CO99 AND
		inserted.DO30_PROGRIGA=DO30_DOCCORPO.DO30_PROGRIGA

	INNER JOIN 
		DO11_DOCTESTATA
	ON 
		inserted.DO30_DITTA_CG18 = DO11_DOCTESTATA.DO11_DITTA_CG18 AND 
		inserted.DO30_NUMREG_CO99 = DO11_DOCTESTATA.DO11_NUMREG_CO99 
	LEFT OUTER JOIN 
		MG43_ARTPERS
	ON
		inserted.DO30_DITTA_CG18 = MG43_ARTPERS.MG43_DITTA_CG18 AND
		inserted.DO30_CODART_MG66 = MG43_ARTPERS.MG43_CODART_MG66
	WHERE 
		(DO11_DOCTESTATA.DO11_TIPODOC = 24 AND DO11_DOCTESTATA.DO11_STIPODOC = 4) AND MG43_PROG = 1
	
END
