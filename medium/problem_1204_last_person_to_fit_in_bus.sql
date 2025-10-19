-- ##  Problem: Last Person to Board the Elevator

-- ### Problem Statement
-- We have a queue of people waiting to board an elevator. Each person has a specific weight, and the elevator can hold a maximum total weight of **1000**.  
-- We need to determine the **last person** who can board before the total weight exceeds the limit.

-- ### Example

-- **Queue Table**

-- | person_id | person_name | weight | turn |
-- |------------|--------------|--------|------|
-- | 1 | Alice | 250 | 1 |
-- | 2 | Bob | 175 | 5 |
-- | 3 | Alex | 350 | 2 |
-- | 4 | John Cena | 400 | 3 |
-- | 5 | Winston | 500 | 4 |
-- | 6 | Marie | 200 | 6 |

-- **Expected Output**

-- | person_name |
-- |--------------|
-- | John Cena |

-- ### Explanation
-- The elevator boards people in the order of their `turn`.  
-- We keep adding each person’s weight until the total exceeds 1000. The last person whose cumulative weight is still within the limit is the answer.

-- | Turn | Person | Weight | Total Weight | Status |
-- |------|---------|---------|---------------|---------|
-- | 1 | Alice | 250 | 250 | ✅ |
-- | 2 | Alex | 350 | 600 | ✅ |
-- | 3 | John Cena | 400 | 1000 | ✅ (last person) |
-- | 4 | Marie | 200 | 1200 | ❌ (exceeds limit) |

-- Hence, **John Cena** is the last person who can board.

-- ---

-- ### 💡 Step-by-Step Solution

-- **Step 1:**  
-- Use a window function to calculate the cumulative weight as people board.

-- **Step 2:**  
-- Filter out anyone whose total weight exceeds 1000.

-- **Step 3:**  
-- Select the last person whose cumulative weight is still within the limit.

-- ---

with weights_table as (
select turn,person_name,sum(weight) over (order by turn) as rolling_weight from Queue)
select person_name from weights_table where rolling_weight <=1000
order by rolling_weight desc limit 1 ;
