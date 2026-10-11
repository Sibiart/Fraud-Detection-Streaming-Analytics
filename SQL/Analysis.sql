  select class,count(*) from creditcard group by class;

select sum(Amount) as tot_transacation_amount, 
avg(Amount) as avg_transacation_amount,
min(amount) as minimum_transcation_amt,
max(amount) as maximum_transcation_amt 
from creditcard; 
select count(case when class = 1 then 1 end)*100.00/count(*) as Fraud_percentage from creditcard;

SELECT
    Class,
    COUNT(*) AS transaction_count,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM creditcard)
        AS percentage
FROM creditcard
GROUP BY Class;

select class,sum(Amount) as tot_transacation_amount, 
avg(Amount) as avg_transacation_amount,
min(amount) as minimum_transcation_amt,
max(amount) as maximum_transcation_amt 
from creditcard group by class; 

select
floor(`Time`/3600) AS hour_bucket,
count(*) as total_transcation,
sum(amount) as total_amount,
sum(case when class = 1 then 1 end) as fraud_transcation
from creditcard
group by floor(`Time`/3600)
order by hour_bucket;

-- select
-- floor(`Time`/3600) AS hour_bucket,
-- count(*) as total_transcation,
-- sum(case when class = 1 then 1 end) as fraud_transcation
-- from creditcard
-- group by floor(`Time`/3600)
-- order by fraud_transcation desc
-- limit 5;

-- with hourly_data as (
--     select
--         floor(`time` / 3600) as hour_bucket,
--         count(*) as total_transactions,
--         sum(case when class = 1 then 1 else 0 end) as fraud_transactions
--     from creditcard
--     group by floor(`time` / 3600)
-- )
-- select
--     hour_bucket,
--     total_transactions,
--     fraud_transactions,
--     lead(fraud_transactions) over (order by hour_bucket)
--         as next_hour_fraud_transactions
-- from hourly_data
-- order by hour_bucket;

-- SELECT COUNT(*) AS total_rows
-- FROM creditcard;