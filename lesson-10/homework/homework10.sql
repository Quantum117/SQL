use lesson10;

drop table if exists Shipments ;
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);
-----------------

WITH full_table AS (
    SELECT value AS N, Num 
    FROM generate_series(1,7)  -- Generates series on a value column
    CROSS JOIN (SELECT 0 AS Num) AS t  -- Adds column Num filled with zeros in front of column N
    UNION ALL 
    -- Adding rest of the Shipment table. Because column Num in the rest of the table is nonzero
    SELECT N+7 AS N, Num
    FROM Shipments
),
--- Gets number of rows from full_table 
full_count AS (
    SELECT COUNT(N) AS total_rows FROM full_table
)
SELECT AVG(Num) AS median 
FROM full_table, full_count
--- this logic handles both even and odd number of shipment days 
WHERE N IN ((total_rows + 1) / 2, (total_rows / 2) + 1);
