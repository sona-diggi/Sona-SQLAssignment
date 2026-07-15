create table  sales_data
(
    product_id INT,
    sale_date DATE,
    quantity_sold INT
);

insert into  sales_data
values 
(1, '2022-01-01', 20),
(2, '2022-01-01', 15),
(1, '2022-01-02', 10),
(2, '2022-01-02', 25),
(1, '2022-01-03', 30),
(2, '2022-01-03', 18),
(1, '2022-01-04', 12),
(2, '2022-01-04', 22);


select 
    product_id,
    sale_date,
    quantity_sold,
    RANK() OVER
    (
        partition by product_id
        order by  sale_date DESC
    ) AS rnk
from sales_data;


select 
    product_id,sale_date,quantity_sold,
    LAG(quantity_sold) over
    (
        partition by product_id
        order by sale_date
    ) as Previous_Quantity
from sales_data;





select
    product_id,sale_date,quantity_sold,
    first_value(quantity_sold) over
    (
        partition by product_id
        order by sale_date
    ) as first_value,
    last_value(quantity_sold) over
    (
        partition by product_id
        order by sale_date
        rows between unbounded preceding and unbounded following
    ) as last_value
from sales_data;