IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'TSE_NUMCOPIE'))
DROP TABLE TSE_NUMCOPIE
GO

CREATE TABLE [TSE_NUMCOPIE](
                [NUMCOPIE_ID] DECIMAL(18,0) NOT NULL IDENTITY,
                [NUMCOPIE_PROGE] DECIMAL(6,0) NOT NULL,
CONSTRAINT [PK_TSE_NUMCOPIE] PRIMARY KEY CLUSTERED 
(
                [NUMCOPIE_ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

DECLARE @A DECIMAL(18)
DECLARE @B DECIMAL(18)

SET @A = 0
WHILE @A < 100
BEGIN
                SET @A = @A + 1
                
                SET @B = 0
                WHILE @B < @A
                BEGIN
                               SET @B = @B + 1
                               INSERT INTO TSE_NUMCOPIE SELECT @A
                END
END
