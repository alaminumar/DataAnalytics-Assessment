# DataAnalytics-Assessment
Data Analytics Assessment for CowryWise May 2025

## README: SQL Analytical Queries – Approach and Challenges

This document outlines the approach and considerations for four SQL-based analytical questions using a customer savings dataset in MySQL. Each question required deriving insights such as user activity classification, customer lifetime value estimation, and inactivity analysis.

---

### Question 1: Determine Average Transaction Value by Customer Tier

**Approach:**  
Joined `savings_savingsaccount` with `users_customuser` and `users_tier` on the appropriate foreign keys. Grouped by tier name to calculate the average transaction value per tier using the `amount` field. 

**Challenges:**  
Ensured referential integrity with multiple joins. Some rows had missing tier information; used INNER JOINs to filter them out. Aggregate precision and column aliasing needed attention for readability.

---

### Question 2: Categorize Customers by Transaction Frequency

**Approach:**  
Used Common Table Expressions (CTEs) to first count the number of monthly transactions per customer, then compute each customer’s average monthly transactions. Applied a CASE statement to categorize users as 'High Frequency', 'Medium Frequency', 'Low Frequency', or 'No Activity'. Final output includes frequency category, customer count, and average transactions per month.

**Challenges:**  
Had to use `DATE_FORMAT()` for correct year-month grouping in MySQL. Avoided nested aggregation by computing average monthly transactions in a separate CTE. Alias ordering and CASE logic placement required precise formatting to avoid syntax issues.

---

### Question 3: Identify Inactive Users Based on Last Transaction Date

**Approach:**  
Extracted the latest `transaction_date` for each user-plan pair to determine the last activity. Calculated inactivity in days using `DATEDIFF()` from the current date. Classified inactivity without needing join complexity.

**Challenges:**  
Ensured grouping by both `owner_id` and `plan_id` to maintain distinct savings plans per user. Required filtering users with at least one transaction. Managing date calculations across a potentially large dataset needed indexing for efficiency.

---

### Question 4: Estimate Customer Lifetime Value (CLV)

**Approach:**  
Computed tenure in months using `TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date))`. Calculated total transactions per customer and estimated CLV as product of average transaction value and tenure. Joined with `users_customuser` to include user names.

**Challenges:**  
Avoided NULL issues by filtering for customers with transaction history. Used `IFNULL` where necessary. Ensured transaction aggregation occurred before joining with user metadata. MySQL’s handling of time intervals and rounding needed care for accurate CLV estimation.
