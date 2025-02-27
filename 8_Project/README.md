# Intermediate SQL - Sales Analysis

## Overview
Analysis of customer behavior, retention, and lifetime value for an e-commerce company to improve customer retention and maximize revenue.

## Business Questions
1. **Customer Segmentation:** Who are our most valuable customers?
2. **Cohort Analysis:** How do different customer groups generate revenue?
3. **Retention Analysis:** Which customers haven't purchased recently?

## Analysis Approach

### 1. Customer Segmentation Analysis
- Categorized customers based on total lifetime value (LTV)
- Assigned customers to High, Mid, and Low-value segments
- Calculated key metrics: total revenue

🖥️ Query: [1_customer_segmentation.sql](1_customer_segmentation.sql)

**📈 Visualization:**

<img src="../Resources/images/7.3_customer_segementation.png" alt="Customer Segmentation" width="50%">

📊 **Key Findings:**
- High-value segment (25% of customers) drives 66% of revenue ($135.4M)
- Mid-value segment (50% of customers) generates 32% of revenue ($66.6M)
- Low-value segment (25% of customers) accounts for 2% of revenue ($4.3M)

💡 **Business Insights**
- High-Value (66% revenue): Offer premium membership program to 12,372 VIP customers, as losing one customer significantly impacts revenue
- Mid-Value (32% revenue): Create upgrade paths through personalized promotions, with potential $66.6M → $135.4M revenue opportunity
- Low-Value (2% revenue): Design re-engagement campaigns and price-sensitive promotions to increase purchase frequency

### 2. Customer Revenue by Cohort
- Tracked revenue and customer count per cohorts
- Cohorts were grouped by year of first purchase
- Analyzed customer revenue at a cohort level

🖥️ Query: [2_cohort_analysis.sql](2_cohort_analysis.sql)

**📈 Visualization:**

> ⚠️ Note: This only includes 2 charts. 

Customer Revenue by Cohort (Adjusted for time in market) - First Purchase Date 

<img src="../Resources/images/5.2_customer_revenue_normalized.png" alt="Customer Revenue Normalized" width="50%">

Investigate Monthly Revenue & Customer Trends (3 Month Rolling Average)

<img src="../Resources/images/5.2_monthly_revenue_customers_3mo.png" alt="Monthly Revenue & CustomerTrends" width="50%">  

📊 **Key Findings:**
- Text

💡 **Business Insights**
- Text

### 3. Retention Analysis
- Identified customers at risk of churning
- Analyzed last purchase patterns
- Calculated customer-specific metrics and warning indicators

🖥️ Query: [3_retention_analysis.sql](3_retention_analysis.sql)

**📈 Visualization:**

<img src="delete_this_example_when_done.png" alt="Cohort Analysis" width="50%">

📊 **Key Findings:**
- 2023 cohort shows highest first-year LTV ($1.2M avg/month)
- 2022 cohort plateaus at $1.1M avg/month after 12 months
- 2019-2021 cohorts show consistent growth pattern:
    - First 3 months: Rapid growth to $800K avg/month
    - Months 4-8: Steady increase to $1M avg/month
    - Months 9-12: Stabilization around $1.1M avg/month

💡 **Business Insights**
- Cohort Performance: 2023 cohort outperforming previous years by 9% in first-year value, suggesting successful acquisition strategies to replicate
- Growth Patterns: Critical engagement window identified in months 4-8, requiring targeted campaigns during plateau periods
- Revenue Optimization: Focus on first 3 months for customer engagement, followed by retention strategies for months 4-8 growth period

## Strategic Recommendations

1. **High-Value Focus** ($100K opportunity)
   - Launch premium membership program
   - Deploy churn early warning system
   - Implement proactive service outreach

2. **Acquisition Optimization**
   - Increase social media investment (2x LTV)
   - Optimize seasonal timing
   - Adjust CAC by channel performance

3. **Retention Enhancement**
   - Launch segment-specific reactivation campaigns
   - Create automated upgrade paths
   - Develop targeted loyalty programs

## Technical Details
- **Database:** PostgreSQL
- **Analysis Tools:** PostgreSQL
- **Visualization:** ChatGPT