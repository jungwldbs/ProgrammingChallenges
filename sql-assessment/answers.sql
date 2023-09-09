# Write a query to get the sum of impressions by day.
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY date
ORDER BY date;

# Top three revenue-generating states in order of best to worst. 
# How much revenue did the third best state generate?
SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;
# Third Best: Ohie, 37577

# Write a query that shows total cost, impressions, clicks, and revenue of each campaign. 
# Make sure to include the campaign name in the output.
SELECT ci.name AS campaign_name,
       SUM(mp.cost) AS total_cost,
       SUM(mp.impressions) AS total_impressions,
       SUM(mp.clicks) AS total_clicks,
       SUM(wr.revenue) AS total_revenue
FROM campaign_info ci
JOIN marketing_data mp ON ci.id = mp.campaign_id
JOIN website_revenue wr ON ci.id = wr.campaign_id
GROUP BY ci.name
ORDER BY total_revenue DESC;


# Write a query to get the number of conversions of Campaign5 by state. 
# Which state generated the most conversions for this campaign?
SELECT ci.name AS campaign_name,
       wr.state,
       SUM(mp.conversions) AS total_conversions
FROM marketing_data mp
JOIN website_revenue wr ON mp.campaign_id = wr.campaign_id
JOIN campaign_info ci ON mp.campaign_id = ci.id
WHERE ci.name = 'Campaign5'
GROUP BY ci.name, wr.state
ORDER BY total_conversions DESC
LIMIT 1;


# In your opinion, which campaign was the most efficient, and why?
SELECT ci.name AS campaign_name,
       SUM(wr.revenue) AS total_revenue,
       SUM(mp.cost) AS total_cost,
       (SUM(wr.revenue) - SUM(mp.cost)) / SUM(mp.cost) AS roi
FROM campaign_info ci
JOIN marketing_data mp ON ci.id = mp.campaign_id
JOIN website_revenue wr ON ci.id = wr.campaign_id
GROUP BY ci.name
ORDER BY roi DESC;
# efficient campaign based on ROI: Campaign4

# Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT 
    CASE 
        WHEN day_of_week = 1 THEN 'Sunday'
        WHEN day_of_week = 2 THEN 'Monday'
        WHEN day_of_week = 3 THEN 'Tuesday'
        WHEN day_of_week = 4 THEN 'Wednesday'
        WHEN day_of_week = 5 THEN 'Thursday'
        WHEN day_of_week = 6 THEN 'Friday'
        WHEN day_of_week = 7 THEN 'Saturday'
    END AS day_of_week,
    AVG(impressions) AS avg_impressions
FROM (
    SELECT 
        DAYOFWEEK(date) AS day_of_week,
        impressions
    FROM marketing_data
) subquery
GROUP BY day_of_week
ORDER BY avg_impressions DESC
LIMIT 1;



