WITH monthly_transactions AS (
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS year_month, -- Extract year and month
        COUNT(*) AS transactions_per_month -- Count transactions for that month
    FROM savings_savingsaccount
    GROUP BY owner_id, year_month
),

avg_transactions AS (
    SELECT
        owner_id,
        AVG(transactions_per_month) AS avg_monthly_transactions -- Average monthly transactions per user
    FROM monthly_transactions
    GROUP BY owner_id
),

categorized_users AS (
    SELECT
        owner_id,
        CASE
            WHEN avg_monthly_transactions >= 10 THEN 'High Frequency'
            WHEN avg_monthly_transactions BETWEEN 5 AND 9 THEN 'Medium Frequency'
            WHEN avg_monthly_transactions > 0 AND avg_monthly_transactions < 5 THEN 'Low Frequency'
            ELSE 'No Activity'
        END AS frequency_category,
        avg_monthly_transactions
    FROM avg_transactions
)

SELECT
    frequency_category,
    COUNT(owner_id) AS customer_count, -- Number of users in each category
    ROUND(AVG(avg_monthly_transactions), 2) AS avg_transactions_per_month -- Avg monthly transactions in each category
FROM categorized_users
GROUP BY frequency_category;

