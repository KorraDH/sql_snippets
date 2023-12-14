SELECT *
FROM TABELLA
WHERE DATA > DATEADD(D,-50,SYSDATETIME()) --Selezione i record degli ultimi 50 giorni
