create table  dept_table
(
    id_deptname varchar(30),
    emp_name varchar(30),
    salary decimal(10,2)
);

insert into dept_table
values
('1111-MATH','RAHUL',10000),
('1111-MATH','RAKESH',20000),
('2222-SCIENCE','AKASH',10000),
('2222-SCIENCE','ANDREW',10000),
('22-CHEM','ANKIT',25000),
('3333-CHEM','SONIKA',12000),
('4444-BIO','HITESH',2300),
('44-BIO','AKSHAY',10000);

--Find the total salary of each department 
select 
    id_deptname,
    SUM(salary) as Total_Salary
from dept_table
group by  id_deptname;