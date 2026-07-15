CREATE DATABASE ecommerce;
USE ecommerce;

--CREATING 4 TABLES--
CREATE TABLE GoldMembers
(
    UserID VARCHAR(20),
    Signup_Date DATE
);

CREATE TABLE Users
(
    UserID VARCHAR(20),
    Signup_Date DATE
);

CREATE TABLE Sales
(
    UserID VARCHAR(20),
    Created_Date DATE,
    Product_ID INT
);

CREATE TABLE Products
(
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price INT);

select * from Products;
select * from Sales;
select * from Users;
select * from GoldMembers;




INSERT INTO GoldMembers
VALUES ('John','2017-09-22'),('Mary','2017-04-21');

INSERT INTO Users
VALUES ('John','2014-09-02'), ('Michel','2015-01-15'), ('Mary','2014-04-11');

INSERT INTO Sales
VALUES
('John','2017-04-19',2),
('Mary','2019-12-18',1),
('Michel','2020-07-20',3),
('John','2019-10-23',2),
('John','2018-03-19',3),
('Mary','2016-12-20',2),
('John','2016-11-09',1),
('John','2016-05-20',3),
('Michel','2017-09-24',1),
('John','2017-03-11',2),
('John','2016-03-11',1),
('Mary','2016-11-10',1),
('Mary','2017-12-07',2);

INSERT INTO Products
VALUES (1,'Mobile',980), (2,'Ipad',870), (3,'Laptop',330);

select * from sys.tables;


select 'GoldMembers' as NameOfTheTable,count(*) as 'RowCount' from GoldMembers 
union all
select 'Users',count(*) from Users
union all
select 'Products',count(*) from Products
union all
select 'Sales',count(*) from Sales;



--total amount each customer spent on ecommerce company 
select s.UserID, sum(p.price) as total_price 
       from Sales s left join Products p 
       on s.Product_ID=p.Product_ID
       group by s.UserID;



-- distinct dates of each customer visited the website

select  distinct created_date as VisitedDate,
        userid as users from Sales;

--Find the first product purchased by each customer using 3 tables(users, sales, product) 

with firstPurchase as(
select u.userId as users,p.product_Name as productName, s.created_date,
    ROW_NUMBER() over(partition by u.userId order by s.created_date)as purchase
    from Products p 
        join
    sales s on p.Product_ID=s.product_id 
        join 
    users u on u.UserID=s.UserID
)

select * from firstPurchase where purchase =1;


--most purchased item of each customer and how many times the customer has purchased it: 
--output should have 2 columns count of the items as item_count and customer name 

with mostPurch as
(
select userId as CustomerName ,product_id, count(*) as mostPurchased ,
    row_number()over(partition by userId order by count(*) desc) as rn
    from sales 
    group by userid,product_id)
SELECT
    CustomerName,mostPurchased from mostPurch
WHERE rn = 1;


--Find out the customer who is not the gold_member_user 
select u.userId as NotMember 
    from users u Left join GoldMembers g on u.UserID=g.UserID
    where g.UserID is null




--Amount spent by each customer when he was the gold_member order by user 
SELECT g.userId as customer, sum(p.price) as amount
    from GoldMembers g join sales s on
        g.userId=s.userId
    join products p on s.product_id=p.product_id
    where s.Created_Date>=g.Signup_Date
    group by g.UserID
    order by g.UserID;


--Find the Customers names whose name starts with M 

select Userid from users where userid like 'm%';



--Find the Distinct customer Id of each customer 


select distinct Userid from users ;


--Change the Column name from product table as price_value from price 
select * from products;
exec sp_rename 'products.price','price_value','column';
select * from products;
--Change the Column value product_name – Ipad to Iphone from product table 
select * from Products;
update Products set Product_Name='Iphone' where Product_Name='Ipad';
select * from Products;

--Change the table name of gold_member_users to gold_membership_users 
SELECT name
FROM sys.tables;
exec sp_rename 'GoldMembers','gold_membership_users';



--Create a new column  as Status in the table crate above gold_membership_users  
--the Status values should be 2 Yes and No
--if the user is gold member, then status should be Yes else No. 

Alter table users add statuss varchar(10);
update users set statuss=
    case 
        when userid in (select userid from gold_membership_users)
        then 'yes' else 'no'
 end;

 select * from users;


--Delete the users_ids 1,2 from users table and roll the back changes 
--once both the rows are deleted one by one mention the result when performed roll back 

Begin transaction 

delete from users where UserID='John';
delete from users where UserID='Michel';

select * from users;

rollback;
select * from users;

--Insert one more record as same (3,'Laptop',330) as product table 

select* from Products;
insert into Products values(3,'Laptop',330);
select * from Products;

--query to find the duplicates in product table 

select product_name ,
    count(*) as dup_count from Products
    group by Product_Name having count(*)>1;