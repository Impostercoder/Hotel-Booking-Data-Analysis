-- we use union query to join the hotel data from 2018 to 2020

select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$']

-- now to answer our first question i.e is our hotel revenue growing? we conduct an EDA on sql.
-- we create a temporary table and segment the revenue by year and hotel type with the following syntax to see if the hotel revenue is growing by year.

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])

select
arrival_date_year,
hotel,
round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as revenue  -- we add week nights and weekend nights column and muiltiply with adr to calculate the revenue
from hotels
group by arrival_date_year, hotel 

-- now we use left join the other tables i.e market segment to the hotels temp. table

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union 
select * from dbo.['2020$'])

select* from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal