SELECT C.NAME AS 'ColumnName', T.NAME AS 'TableName'
FROM  SYS.columns C
INNER JOIN sys.tables T ON 
C.object_id = T.object_id
WHERE C.NAME LIKE 'MPCODICE'
ORDER BY TableName, ColumnName