CREATE DATABASE EV_Analysis

USE ev_analysis

-- 1. Count of Records:
SELECT COUNT(*) AS total_records
FROM iea_global_ev_data;

-- 2. Unique Values in Each Column:
SELECT COUNT(DISTINCT region) AS unique_regions,
       COUNT(DISTINCT powertrain) AS unique_powertrains,
       COUNT(DISTINCT category) AS unique_categories
FROM iea_global_ev_data;

-- 3. Total Value by Region:
SELECT region, SUM(value) AS total_value
FROM iea_global_ev_data
GROUP BY region
ORDER BY total_value DESC;

-- 4. Average Value by Category:
SELECT category, AVG(value) AS avg_value
FROM iea_global_ev_data
GROUP BY category
ORDER BY avg_value DESC;

-- 5. Minimum and Maximum Values by Powertrain:
SELECT powertrain, MIN(value) AS min_value, MAX(value) AS max_value
FROM iea_global_ev_data
GROUP BY powertrain
ORDER BY min_value;

-- 6. Median Value by Region:
WITH ranked_values AS (
    SELECT region, value,
           ROW_NUMBER() OVER (PARTITION BY region ORDER BY value) AS rn,
           COUNT(*) OVER (PARTITION BY region) AS cnt
    FROM iea_global_ev_data
)
SELECT region,
       AVG(value) AS median_value
FROM ranked_values
WHERE rn IN (cnt / 2, (cnt + 1) / 2)
GROUP BY region;

-- 7. Yearly Aggregations by Region:
SELECT year, region, SUM(value) AS yearly_total
FROM iea_global_ev_data
GROUP BY year, region
ORDER BY year, region;

-- 8. Top 5 Categories by Total Value:
SELECT category, SUM(value) AS total_value
FROM iea_global_ev_data
GROUP BY category
ORDER BY total_value DESC
LIMIT 5;

-- 9. Change in Average Value by Powertrain Over Time:
SELECT year, powertrain, AVG(value) AS avg_value
FROM iea_global_ev_data
GROUP BY year, powertrain
ORDER BY year, powertrain;

-- 10. Year-over-Year Growth Rate by Region:
WITH yearly_data AS (
    SELECT year, region, AVG(value) AS avg_value
    FROM iea_global_ev_data
    GROUP BY year, region
)
SELECT current.year, current.region,
       (current.avg_value - previous.avg_value) / previous.avg_value * 100 AS growth_rate
FROM yearly_data AS current
JOIN yearly_data AS previous
ON current.region = previous.region AND current.year = previous.year + 1
ORDER BY current.region, current.year;

-- 11. Top 3 Regions with Highest Growth Rate:
WITH growth_rates AS (
    SELECT region, 
           (SUM(value) - LAG(SUM(value)) OVER (PARTITION BY region ORDER BY year)) / LAG(SUM(value)) OVER (PARTITION BY region ORDER BY year) * 100 AS growth_rate
    FROM iea_global_ev_data
    GROUP BY year, region
)
SELECT region, MAX(growth_rate) AS highest_growth_rate
FROM growth_rates
GROUP BY region
ORDER BY highest_growth_rate DESC
LIMIT 3;

