create table  email_signup
(
    email_id varchar (100),
    signup_date date 
);

insert into  email_signup
values
('john@gmail.com','2020-01-10'),
('john@gmail.com','2021-05-15'),
('mary@gmail.com','2019-03-20'),
('mary@gmail.com','2022-08-12'),
('akash@gmail.com',NULL),
('akash@gmail.com','2020-11-05'),
('rahul@yahoo.com','2021-01-01'),
('rahul@yahoo.com',NULL),
('sonika@gmail.com','2018-07-14'),
('sonika@gmail.com','2023-02-18');






select email_id,
    min(signup_date) AS First_Signup_Date,
    max(signup_date) AS Latest_Signup_Date,
    datediff(day,
             min(signup_date),
             max(signup_date)) AS Difference_In_Days
from email_signup
where email_id LIKE '%@gmail.com'
group by  email_id;