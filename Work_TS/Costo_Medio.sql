SELECT *
      FROM DO11_DOCTESTATA WITH (NOLOCK)
      INNER JOIN DO30_DOCCORPO WITH (NOLOCK) ON DO11_DITTA_CG18 = DO30_DITTA_CG18 AND DO11_NUMREG_CO99 = DO30_NUMREG_CO99 
      LEFT OUTER JOIN DO31_DOCCORPOORD WITH (NOLOCK) ON DO30_DITTA_CG18 = DO31_DITTA_CG18 AND DO30_NUMREG_CO99 = DO31_NUMREG_CO99 AND DO30_PROGRIGA = DO31_PROGRIGA 
      LEFT OUTER JOIN DO18_DOCTESORD WITH (NOLOCK) ON DO11_DITTA_CG18 = DO18_DITTA_CG18 AND DO11_NUMREG_CO99 = DO18_NUMREG_CO99 
      WHERE DO30_DITTA_CG18 = 1 AND DO30_INDTIPORIGA = 0 AND DO30_FLGAGGMAGAZ = 0 AND
            ISNULL(DO31_FLGNONPIUEV, 0) = 0 AND
            ISNULL(DO18_FLGNONPIUEV, 0) = 0 AND
            (
                  (DO30_QTA1 <> 0 AND ISNULL(DO31_QTA1CONS, 0) = 0) OR
                  (DO30_QTA1 > ISNULL(DO31_QTA1CONS, 0)) OR
                  (DO30_QTA1 = 0)
            )
            --AND DO11_DATAREG >= @DATA_INIZIO AND DO11_DATAREG <= @DATA_ELABORAZIONE 
            AND DO30_CODART_MG66 IS NOT NULL AND DO30_OPZIONE_MG5E IS NOT NULL
      

      
            /* Leggo ta tabella del costo medio nei parametri di magazzino e prendo solo documenti che hanno il progressivo = Sý*/
            AND EXISTS(SELECT 1 FROM MG51_CAUSMAGAGP WITH (NOLOCK) 
                             INNER JOIN MG46_PARMAGCOSTOM ON MG46_DITTA_CG18 = 1 AND MG46_INDTIPOTAB = 0
                                   AND MG46_NRCAMPO =  (CASE MG51_NRCAMPO
                                         WHEN 2  THEN 1          -- Giacenza iniziale
                                         WHEN 3  THEN 2          -- Carico fornitore
                                         WHEN 4  THEN 3          -- Carico produzione
                                         WHEN 5  THEN 4          -- Carico c/l clienti
                                         WHEN 6  THEN 5          -- Carico c/l fornitori
                                         WHEN 8  THEN 6          -- Carico omaggi
                                         WHEN 9  THEN 7          -- Carico trasferimento
                                         WHEN 10 THEN 8          -- Carico generico
                                         WHEN 11 THEN 9          -- Carico sostituzione
                                         WHEN 12 THEN 10         -- Carico libero 1
                                         WHEN 13 THEN 11         -- Carico libero 2
                                         WHEN 20 THEN 12         -- Scarico reso fornitore
                                         ELSE 0 END)
                             WHERE DO30_CAUSMAG_MG51 = MG51_CAUSMAGAGP AND MG51_INDAGQTA <> 0 AND MG46_FLAGATT = 1)

      and DO30_CODART_MG66 = 'FO03518AAQ00S'

order by DO30_CODART_MG66 , DO30_OPZIONE_MG5E , DO11_NUMREG_CO99
