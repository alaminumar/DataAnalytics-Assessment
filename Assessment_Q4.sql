WITH customer_transactions AS (
    SELECT
        s.owner_id AS customer_id,
        u.name,
        MIN(s.transaction_date) AS first_transaction_date,
        MAX(s.transaction_date) AS last_transaction_date,
        COUNT(*) AS total_transactions
    FROM savings_savingsaccount s
    JOIN users_customuser u ON s.owner_id = u.id
    GROUP BY s.owner_id, u.name
),

customer_tenure AS (
    SELECT
        customer_id,
        name,
        TIMESTAMPDIFF(MONTH, first_transaction_date, last_transaction_date) + 1 AS tenure_months, -- add 1 to avoid zero tenure
        total_transactions,
        total_transactions / (TIMESTAMPDIFF(MONTH, first_transaction_date, last_transaction_date) + 1) AS monthly_tx_rate
    FROM customer_transactions
)

SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(monthly_tx_rate * 12, 2) AS estimated_clv -- Estimate CLV as 12 * monthly transaction rate
FROM customer_tenure;
