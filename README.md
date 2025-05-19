# DataAnalytics-Assessment
Data Analytics Assessment for CowryWise May 2025

# Approach and Challenges

## Query 1: Identify Customers Owning Both Savings and Investment Plans

**Approach:**  
- Join `users_customuser` with `plans_plan` and `savings_savingsaccount` to get customer plans and transactions.  
- Use conditional aggregation (`COUNT` with `CASE`) to count how many savings and investment plans each customer has.  
- Sum confirmed deposits across all related savings accounts.  
- Filter to customers having at least one savings plan and one investment plan.  
- Sort by total deposits to prioritize active customers.  

**Challenges:**  
- Avoid double counting deposits due to multiple transactions per plan.  
- Ensure plans are active by filtering out archived/deleted records.  
- Handling customers with multiple plan types cleanly in aggregation.

---

## Query 2: Categorize Customers by Monthly Transaction Frequency

**Approach:**  
- Aggregate transactions per customer per month from `savings_savingsaccount`.  
- Compute average monthly transactions per customer.  
- Categorize customers into frequency buckets (High, Medium, Low).  
- Aggregate counts and average frequencies for summary statistics.  

**Challenges:**  
- Defining meaningful transaction frequency thresholds without domain data.  
- Properly grouping transactions by calendar month.  
- Handling customers with irregular or zero activity without biasing averages.

---

## Query 3: Detect Inactive Plans Based on Transaction History

**Approach:**  
- Left join plans to their transactions to include plans without any transactions.  
- Calculate days since last transaction or mark as never transacted if no record.  
- Use `HAVING` to filter for plans inactive over one year or with no activity.  
- Include plan type for context on inactivity patterns.  

**Challenges:**  
- Correctly handling NULL last transaction dates for never-used plans.  
- Ensuring inactive plans are identified despite missing transaction data.  
- Balancing query performance with large datasets using appropriate indexing.

---

## Query 4: Estimate Customer Lifetime Value (CLV) Proxy

**Approach:**  
- Calculate customer tenure in months from account creation date.  
- Aggregate transaction counts and average confirmed amount per customer.  
- Annualize transaction frequency to estimate yearly engagement.  
- Multiply frequency by average transaction value (scaled) to approximate CLV.  
- Order customers by estimated CLV for prioritization.  

**Challenges:**  
- Simplifying CLV without access to revenue or churn data.  
- Preventing division by zero for tenure when calculating averages.  
- Scaling transaction values appropriately for meaningful comparison.

