DECLARE @ART AS VARCHAR(20) = 'S-238-OM0011'

UPDATE STARPART_ICOL SET ARUNMIS1= 'Pz' WHERE ARCODART=@ART

UPDATE STARPKEY_ARTI SET CAUNIMIS='Pz' WHERE CACODART=@ART

UPDATE STARPLIS_TINI SET LIUNIMIS='Pz' WHERE LICODART=@ART

UPDATE STARPDOC_DETT SET MVUNIMIS='Pz' WHERE MVCODART=@ART

UPDATE STARPMVM_DETT SET MMUNIMIS='Pz' WHERE MMCODART=@ART

UPDATE STARPCON_TRAD SET COUNIMIS='Pz' WHERE COCODART=@ART

UPDATE STARPDISTBASE SET DBUNIMIS='Pz' WHERE DBCODCOM=@ART

UPDATE STARPRILEVAZI SET DRUNIMIS='Pz' WHERE DRCODART=@ART
