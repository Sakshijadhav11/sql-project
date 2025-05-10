create database product_sales;

use product_sales;

create table product_data(
product_id int,
product_name varchar(50),
category varchar(50),
base_price decimal(10,2) ,
demand int,
stock int
);

insert into product_data values
(101,"bluetooth","electronics",1000,1200,150),
(102,"headphones","electronics",1500,800,50),
(103,"tshirt","clothing",500,300,200),
(104,"shoes","footwear",2000,100,20),
(105,"smartwatch","electronics",2500,1500,10);

select * from product_data;

SELECT 
  product_id,
  product_name,
  base_price,
  demand,
  CASE
    WHEN demand > 1000 THEN base_price * 1.10
    WHEN demand BETWEEN 500 AND 1000 THEN base_price
    ELSE base_price * 0.90
  END AS final_price
FROM product_data;

select * from product_data;




       








