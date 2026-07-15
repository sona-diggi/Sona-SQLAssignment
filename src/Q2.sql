CREATE TABLE Products_Details
(
    Sell_Date DATE,
    Product VARCHAR(50)
);

INSERT INTO Products_Details
VALUES
('2020-05-30','Headphones'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Book'),
('2020-06-02','Mask'),
('2020-05-30','T-Shirt');



select 
    Sell_Date,
    COUNT(*) AS Item_Count,
    STRING_AGG(Product, ', ') AS Products
from 
(
    select distinct 
        Sell_Date,
        Product
    FROM Products_Details
) AS T
group by Sell_Date
order by  Sell_Date;