Create Database lesson1 ;
use lesson1 ;
Create table students(
   id int ,
   name text,
   age text ) ;

-- Add not null constraint
Alter table students Alter Column id int not null ;

-- task 2
drop table if exists product
Create table product(
    product_id int constraint U_c Unique ,
	product_name text ,
	price decimal )

-- Drop constraint
Alter table product
drop constraint U_c ;
-- Add again
Alter table product
add constraint  U_c unique(product_id)
-- combination
Alter table product
add constraint  U_comb unique(product_id, product_name)
--
Alter table product
Alter  column product_name varchar(50) ;

-- Task3
drop table if exists orders
Create table orders(
   order_id int constraint p_k primary key ,
   customer_name varchar(50),
   order_date date
   )
-- drop constraint primary key
Alter table orders
drop constraint p_k ;
-- add again
Alter table orders
add constraint p_k primary key(order_id);

--Task4
drop table if exists category
Create table category (
   category_id int constraint pk_category primary key,
   category_name varchar(50)
   );
drop table if exists item
Create table item(
    item_id int constraint pk_item primary key ,
	item_name varchar(50) ,
	category_id int constraint fk_item foreign key references category(category_id)
	)

-- drop constraint primary key
Alter table item
drop constraint fk_item ;
-- add again
Alter table item
add constraint fk_item2 foreign key(category_id) References category(category_id);

--Task5
drop table if exists accounts
Create table accounts(
   account_id int primary key,
   balance decimal constraint chk_account Check (balance>0),
   account_type varchar(50) constraint chk Check (account_type = 'Saving' or account_type ='Checking')
   );

-- drop constraint primary key
Alter table accounts
drop constraint chk_account
Alter table accounts
drop constraint chk ;

-- add again
Alter table accounts
ADD CONSTRAINT chk_account CHECK (balance > 0);  -- Ensures balance is positive

ALTER TABLE accounts
ADD CONSTRAINT chk_account_type CHECK (account_type IN ('Saving', 'Checking'));  -- Ensures valid account types

--Task6
drop table if exists customer ;
Create table customer(
    customer_id int constraint pk_customer primary key ,
	name varchar(50) ,
	city varchar(50) Constraint def Default 'Unknown'
	)
Alter table customer
drop constraint def ;
Alter table customer
add constraint def Default 'Unknown'  for city  ;

--Task7
drop table if exists invoice
Create table invoice (
    invoice_id int identity ,
	amount decimal
	);
Insert into invoice Values (100);
Insert into invoice Values (200);
Select * from invoice
Insert into invoice (invoice_id, amount)  Values(100,222) ;
--Task8
Create table books (
    book_id int primary key identity ,
	title varchar(50) not null ,
	price int check(price > 0) ,
	genre varchar(50)   Default 'Unknown'
	);
Insert into books Values('48 laws of power',100, 'psychology') ;
Select * from books

--Task9
CREATE TABLE Book (
    book_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year INT
);

CREATE TABLE Member (
    member_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(50)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE NULL,
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);
-- Insert sample books
INSERT INTO Book (title, author, published_year)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
('1984', 'George Orwell', 1949),
('To Kill a Mockingbird', 'Harper Lee', 1960);

-- Insert sample members
INSERT INTO Member (member_id, name, email, phone_number)
VALUES
(1, 'Alice Johnson', 'alice@example.com', '123-456-7890'),
(2, 'Bob Smith', 'bob@example.com', '987-654-3210');

-- Insert sample loan records
INSERT INTO Loan (loan_id, book_id, member_id, loan_date, return_date)
VALUES
(1, 1, 1, '2024-02-01', NULL),
(2, 2, 1, '2024-02-05', '2024-02-10'),
(3, 3, 2, '2024-02-08', NULL);


