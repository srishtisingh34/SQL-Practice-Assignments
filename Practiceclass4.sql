

Use Employees;

Alter table Employees.employees 
add primary key (emp_no);

Alter table Employees.employees 
drop primary key ; 
rollback;

alter table Employees.dept_emp 
add primary key(emp_no,dept_no);

alter table Employees.dept_emp 
drop primary key ;

Alter table employees.dept_emp
change column dept_no dept_no varchar(10) Not Null;

Alter table Employees.dept_emp
add foreign key dept_emp_fk(emp_no)
references Employees.employees(emp_no)
on delete cascade;

Select * from Employees.employees
where emp_no = 11810;

Delete from Employees.employees
where emp_no = 11810;


alter table Employees.dept_emp
drop foreign key dept_emp_ibfk_2;

rollback;


Alter table Employees.dept_emp
add foreign key dept_emp_fk(emp_no)
references Employees.employees(emp_no)
on delete set NULL;

Select emp_no, from_date, to_date, salary,
lag(salary, 2, 'NA') over (Partition by emp_no Order by emp_no, from_date) AS Previous_Salary
from Employees.salaries;

Select emp_no, from_date, to_date, salary,
lead(salary) over (Partition by emp_no Order by emp_no, from_date) AS Previous_Salary
from Employees.salaries;

Use Sacramento;

Select city, state from Sacramento.`sacramento-1`;

Select count(*), count(city), count(distinct city) from Sacramento.`sacramento-1`;

Select state from classicmodels.offices where state is null;

Select state from classicmodels.offices where state is not null;

select o.*, concat(state,',', country) State_city
from classicmodels.offices o;

alter table Employees.Salaries
add column Salary_ID int auto_increment primary key;

Select * from Employees.salaries;

 Select emp_no,  jobTitle, 
lead(jobTitle) over (Partition by emp_no Order by emp_no, from_date) AS Title from Employees.employees ;