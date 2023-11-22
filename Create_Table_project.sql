CREATE TABLE customer_details
(
    customer_id INT NOT NULL,
    first_namename VARCHAR(20),
	last_name VARCHAR(20),
	salutation VARCHAR (5),
    contact_number VARCHAR(20),
	e_mail_address VARCHAR(30),
	gender VARCHAR(10),
    PRIMARY KEY(customer_id)
);

CREATE TABLE customer_address
(
	customer_id INT NOT NULL,
    addrid INT NOT NULL,
    first_name VARCHAR(20),
	last_name VARCHAR(20),
    address_1 VARCHAR(50) NOT NULL,
	address_2 VARCHAR(50),
	city VARCHAR(20),
    province VARCHAR(20),
    postal_Code VARCHAR(12),
	contact_number VARCHAR(20),
    PRIMARY KEY(addrid),
    FOREIGN KEY(customer_id) REFERENCES customer_details(customer_id)
);


CREATE TABLE debit_card
(
	customer_id INT NOT NULL,
    debit_card_number int NOT NULL,
	name_on_debit_card VARCHAR(25) NOT NULL,
	bank_id VARCHAR(20) NOT NULL,
	bank_transit VARCHAR(20),
	expiry_date date,
    PRIMARY KEY(debit_card_number),
    FOREIGN KEY(customer_id) REFERENCES customer_details(customer_id)
);


CREATE TABLE credit_card
(
	customer_id INT NOT NULL,
    credit_card_number int NOT NULL,
	name_on_debit_card VARCHAR(25) NOT NULL,
	expiry_date date,
    PRIMARY KEY(credit_card_number),
    FOREIGN KEY(customer_id) REFERENCES customer_details(customer_id)
);


CREATE TABLE vendors
(
	vendor_id INT NOT NULL,
	vendor_name VARCHAR(50) NOT NULL,
	vendor_address1 VARCHAR(50) NOT NULL,
    vendor_address2 VARCHAR(50),
	vendor_city VARCHAR(15),
	vendor_province VARCHAR(15),
  	vendor_postal_code VARCHAR(15),
	vendor_contact_number VARCHAR(15),
	vendor_email_address VARCHAR(50),
	primary key(vendor_id)
);


CREATE TABLE stores
(
	store_id int NOT NULL,
	Store_rating float(5),
	store_name VARCHAR(50) NOT NULL,
	store_address1 VARCHAR(50) NOT NULL,
    store_address2 VARCHAR(50),
	store_city VARCHAR(15),
	store_province VARCHAR(15),
  	store_postal_code VARCHAR(15),
	store_contact_number VARCHAR(15),
	store_email_address VARCHAR(50),
	primary key(store_id)
);

Create table product
(
	product_id int NOT NULL,
	category VARCHAR(20),
	product_name VARCHAR(20),
	brand_name VARCHAR(20),
	price_of_the_product float(10),
	product_quantity int,
	primary key(product_id)
);

Create table store_stock
(
	store_id int NOT NULL,
	product_id int NOT NULL,
	quantity INT,
	FOREIGN KEY(store_id) REFERENCES stores(store_id),
	FOREIGN KEY(product_id) REFERENCES product(product_id)
);

Create table order_details
(
	order_id int not NULL,
	customer_id INT NOT NULL,
	order_date timestamp,
	expected_delivery_date date,
	delivery_address_id INT NOT NULL,
	total_value float(10) not null,
	order_payment_id int not null,
	order_quantity int,
	primary key(order_id),
	foreign key(customer_id) REFERENCES customer_details(customer_id),
	foreign key(delivery_address_id) REFERENCES customer_address(addrid)
);

Create table order_item
(
	order_item_id int not null,
	order_id int not NULL,
	customer_id INT NOT NULL,
	price_of_item float not null,
	quantity_of_items int not null,
	delivery_status varchar(15),
	primary key(order_item_id),
	foreign key(customer_id) REFERENCES customer_details(customer_id),
	foreign key(order_id) references order_details(order_id)
);



Create table order_payment_details
(
	payment_id int not NULL,
	customer_id INT NOT NULL,
	mode_of_payment varchar(15) not null,
	payment_status varchar(10),
	primary key(payment_id),
	foreign key(customer_id) REFERENCES customer_details(customer_id)
);

