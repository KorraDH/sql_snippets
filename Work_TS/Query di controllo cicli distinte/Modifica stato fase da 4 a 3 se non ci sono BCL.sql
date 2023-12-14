--UPDATE DO46_DOCCORORDDET SET DO46_INDSTATOORD = 3
SELECT DO11_DOCUM_MG36, DO11_SEZDOC, DO11_NUMDOC, DO30_CODART_MG66, MG87_DESCART, DO46_CODFASE, DO46_DESCRFASE, DO41_CODPROGETTO, DO46_INDSTATOORD, DO46_CLIFOR_CG44
--, *
FROM DO11_DOCTESTATA
INNER JOIN DO30_DOCCORPO ON
DO30_DITTA_CG18 = DO11_DITTA_CG18 AND
DO30_NUMREG_CO99 = DO11_NUMREG_CO99
INNER JOIN MG87_ARTDESC ON
MG87_DITTA_CG18 = DO30_DITTA_CG18 AND
MG87_CODART_MG66 = DO30_CODART_MG66
INNER JOIN DO46_DOCCORORDDET ON
DO46_DITTA_CG18 = DO30_DITTA_CG18 AND
DO46_NUMREG_CO99 = DO30_NUMREG_CO99 AND
DO46_PROGRIGA = DO30_PROGRIGA
INNER JOIN DO41_DOCCORPOPROGE ON
DO41_DITTA_CG18 = DO30_DITTA_CG18 AND
DO41_NUMREG_CO99 = DO30_NUMREG_CO99 AND
DO41_PROGRIGA = DO30_PROGRIGA
WHERE DO11_TIPODOC = 24 AND DO11_STIPODOC = 20
--AND DO46_CLIFOR_CG44 = 1771 AND DO11_ANNODOC >= 2014
AND DO46_INDSTATOORD = 4
AND NOT EXISTS (SELECT 1 FROM DO33_DOCCORPORIF DO33_DDT 
					INNER JOIN DO11_DOCTESTATA DO11_DDT ON
					DO11_DDT.DO11_DITTA_CG18=DO33_DDT.DO33_DITTA_CG18 AND
					DO11_DDT.DO11_NUMREG_CO99=DO33_DDT.DO33_NUMREG_CO99
					WHERE DO11_DDT.DO11_DOCUM_MG36 = 'FP-BCL' 
					AND DO11_DDT.DO11_CLIFOR_CG44 = DO46_CLIFOR_CG44 
					AND DO33_DDT.DO33_NUMREGRIF_CO99=DO11_NUMREG_CO99)