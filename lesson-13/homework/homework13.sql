go
Create function GetMonths(@input_date datetime )
returns @Months table  (
    Monday int ,
	Tuesday int,
	Wednesday int,
	Thursday int ,
	Friday int ,
	Saturday int,
	Sunday int )
Begin
with cte as (
    select
        DATEFROMPARTS(YEAR(@input_date), MONTH(@input_date), 1) as date,
        DATENAME(weekday, DATEFROMPARTS(YEAR(@input_date), MONTH(@input_date), 1)) as weekday,
        DATEPART(weekday, DATEFROMPARTS(YEAR(@input_date), MONTH(@input_date), 1)) as weekdaynum,
        1 as weeknumber
    union ALL
    select
        DATEADD(day, 1, date),
        DATENAME(weekday, DATEADD(day, 1, date)),
        DATEPART(weekday, DATEADD(day, 1, date)),
        case
            when DATEPART(weekday, DATEADD(day, 1, date)) > weekdaynum then weeknumber
            else weeknumber + 1
        end
    from cte
    where date < EOMONTH(date)
)
insert into @Months
select
    MAX(case when weekday='Sunday' then DAY(date) end) as Sunday,
    MAX(case when weekday='Monday' then DAY(date) end) as Monday,
    MAX(case when weekday='Tuesday' then DAY(date) end) as Tuesday,
    MAX(case when weekday='Wednesday' then DAY(date) end) as Wednesday,
    MAX(case when weekday='Thursday' then DAY(date) end) as Thursday,
    MAX(case when weekday='Friday' then DAY(date) end) as Friday,
    MAX(case when weekday='Saturday' then DAY(date) end) as Saturday
from cte
group by weeknumber
return
end
go

select * from GetMOnths('3-20-2025')