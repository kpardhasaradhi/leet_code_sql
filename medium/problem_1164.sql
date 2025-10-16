select product_id, new_price as price from Products where (product_id,change_date) in (select product_id , max(change_date) from Products where change_date <='2019-08-16' group by product_id) 
union 
select distinct product_id, 10 as price from Products where product_id not in(select distinct product_id from Products where change_date <='2019-08-16' )


-- Explanation:
-- Step 1: Select the latest price for each product on or before '2019-08-16' 
--         by finding the max(change_date) per product_id.
-- Step 2: Use UNION to include products that have no price change before that date 
--         and assign them the default price of 10.
-- This query returns the price of each product as of '2019-08-16'.
