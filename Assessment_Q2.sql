WITH monthly_transactions AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS year_month, -- Extract year and month
        COUNT(*) AS transactions_per_month -- Count transactions per month
    FROM savings_savingsaccount
    GROUP BY owner_id, year_month
), avg_transactions AS (
    SELECT 
        owner_id,
        AVG(transactions_per_month) AS avg_monthly_transactions -- Average transactions per month per user
    FROM monthly_transactions
    GROUP BY owner_id
)
SELECT
    CASE
        WHEN avg_monthly_transactions >= 10 THEN 'High Frequency' -- 10 or more transactions
        WHEN avg_monthly_transactions BETWEEN 5 AND 9 THEN 'Medium Frequency' -- 5-9 transactions
        WHEN avg_monthly_transactions > 0 AND avg_monthly_transactions < 5 THEN 'Low Frequency' -- 1-4 transactions
        ELSE 'No Activity' -- Zero transactions
    END AS transaction_frequency_category,
    COUNT(owner_id) AS customer_count, -- Number of users in each category
    AVG(avg_monthly_transactions) AS average_transactions -- Average transactions in each category
FROM avg_transactions
GROUP BY transaction_frequency_category;
