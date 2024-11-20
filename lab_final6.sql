create database p1;
use p1;
create table salesman(
salesman_id int not null,
salesman_name varchar(20),
city varchar(20),
commission double,
primary key(salesman_id)
);
insert into salesman(salesman_id,salesman_name,city,commission)
values(6001,'John Legend','New York',0.12),(6002,'Bruce Wayne','New York',0.14),
(6003,'Clark Kent','San Francisco',0.14),(6004,'Barry Allen','Los Angeles',0.15);

create table customer(
customer_id int not null,
cust_name varchar(20),
city varchar(20),
grade int,
salesman_id int,
primary key(customer_id),
foreign key(salesman_id) references salesman(salesman_id)
);
insert into customer(customer_id,cust_name,city,grade,salesman_id)
values(4001,'Alice Cooper','Los Angeles',150,6001),(4002,'Bob Marley','New York',200,6002),
(4003,'Charlie Chap','San Francisco',100,6003),(4004,'Diana Prince','New York',300,6001),
(4005,'Evan Stone','Los Angeles',250,6004);

create table orders(
ord_no int not null,
purch_amt double,
ord_date date,
customer_id int,
salesman_id int,
primary key(ord_no),
foreign key(customer_id) references customer(customer_id),
foreign key(salesman_id) references salesman(salesman_id)
);
insert into orders(ord_no,purch_amt,ord_date,customer_id,salesman_id)
values(8001,300.75,'2023-05-20',4001,6004),(8002,150.50,'2023-04-15',4002,6002),
(8003,250.00,'2023-06-10',4004,6001),(8004,500.00,'2023-03-25',4004,6004),
(8005,175.00,'2023-05-10',4003,6003);

select c.cust_name as CustomerName,c.city as CustomerCity,s.salesman_Name as salesmanName,s.city as SalesmanCity
from customer c
join salesman s on c.salesman_id=s.salesman_id
where c.city=s.city;

select c.cust_name as CustomerName,c.city as CustomerCity,c.grade as GRADE,s.salesman_name as SalesmanName,s.commission
from customer c
join salesman s on c.salesman_id=s.salesman_id
where commission>0.12;

select c.cust_name as CustomerName,o.ord_no as OrderNo, o.ord_date as OrderDate,o.purch_amt as AMOUNT
from customer c
join orders o on c.customer_id=o.customer_id
where o.purch_amt>200 and o.purch_amt<400;

select c.cust_name as CustomerName, s.salesman_Name as SalesmanName,o.purch_amt as AMOUNT, o.ord_date as OrderDate
from customer c 
join salesman s on c.salesman_id = s.salesman_id
join orders o on s.salesman_id=o.salesman_id
where ord_date>='2023-05-01' and ord_date<='2023-05-31';

select c.cust_name as CustomerName,s.salesman_name as SalesmanName
from customer c
join salesman s on c.salesman_id=s.salesman_id
where c.customer_id not in( select customer_id from orders);

select avg(o.purch_amt) as avg_purch_amt
from customer c
join orders o
on c.customer_id=o.customer_id
where c.city='Los Angeles';

SELECT c.cust_name, o.purch_amt
FROM orders o
JOIN customer c 
ON o.customer_id = c.customer_id
JOIN (SELECT MAX(purch_amt) AS max_purch_amt FROM orders) max_order
ON o.purch_amt = max_order.max_purch_amt;


SELECT 
    c.cust_name, 
    o.purch_amt
FROM 
    orders o
JOIN 
    customer c
ON 
    o.customer_id = c.customer_id
WHERE 
    o.purch_amt = (
        SELECT MAX(purch_amt) FROM orders
    );
    
select s.salesman_name, s.city
from salesman s
join customer c
on s.salesman_id=c.salesman_id
where c.salesman_id not in(s.salesman_id);

select o.ord_no,c.cust_name,o.purch_amt
from orders o
join customer c on
o.customer_id=c.customer_id
where c.grade>200;

SELECT 
    s.salesman_name, 
    s.city, 
    SUM(o.purch_amt) AS total_sales
FROM 
    salesman s
LEFT JOIN 
    orders o 
ON 
    s.salesman_id = o.salesman_id
GROUP BY 
    s.salesman_id, s.salesman_name, s.city;
