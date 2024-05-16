Use Vaccination;

Select iso_code, country,
 case 
 when iso_code in ('ALB', 'AND', 'AUT', 'BEL') Then 'Europe'
 when iso_code in ('AZE', 'BGD') Then 'Asia'
 when iso_code in ('ARG') Then 'South America'
 else 'NA'
 end as Continent
from vaccination.country v;


Select iso_code, country,
 case 
 when iso_code in ('ALB', 'AND', 'AUT', 'BEL') Then 'Europe'
 when iso_code in ('AZE', 'BGD') Then 'Asia'
 when iso_code in ('ARG') Then 'South America'
 else 'NA'
 end as Continent
from vaccination.country 
where
case 
 when iso_code in ('ALB', 'AND', 'AUT', 'BEL') Then 'Europe'
 when iso_code in ('AZE', 'BGD') Then 'Asia'
 when iso_code in ('ARG') Then 'South America'
 else 'NA'
 end = 'Asia'; 
 
 
Select
 case 
 when iso_code in ('ALB', 'AND', 'AUT', 'BEL') Then 'Europe'
 when iso_code in ('AZE', 'BGD') Then 'Asia'
 when iso_code in ('ARG') Then 'South America'
 else 'NA'
 end as Continent, count(*)
from vaccination.country 
group by
case 
 when iso_code in ('ALB', 'AND', 'AUT', 'BEL') Then 'Europe'
 when iso_code in ('AZE', 'BGD') Then 'Asia'
 when iso_code in ('ARG') Then 'South America'
 end ;
 
 
 Use Employees;
 
 Select 
 case 
 when salary < 40000 then  'Entry level Pay'
 when salary > 60000 and salary <= 80000 then  'Next level Pay'
 when salary > 80000 and salary <= 100000 then  'Mid level Pay'
 when salary > 100000 then  'Mid Next level Pay'
 else 'NA'
 end  as pay_grade , count(*)
  from Salaries 
 group by 
case 
 when salary < 40000 then  'Entry level Pay'
 when salary > 60000 and salary <= 80000 then  'Next level Pay'
 when salary > 80000 and salary <= 100000 then  'Mid level Pay'
 when salary > 100000 then  'Mid Next level Pay'
 else 'NA'
 end
 order by salary;
 
 
 
 Select * from vaccination.country 
 where iso_code
 in (select iso_code from vaccination.country_vaccine);
 
  Select * from vaccination.country 
 where iso_code
 not in (select iso_code from vaccination.country_vaccine);
 
 
 Select * from vaccination.country c where exists( select * from vaccination.country_vaccine cv
 where c.iso_code = cv.iso_code);
 
 
 Select c.country, c.source_name, sq.num_vaccines
 from vaccination.country c
   left join(Select iso_code, count(vaccine_id) num_vaccines from vaccination.country_vaccine 
   group by iso_code) sq
   on c.iso_code = sq.iso_code ; 
   
   #CTE
   
   Use Employees;
   
   Select count(*), count(distinct s.emp_no) from salaries s
   where s.salary > avg(s.salary) ; 
   
   Select emp_no, (salary) from salaries s where s.from_date in 
   ( Select min(from_date) from employees.salaries i);
   

Use Employees;
Select d.dept_name, de.emp_no,s.salary, round(avg(s.salary) over (partition by dept_name))avg_dept_sal, (s.salary - round(avg(s.salary) over (partition by dept_name))) as diff_sal
from  employees.dept_emp de  
inner join employees.departments d     
on de.dept_no = d.dept_no 
inner join employees.salaries s   
on de.emp_no = s.emp_no
and     de.from_date = s.from_date  ;
   
Select * from(  
Select d.dept_name, de.emp_no,s.salary, round(avg(s.salary) over (partition by dept_name))avg_dept_sal, (s.salary - round(avg(s.salary) over (partition by dept_name))) as diff_sal
from  employees.dept_emp de  
inner join employees.departments d     
on de.dept_no = d.dept_no 
inner join employees.salaries s   
on de.emp_no = s.emp_no
and     de.from_date = s.from_date ) q where salary > dep_sal;

Select d.dept_name, de.emp_no,s.salary, rank() over (partition by dept_name order by salary desc)rank_within_dept
from  employees.dept_emp de  
inner join employees.departments d     
on de.dept_no = d.dept_no 
inner join employees.salaries s   
on de.emp_no = s.emp_no
and     de.from_date = s.from_date  ;


   
 