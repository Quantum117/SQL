-- Task1
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

Select *
from TestMultipleZero
Where not (A =0 and B=0 and C=0 and D=0);

--- Task2: Write a query which will find maximum value from multiple columns of the table.
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO

INSERT INTO TestMax
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

SELECT Year1, GREATEST(Max1, Max2, Max3) AS max_value
FROM TestMax;


-- Task3 Write a query which will find the Date of Birth of employees whose birthdays lies between May 7 and May 15.
CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1)
    ,EmpName VARCHAR(50)
    ,BirthDate DATETIME
);

INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

Select * from EmpBirth
WHERE BirthDate BETWEEN Concat(year(BirthDate),'-05-07') AND Concat(year(BirthDate),'-05-15');

--Second solution
SELECT * FROM EmpBirth
WHERE BirthDate BETWEEN DATEFROMPARTS(YEAR(BirthDate), 5, 7)
                    AND DATEFROMPARTS(YEAR(BirthDate), 5, 15);

-- Task4
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'),
  ('b'), ('c'), ('d'), ('e'), ('f');

SELECT letter
FROM letters
ORDER BY
    CASE
        WHEN letter = 'b' THEN 0  -- 'b' comes first
        ELSE 1                    -- Other letters come after
    END,
    letter;  -- Orders the rest alphabetically
	------------------------------------------
SELECT letter
FROM letters
ORDER BY
    CASE
        WHEN letter = 'b' THEN 1  -- 'b' goes last
        ELSE 0                    -- Others come first
    END,
    letter;
--------------------------
WITH NumberedLetters AS (
    SELECT letter, ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
)
SELECT letter
FROM NumberedLetters
ORDER BY
    CASE
        WHEN rn < 3 THEN 1   -- First two letters stay in place
        WHEN letter = 'b' THEN 2  -- 'b' is forced to the 3rd position
        ELSE 3               -- Other letters come after
    END,
    letter; -- Ensure remaining letters are sorted naturally



