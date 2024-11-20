create database supersh;
use supersh;
-- Create the `salesman` table
CREATE TABLE salesman (
    salesman_id INT NOT NULL PRIMARY KEY,
    salesman_name VARCHAR(20),
    city VARCHAR(20),
    commission DOUBLE
);

-- Insert data into the `salesman` table
INSERT INTO salesman (salesman_id, salesman_name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14);

-- Create the `customer` table
CREATE TABLE customer (
    customer_id INT NOT NULL PRIMARY KEY,
    cust_name VARCHAR(20),
    city VARCHAR(20),
    grade INT,
    salesman_id INT,
    FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into the `customer` table
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3007, 'Brade Davis', 'New York', 200, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3008, 'Julian Green', 'London', 300, 5005);

-- Create the `orders` table
CREATE TABLE orders (
    ord_no INT NOT NULL PRIMARY KEY,
    purch_amt DOUBLE,
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into the `orders` table
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3007, 5001),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3008, 5005);
    
    select salesman.salesman_name,customer.cust_name,customer.city
    from customer
    inner join salesman
    on customer.salesman_id=salesman.salesman_id;

 select customer.cust_name as customerName,customer.city as customerCity,salesman.salesman_name as SalesmanName, salesman.commission
 from customer
 inner join salesman 
 on customer.salesman_id=salesman.salesman_id
 where salesman.commission>0.12;
 
 select customer.customer_id,customer.cust_name,customer.city,customer.grade,salesman.salesman_name,salesman.city
 from customer
 inner join salesman
 on customer.salesman_id=salesman.salesman_id
 where customer.grade<300
 order by customer.customer_id;
 
 select o.ord_no,o.purch_amt,c.cust_name,c.city
 from orders o
 inner join customer c
 on o.customer_id=c.customer_id
 where o.purch_amt between 200 and 300;
 
 SELECT 
    c.cust_name, 
    s.salesman_name, 
    o.ord_date
FROM 
    orders o
JOIN 
    customer c
ON 
    o.customer_id = c.customer_id
JOIN 
    salesman s
ON 
    o.salesman_id = s.salesman_id
WHERE 
    MONTH(o.ord_date) IN (10, 11);
    
   SELECT 
    c.cust_name, 
    s.salesman_name
FROM 
    customer c
JOIN 
    salesman s
ON 
    c.salesman_id = s.salesman_id
WHERE 
    c.customer_id NOT IN (
        SELECT customer_id FROM orders
    );

