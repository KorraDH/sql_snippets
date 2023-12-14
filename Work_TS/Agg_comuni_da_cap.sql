
update cg16_anaggen
set CG16_CODICEFISC_CG07=null
where CG16_CODICEFISC_CG07=86

update cg16_anaggen
set CG16_CODICE_CG07=null
where CG16_CODICE_CG07=86


--update della query precedente
update cg16_anaggen 
set cg16_comana_cg01 = cg01_codice
from cg16_anaggen 
inner join CG01_ANAGCOMUNI on cg16_cap = cg01_cap
where cg16_comana_cg01 is null

 

--verifica quante anagrafiche hanno comune NULL
select * from cg16_anaggen 
where cg16_comana_cg01 is null

 
--stesse query ma per il campo COMFIS
 

--controlla se ci sono anagrafiche con codice COMUNE fiscale NULL 
--ma con città presente neela anagrafica dei comuni
select * from cg16_anaggen 
inner join CG01_ANAGCOMUNI on cg16_citta = cg01_descr
where cg16_comfis_cg01 is null

--update della query precedente
update cg16_anaggen 
set cg16_comfis_cg01 = cg01_codice
from cg16_anaggen 
inner join CG01_ANAGCOMUNI on
cg16_citta = cg01_descr
where cg16_comfis_cg01 is null



--controlla se ci sono anagrafiche con codice COMUNE fiscale NULL 
--ma con CAP presente neela anagrafica dei comuni
select * from cg16_anaggen 
inner join CG01_ANAGCOMUNI on cg16_cap = cg01_cap
where cg16_comfis_cg01 is null

--update della query precedente
update cg16_anaggen 
set cg16_comfis_cg01 = cg01_codice
from cg16_anaggen 
inner join CG01_ANAGCOMUNI on cg16_cap = cg01_cap
where cg16_comfis_cg01 is null

 update cg16_anaggen
set cg16_codicefisc_cg07 = cg16_codice_cg07
where cg16_codice_cg07 is not null


--verifica quante anagrafiche hanno comune fiscale NULL
select * from cg16_anaggen 
where cg16_comfis_cg01 is null
