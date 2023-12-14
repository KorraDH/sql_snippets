SELECT	T_OC.do11_ditta_cg18 AS DITTA, 
		T_OC.DO11_DOCUM_MG36 as DOC_ORIG, 
		T_BC.DO11_DOCUM_MG36 AS DOC_CONS, 
		T_OC.DO11_NUMDOC as NUM_ORD, 
		C_OC.DO30_PROGVISUASTA AS RIGA_ORD,
		T_OC.DO11_DATAREG as DATA_ORD, 
		DO31_DOCCORPOORD.DO31_DATACONSINT as DATA_CONFERMATA, 
		DO31_DOCCORPOORD.DO31_DATACONS as DATA_RICH, 
		C_OC.DO30_QTA1 as QTA_ORDINATA, 
		DO31_DOCCORPOORD.DO31_QTA1CONS as QTA_CONSEGNATA, 
		T_BC.DO11_NUMDOC AS NUM_DDT, 
	--	T_BC.do11_numdocorig as num_DDT, 
		T_BC.DO11_DATADOC as DATA_DDT, 
		T_BC.DO11_DATAREG AS DATA_REG_DDT, 
		C_OC.DO30_CODART_MG66 AS CODART, 
		C_OC.DO30_DESCART as DESCART,
		C_BC.DO30_QTA1 AS QTA_EVASA,
		do33_doccorporif.DO33_NUMVSDOC as NUM_VS_DOC, 
		DO33_DOCCORPORIF.DO33_DATAVSDOC as DATA_VS_DOC, 
		CG44_CLIFOR.CG44_CLIFOR as COD_CLI, 
		(ltrim(rtrim(CG16_ANAGGEN.CG16_RAGSOANAG))) as RAGSOC_CLI,
/*		MG19_CLIFORVA.MG19_RAGGRCF1 AS Qualifica, 
		MG19_CLIFORVA.MG19_RAGGRCF2 AS Cod_Fornitura, 
		MG19_CLIFORVA.MG19_RAGGCRF3 AS Outsourcing, 
		MG19_CLIFORVA.MG19_SC1PERCOR AS IF_D, 
		MG19_CLIFORVA.MG19_SC2PERCOR AS IF_G, 
			 case  T_OC.DO11_DOCUM_MG36 when 'FP-OT' then datediff(day,DO31_DOCCORPOORD.DO31_DATACONS, T_BC.DO11_DATAREG )
				else  datediff(day,DO31_DOCCORPOORD.DO31_DATACONSint, T_BC.DO11_DATAREG)
			end as GG_RITARDO */
			datediff(day,DO31_DOCCORPOORD.DO31_DATACONSint, T_BC.DO11_DATAREG) as GG_RITARDO, 
			C_BC.DO30_PREZZO1 AS IMPORTO_UNI,
			C_BC.DO30_IMPORTO AS IMPORTO_TOT

FROM    DO11_DOCTESTATA AS T_OC 
		
		INNER JOIN DO30_DOCCORPO AS C_OC ON 
		T_OC.DO11_DITTA_CG18 = C_OC.DO30_DITTA_CG18 AND	
		T_OC.DO11_NUMREG_CO99 = C_OC.DO30_NUMREG_CO99
		
		INNER JOIN DO33_DOCCORPORIF ON 
		C_OC.DO30_DITTA_CG18 = DO33_DOCCORPORIF.DO33_DITTA_CG18 AND 
		C_OC.DO30_NUMREG_CO99 = DO33_DOCCORPORIF.DO33_NUMREGRIF_CO99 AND 
		C_OC.DO30_PROGRIGA = DO33_DOCCORPORIF.DO33_PROGRIGARIF_DO30 
		
		INNER JOIN DO30_DOCCORPO AS C_BC 
		
		INNER JOIN DO11_DOCTESTATA AS T_BC ON 
		C_BC.DO30_DITTA_CG18 = T_BC.DO11_DITTA_CG18 AND 
		C_BC.DO30_NUMREG_CO99 = T_BC.DO11_NUMREG_CO99 ON DO33_DOCCORPORIF.DO33_DITTA_CG18 = C_BC.DO30_DITTA_CG18 AND 
		DO33_DOCCORPORIF.DO33_NUMREG_CO99 = C_BC.DO30_NUMREG_CO99 AND 
		DO33_DOCCORPORIF.DO33_PROGRIGA = C_BC.DO30_PROGRIGA 
		
		INNER JOIN DO31_DOCCORPOORD ON 
		C_OC.DO30_DITTA_CG18 = DO31_DOCCORPOORD.DO31_DITTA_CG18 AND 
		C_OC.DO30_NUMREG_CO99 = DO31_DOCCORPOORD.DO31_NUMREG_CO99 AND 
		C_OC.DO30_PROGRIGA = DO31_DOCCORPOORD.DO31_PROGRIGA 
		
		INNER JOIN CG44_CLIFOR ON 
		T_BC.DO11_DITTACF_CG44 = CG44_CLIFOR.CG44_DITTA_CG18 AND 
		T_BC.DO11_TIPOCF_CG44 = CG44_CLIFOR.CG44_TIPOCF AND
		T_BC.DO11_CLIFOR_CG44 = CG44_CLIFOR.CG44_CLIFOR 
		
	/*	INNER JOIN MG19_CLIFORVA ON 
		CG44_CLIFOR.CG44_DITTA_CG18 = MG19_CLIFORVA.MG19_DITTA_CG18 AND 
		CG44_CLIFOR.CG44_TIPOCF = MG19_CLIFORVA.MG19_TIPOCF_CG44 AND 
		CG44_CLIFOR.CG44_CLIFOR = MG19_CLIFORVA.MG19_CLIFOR_CG44 
	*/	
		INNER JOIN CG16_ANAGGEN ON CG44_CLIFOR.CG44_CODICE_CG16 = CG16_ANAGGEN.CG16_CODICE

WHERE	(T_BC.DO11_DOCUM_MG36 = 'C-BV') AND c_BC.DO30_INDTIPORIGA = 0 and(T_OC.DO11_DOCUM_MG36 = 'C-OV') 
		-- OR ((T_BC.DO11_DOCUM_MG36 = 'C-BRR') OR (T_BC.DO11_DOCUM_MG36 = 'C-BRRG')) AND c_BC.DO30_INDTIPORIGA = 0 AND (T_OC.DO11_DOCUM_MG36 = 'C-OR') 
					/* OR (T_BC.DO11_DOCUM_MG36 = 'f-bcla') AND (T_OC.DO11_DOCUM_MG36 = 'F-OF-CL') */