select year,'-',month,'-',day,ggg, substr(ob.obs,6,3), namecntry
INTO OUTFILE 'c:/sidc_nso/gndb/preMM.csv' FIELDS TERMINATED BY ','
from gndb g , gn_obs ob
where substr(year,1,4)>= '1610'
and substr(year,1,4) <= '1720'
and substr(station,3,3) = substr(ob.obs,6,3)
order by year,month,day
;


select sum(ggg), substr(ob.obs,6,3), namecntry, count(*)
INTO OUTFILE 'c:/sidc_nso/gndb/preMM_obs.csv' FIELDS TERMINATED BY ','
from gndb g , gn_obs ob
where substr(year,1,4)>= '1610'
and substr(year,1,4) <= '1720'
and substr(station,3,3) = substr(ob.obs,6,3)
group by substr(ob.obs,6,3)
order by year,month,day
;

INTO OUTFILE 'c:/gndb/gnobs.csv' FIELDS TERMINATED BY ','
and substr(namecntry,1,30) like '%GAL%'
and substr(g.obs,1,3) = '001'