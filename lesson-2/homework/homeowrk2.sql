create Database lesson2 ;
use lesson2 ;

--Task5
drop table if exists worker;
create table worker
(
  id int,
  name varchar(50)
);

BULK INSERT worker
FROM 'C:\Users\user\PycharmProjects\SQL\lesson-2\homework\sample.csv'
WITH (
  firstrow = 2,
  fieldterminator = ',',
  rowterminator = '\n'
);

select * from worker;

--Task3 Image
CREATE TABLE photos (
    id INT PRIMARY KEY,
    photo VARBINARY(MAX)
);

INSERT INTO photos
SELECT 1, BulkColumn FROM OPENROWSET(
    BULK 'D:\image.jfif', SINGLE_BLOB
) AS img;

select * from photos

--Task1
CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);
INSERT INTO test_identity (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eve');

-- Delete: rows 3 and 4 will be deleted and identity will not be reset which is next row id will be 6
DELETE FROM test_identity WHERE id IN (3, 4);
INSERT INTO test_identity (name) VALUES ('Frank');
-- Truncate all rows will be removed and identity reset
TRUNCATE TABLE test_identity;
INSERT INTO test_identity (name) VALUES ('George');
--Drop : table will be removed completely
DROP TABLE test_identity;
SELECT * FROM test_identity; -- This will cause an error

select * from test_identity ;

--Task2
Create table items (
   id int primary key,
   quantity SmallInt ,
   name varchar(50) ,
   sold_date date );

Insert into items Values ( 1, 100, 'book', '2024-11-11') ;
select * from items ;

--Task4
CREATE TABLE student (
    id INT PRIMARY KEY,
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS (classes * tuition_per_class) -- Computed column
);
INSERT INTO student (id, classes, tuition_per_class)
VALUES (1, 5, 200), (2, 3, 150), (3, 7, 180);

SELECT * FROM student;
