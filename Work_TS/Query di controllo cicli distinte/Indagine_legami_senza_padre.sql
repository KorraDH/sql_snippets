select * from PD95_DISBA
--delete from PD95_DISBA
where not exists 
(select 1 from PD96_LEGAMIDISBA
	where PD96_IDDISBA_PD95=PD95_IDDISBA)