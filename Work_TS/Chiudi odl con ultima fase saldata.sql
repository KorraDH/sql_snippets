update do31_doccorpoord set do31_flgnonpiuev = 1, do31.indstatord = 9
from do11_doctestata
inner join do30_doccorpo
on do11_ditta_cg18 = do30_ditta_cg18
and do11_numreg_co99 = do30_numreg_co99
inner join do31_doccorpoord
on do11_ditta_cg18 = do31_ditta_cg18
and do11_numreg_co99 = do31_numreg_co99
and do30_progriga = do31_progriga
inner join do46_doccororddet a
on a.do46_ditta_cg18 = do30_ditta_cg18
and a.do46_numreg_co99 = do30_numreg_co99
and a.do46_progriga = do30_progriga
where 
do11_tipodoc = 24 and 
do11_stipodoc = 20 and
do46_indstatoord = 3 and /*
(CASE WHEN A.DO46_PROGSFASE = 0 THEN 
			ISNULL(ISNULL(A.DO46_QTA1CONSOLID,0) - 
			(SELECT ISNULL(SUM(ISNULL(C.DO46_QTA1CONSOLID,0)),0)
			 FROM DO46_DOCCORORDDET AS C 
			 WHERE 	C.DO46_DITTA_CG18  = A.DO46_DITTA_CG18 AND
			 	C.DO46_NUMREG_CO99 = A.DO46_NUMREG_CO99 AND
				C.DO46_CODFASE     = A.DO46_CODFASE AND
				(((A.DO46_PROGSFASE <> 0) AND (C.DO46_PROGSFASE = A.DO46_PROGSFASE)) OR
				 ((A.DO46_PROGSFASE = 0) AND (C.DO46_PROGSFASE <> 0)))),0)
			ELSE ISNULL(A.DO46_QTA1CONSOLID,0) END) >= a.DO46_QTA1ORD and */
do31_flgnonpiuev = 0
and not exists
(
	select 'a' from do46_doccororddet b
	where b.DO46_DITTA_CG18 = a.DO46_DITTA_CG18
	and b.DO46_numreg_co99 = a.DO46_numreg_co99
	and b.DO46_progriga = a.DO46_progriga
	and b.DO46_CODSEQFASE > a.DO46_CODSEQFASE
)
--order by do11_numdoc, do11_datadoc desc