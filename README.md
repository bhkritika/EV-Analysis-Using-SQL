# EV Analysis Using SQL

## Overview

This project presents a comprehensive analysis of electric vehicle (EV) data from the International Energy Agency (IEA). The dataset, `iea_global_ev_data`, includes detailed information on EV values categorized by region, category, powertrain, and year. The objective is to uncover key trends, growth patterns, and insights into the adoption and distribution of electric vehicles across different regions and categories.

## Database Setup

To set up the database, execute the following SQL commands:

```sql
    CREATE DATABASE EV_Analysis;
    USE EV_Analysis;

## Analysis Overview

1. Count of Records
- Determine the total number of records in the dataset.

2. Unique Values in Each Column
- Identify the number of unique entries in the region, powertrain, and category columns.

3. Total Value by Region
- Calculate the total EV value for each region.

4. Average Value by Category
- Compute the average EV value for each category.

5. Minimum and Maximum Values by Powertrain
- Find the minimum and maximum EV values for each powertrain type.

6. Median Value by Region
- Determine the median EV value within each region.

7. Yearly Aggregations by Region
- Aggregate the total EV value by year and region.

8. Top 5 Categories by Total Value
- List the top 5 categories with the highest total EV values.

9. Change in Average Value by Powertrain Over Time
- Analyze the average EV value for each powertrain type over the years.

10. Year-over-Year Growth Rate by Region
- Calculate the year-over-year growth rate of EV values for each region.

11. Top 3 Regions with Highest Growth Rate
- Identify the top 3 regions with the highest growth rates in EV values.

12. Rolling Average Value by Region
- Compute the rolling average of EV values for each region over a specified window.

13. Powertrain Adoption Trends Over Time
- Examine the trends in EV values for different powertrain types over time.

14. Growth in Specific Categories by Year
- Analyze the growth in EV values for specific categories year over year.

15. Top 10 Powertrains by Growth Rate
- List the top 10 powertrains with the highest growth rates.

16. Value and Growth Analysis by Category and Region
- Provide an analysis of EV values and growth rates by category and region.

17. Change in Value Distribution by Powertrain Over Years
- Analyze the change in value distribution for powertrains over the years.

18. Anomaly Detection in Values
- Detect anomalies in EV values using rolling statistics.

19. Powertrain Performance Metrics Comparison
- Compare various performance metrics of powertrains.

20. Forecasting with Moving Averages
- Forecast future EV values using moving averages.

21. Value Analysis by Category and Yearly Trends
- Analyze EV values by category and examine yearly trends.

22. Comparative Analysis of Growth Rates Across Powertrains
- Compare growth rates across different powertrains.

23. Custom Aggregations for Multi-dimensional Analysis
- Provide custom aggregations for a multi-dimensional analysis of the data.

24. Trend Analysis with Cumulative Sums
- Perform trend analysis using cumulative sums of EV values.

25. Percentage Change in Value from Previous Year
- Calculate the percentage change in EV values from the previous year.

## Conclusion

The analysis provides valuable insights into the growth, distribution, and trends of electric vehicles across various regions and powertrains. It highlights regional performance, category trends, and growth patterns, offering a comprehensive view of the global EV landscape.