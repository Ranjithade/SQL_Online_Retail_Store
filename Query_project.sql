--Insert customer details to customer_details table

 INSERT INTO customer_details (customer_id,first_name , last_name, salutation,contact_number,e_mail_address,gender) VALUES ('001', 'Doe','john','mr','123456789','john.doe@example.com','male');

--using select command to check the inserted values to customer_details table

select * from customer_details

--fetching details of an order

SELECT order_details.order_id, order_date,expected_delivery_date,total_value
FROM order_details
JOIN order_item ON order_details.order_id = order_item.order_id

--Retrieve the products with available stock:

SELECT *
FROM store_stock
WHERE quantity > 0;

--Retrieve the customer's orders with order details

SELECT o.order_id, o.order_date, p.product_name, oi.price_of_item
FROM order_details o
JOIN order_item oi ON o.order_id = oi.order_id
JOIN product p ON p.product_id = p.product_id
WHERE o.customer_id = 1;

--Get top 5 customers by total order amount:

SELECT customer_id, SUM(total_value) AS total_amount
FROM order_details
GROUP BY customer_id
ORDER BY total_amount DESC
LIMIT 5;

--Get the average order total by month:

SELECT DATE_TRUNC('month', order_date) AS month, AVG(total_value) AS average_total
FROM order_details
GROUP BY month
ORDER BY month;

-- Creating a view of all products whose price above average price.

CREATE VIEW Products_Above_Average_Price AS
SELECT product_id, product_name, price_of_the_product
FROM product
WHERE price_of_the_product > (SELECT AVG(price_of_the_product) FROM product);

select * from products_above_average_price;

-- query to fetch the information of laptops

SELECT *
FROM product
WHERE category='laptop';

--Get customer details along with their orders

SELECT customer_details.*, order_details.order_id, order_details.order_date, order_details.total_value
FROM customer_details
JOIN order_details ON customer_details.customer_id = order_details.customer_id;

--Update customer address

UPDATE customer_address
SET address_1 = '456 Oak St, Townsville'
WHERE customer_id = 1;
