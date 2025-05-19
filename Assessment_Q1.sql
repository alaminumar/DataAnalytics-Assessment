SELECT
  u.id AS owner_id,
  u.name,
  COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count, -- Count of savings plans
  COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,     -- Count of investment plans
  COALESCE(SUM(s.confirmed_amount), 0) AS total_deposits                           -- Total confirmed deposits
FROM users_customuser u
JOIN plans_plan p ON p.owner_id = u.id AND p.is_archived = 0 AND p.is_deleted = 0  -- Active plans only
JOIN savings_savingsaccount s ON s.plan_id = p.id AND s.owner_id = u.id
WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1                                -- Filter for savings or investment
GROUP BY u.id, u.name
HAVING savings_count > 0 AND investment_count > 0                               -- Must have both product types
ORDER BY total_deposits DESC;