-- 12. Rolling Average Value by Region:
SELECT year, region, 
       AVG(value) OVER (PARTITION BY region ORDER BY year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_value
FROM iea_global_ev_data
ORDER BY region, year;

-- 13. Powertrain Adoption Trends Over Time:
SELECT year, powertrain, SUM(value) AS total_value
FROM iea_global_ev_data
GROUP BY year, powertrain
ORDER BY year, powertrain;

-- 14. Growth in Specific Categories by Year:
SELECT year, category, 
       (SUM(value) - LAG(SUM(value)) OVER (PARTITION BY category ORDER BY year)) / LAG(SUM(value)) OVER (PARTITION BY category ORDER BY year) * 100 AS category_growth
FROM iea_global_ev_data
GROUP BY year, category
ORDER BY year, category;

-- 15. Top 10 Powertrains by Growth Rate:
WITH growth AS (
    SELECT powertrain, 
           (SUM(value) - LAG(SUM(value)) OVER (PARTITION BY powertrain ORDER BY year)) / LAG(SUM(value)) OVER (PARTITION BY powertrain ORDER BY year) * 100 AS growth_rate
    FROM iea_global_ev_data
    GROUP BY year, powertrain
)
SELECT powertrain, MAX(growth_rate) AS top_growth_rate
FROM growth
GROUP BY powertrain
ORDER BY top_growth_rate DESC
LIMIT 10;

-- 16. Value and Growth Analysis by Category and Region:
SELECT category, region,
       SUM(value) AS total_value,
       (SUM(value) - LAG(SUM(value)) OVER (PARTITION BY category, region ORDER BY year)) / LAG(SUM(value)) OVER (PARTITION BY category, region ORDER BY year) * 100 AS growth_rate
FROM iea_global_ev_data
GROUP BY category, region, year
ORDER BY category, region, year;

-- 17. Change in Value Distribution by Powertrain Over Years:
SELECT year, powertrain, 
       MIN(value) AS min_value, 
       MAX(value) AS max_value, 
       AVG(value) AS avg_value
FROM iea_global_ev_data
GROUP BY year, powertrain
ORDER BY year, powertrain;

-- 18. Anomaly Detection in Values:
WITH rolling_stats AS (
    SELECT region, year, value,
           AVG(value) OVER (PARTITION BY region ORDER BY year ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS rolling_mean,
           STDDEV(value) OVER (PARTITION BY region ORDER BY year ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS rolling_stddev
    FROM iea_global_ev_data
)
SELECT region, year, value,
       rolling_mean, rolling_stddev,
       CASE
           WHEN ABS(value - rolling_mean) > 2 * rolling_stddev THEN 'Anomaly'
           ELSE 'Normal'
       END AS anomaly_status
FROM rolling_stats;

-- 19. Powertrain Performance Metrics Comparison:
SELECT powertrain,
       SUM(value) AS total_value,
       AVG(value) AS avg_value,
       MIN(value) AS min_value,
       MAX(value) AS max_value
FROM iea_global_ev_data
GROUP BY powertrain
ORDER BY total_value DESC;

-- 20. Forecasting with Moving Averages:
SELECT year, region,
       AVG(value) OVER (PARTITION BY region ORDER BY year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS moving_avg
FROM iea_global_ev_data
ORDER BY region, year;

-- 21. Value Analysis by Category and Yearly Trends:
SELECT year, category,
       SUM(value) AS total_value,
       AVG(value) AS avg_value
FROM iea_global_ev_data
GROUP BY year, category
ORDER BY year, category;

-- 22. Comparative Analysis of Growth Rates Across Powertrains:
WITH growth AS (
    SELECT powertrain, 
           (SUM(value) - LAG(SUM(value)) OVER (PARTITION BY powertrain ORDER BY year)) / LAG(SUM(value)) OVER (PARTITION BY powertrain ORDER BY year) * 100 AS growth_rate
    FROM iea_global_ev_data
    GROUP BY year, powertrain
)
SELECT powertrain, AVG(growth_rate) AS avg_growth_rate
FROM growth
GROUP BY powertrain
ORDER BY avg_growth_rate DESC;

-- 23. Custom Aggregations for Multi-dimensional Analysis:
SELECT year, region, powertrain, category,
       SUM(value) AS total_value,
       AVG(value) AS avg_value
FROM iea_global_ev_data
GROUP BY year, region, powertrain, category
ORDER BY year, region, powertrain, category;

-- 24. Trend Analysis with Cumulative Sums:
SELECT year, region,
       SUM(value) OVER (PARTITION BY region ORDER BY year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum
FROM iea_global_ev_data
ORDER BY region, year;

-- 25. Percentage Change in Value from Previous Year:
WITH yearly_data AS (
    SELECT year, region, SUM(value) AS total_value
    FROM iea_global_ev_data
    GROUP BY year, region
)
SELECT current.year, current.region,
       ((current.total_value - previous.total_value) / previous.total_value * 100) AS percentage_change
FROM yearly_data AS current
JOIN yearly_data AS previous
ON current.region = previous.region AND current.year = previous.year + 1
ORDER BY current.region, current.year;

