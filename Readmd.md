Entities

- customer_details (customer_id, first_namename, last_name, salutation, contact_number, e_mail_address, gender)
- customer_address (customer_id, addrid, first_name, last_name, address_1, address_2, city, province, postal_code, contact_number)
- debit_card (customer_id, debit_card_number, name_on_debit_card, bank_id, bank_transit, expiry_datproduct_quantitye)
- credit_card (customer_id, credit_card_number, name_on_debit_card, expiry_date)
- vendors (vendor_id,vendor_name, vendor_address1, vendor_address2, vendor_city, vendor_province, vendor_postal_code, vendor_contact_number, vendor_email_address)
- stores (store_id, Store_rating, store_name, store_address1, store_address2, store_city, store_province, store_postal_code, store_contact_number, store_email_address
- product (product_id, category, product_name, brand_name, price_of_the_product, product_quantity)
- store_stock (store_id, product_id, quantity)
- order_details (order_id, customer_id, order_date, expected_delivery_date, delivery_address_id, total_value, order_payment_id, order_quantity)
- Create table order_item (order_item_id, order_id, customer_id, price_of_item, quantity_of_items, delivery_status)
- order_payment_details (payment_id, customer_id, mode_of_payment, payment_status)

Relationships

- customer_id is linked to customer_address, order_payment_details, order_details, debit_card, credit_card, order_item
- order_id is linked to order_details
- store_id is linked to stores
- product_id is linked to store_stock

Create Database
-Table.sql: Create tables for entities and relationships above.
-query.sql: instruction that is been performed on the table to fetch details or modify the table 