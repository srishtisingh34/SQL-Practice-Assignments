
Select cv.iso_code, v.vaccines
from vaccination.vaccine v
inner join vaccination.country_vaccine cv
on v.vaccine_id = cv.vaccine_id;   #12 rows

Select cv.iso_code, v.vaccines
from vaccination.vaccine v
left outer join vaccination.country_vaccine cv
on v.vaccine_id = cv.vaccine_id;   #14 rows

#Right outer Join

Select c.country, v.vaccines
from vaccination.country_vaccine cv
right outer join vaccination.country c 
on cv.iso_code = c.iso_code;   #12 rows

Select  c.country, v.vaccines
from vaccination.vaccine v
left outer join vaccination.country_vaccine cv 
on v.vaccine_id = cv.vaccine_id right outer join country c on cv.iso_code = c.iso_code ;

#Union Clause and union All allows duplicate

SET SQL_SAFE_UPDATES = 0;


Select * from classicmodels.customers
where state is null;


Update classicmodels.customers
set state = 'Not Available'
where state is null;
commit;


