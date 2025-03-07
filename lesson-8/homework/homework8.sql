use lesson8;



select * from Groupings;


--- Write an SQL statement that counts the consecutive values in the Status field.
---
SELECT 
    MIN(StepNumber) AS MinStepNumber,
    MAX(StepNumber) AS MaxStepNumber,
    Status,
    COUNT(*) AS ConsecutiveCount
FROM (
    SELECT 
        StepNumber,
        Status,
        StepNumber - ROW_NUMBER() OVER (PARTITION BY Status ORDER BY StepNumber) AS GroupID
    FROM Groupings
) AS sub
GROUP BY Status, GroupID
ORDER BY MinStepNumber;

--------- Task2 
--- Find all the year-based intervals from 1975 up to current when the company did not hire employees.
SELECT * 
FROM (
    SELECT 
        IIf( year - LAG(year) OVER (ORDER BY year) > 1,
             CAST(LAG(year) OVER (ORDER BY year) +1 AS VARCHAR)+ '-' +CAST(Year - 1 AS VARCHAR),
            NULL
        ) AS Years
    FROM (
        SELECT DISTINCT YEAR(Hire_Date) AS year
        FROM EMPLOYEES_N
        WHERE YEAR(Hire_Date) >= 1975
		UNION ALL
				SELECT YEAR(GETDATE()) + 1
    ) AS sub
) AS final_sub
WHERE years IS NOT NULL;