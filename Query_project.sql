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

--Total Revenue for the current month

SELECT SUM(order_item.quantity_of_items * order_item.price_of_item) AS total_revenue
FROM order_details
JOIN order_item ON order_details.order_id = order_item.order_id
WHERE EXTRACT(MONTH FROM order_details.order_date) = EXTRACT(MONTH FROM CURRENT_DATE);

--Get a list of products with zero stock

SELECT * FROM product
WHERE product_quantity = 0;

--Update stock quantity after shipping an order

UPDATE store_stock
SET quantity = quantity - (
    SELECT quantity_of_items
    FROM order_item
    WHERE order_id = 1
)
WHERE product_id IN (
    SELECT product_id
    FROM order_item
    WHERE order_id = 1
);

--Search for products containing the term "laptop"

SELECT * FROM product
WHERE LOWER(product_name) LIKE '%laptop%';

--Identify customers who have placed more than two orders

SELECT customer_details.*, COUNT(order_details.order_id) AS order_count
FROM customer_details
LEFT JOIN order_details ON customer_details.customer_id = order_details.customer_id
GROUP BY customer_details.customer_id
HAVING COUNT(order_details.order_id) > 2;

--List stores with an average rating above 4.5

SELECT stores.*, AVG(stores.store_rating) AS average_rating
FROM stores
GROUP BY stores.store_id
HAVING AVG(stores.store_rating) > 4.5;

--top-spending customers

SELECT customer_details.customer_id, customer_details.first_name, customer_details.last_name, SUM(order_details.total_value) AS total_spent
FROM customer_details
JOIN order_details ON customer_details.customer_id = order_details.customer_id
GROUP BY customer_details.customer_id
ORDER BY total_spent DESC
LIMIT 5;

--Get a list of unique email addresses

SELECT DISTINCT e_mail_address FROM customer_details;

--Identify customers with similar email domains

SELECT SUBSTRING(e_mail_address FROM POSITION('@' IN e_mail_address) + 1) AS email_domain,
       COUNT(*) AS customer_count
FROM customer_details
GROUP BY email_domain
HAVING COUNT(*) > 1;

--Delete customers who do not have an email address

DELETE FROM customer_details
WHERE e_mail_address IS NULL OR e_mail_address = '';

--Find the customers with the highest and lowest total spending

SELECT customer_id, first_name, last_name, total_value
FROM (
    SELECT customer_details.customer_id, first_name, last_name, COALESCE(SUM(order_details.total_value), 0) AS total_spent
    FROM customer_details
    LEFT JOIN order_details ON customer_details.customer_id = order_details.customer_id
    GROUP BY customer_details.customer_id, first_name, last_name
    ORDER BY total_value DESC
) AS customer_spending
LIMIT 1;
Union All
SELECT customer_id, first_name, last_name, total_value
FROM (
    SELECT customer_details.customer_id, first_name, last_name, COALESCE(SUM(order_details.total_value), 0) AS total_spent
    FROM customer_details
    LEFT JOIN order_details ON customer_details.customer_id = order_details.customer_id
    GROUP BY customer_details.customer_id, first_name, last_name
    ORDER BY total_value ASC
) AS customer_spending
LIMIT 1;

--Find customers who haven't placed any orders in the last 6 months

SELECT customer_details.*
FROM customer_details
LEFT JOIN order_details ON customer_details.customer_id = order_details.customer_id
WHERE order_details.order_date IS NULL OR order_details.order_date < CURRENT_DATE - INTERVAL '6 months';

--Find customers with more than one email address:

SELECT customer_id, COUNT(DISTINCT e_mail_address) AS email_count
FROM customer_details
GROUP BY customer_id
HAVING COUNT(DISTINCT e_mail_address) > 1;

--Update the salutation to "Mr." for all male customers

UPDATE customer_details
SET salutation = 'Mr.'
WHERE gender = 'Male';

--Identify customers with similar contact numbers

SELECT contact_number, COUNT(*) AS customer_count
FROM customer_details
GROUP BY contact_number
HAVING COUNT(*) > 1;

--Select customers with specific range of order count

SELECT customer_id, first_name, last_name, order_count
FROM (
    SELECT customer_details.customer_id, first_name, last_name, COALESCE(COUNT(order_details.order_id), 0) AS order_count
    FROM customer_details
    LEFT JOIN order_details ON customer_details.customer_id = order_details.customer_id
    GROUP BY customer_details.customer_id, first_name, last_name
) AS customer_order_counts
WHERE order_count BETWEEN 2 AND 5;


