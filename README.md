# User_Activity_Analysis_SQL

Project Description:
--------------------
This project aimed to analyze user engagement by querying login data to uncover activity patterns, inactive users, and trends across different time periods.
The goal of this project is to uncover trends in user engagement by analyzing login data, providing insights for optimizing user retention strategies.

Tools and technologies:
-----------------------
The analysis was conducted using SQL, leveraging Common Table Expressions (CTEs) and window functions to handle complex queries across large datasets.

Methodologies:
--------------
I wrote queries to analyze login frequency, identify inactive users, calculate quarterly session growth, and detect days with no logins. Advanced SQL techniques like window functions and joins were used to calculate percentage changes and find top users per day.

Data Model:
-----------
The data consisted of two tables: users_id and logins. I used SQL queries to filter login records, group data by time periods (e.g., quarters), and compute session counts and activity metrics.

Challenges Faced:
-----------------
One challenge was calculating percentage change in session counts across quarters, which required advanced SQL techniques like window functions and date partitioning

Key Insights:
--------------
The analysis revealed that session activity dropped by 12% in the last quarter, while certain power users had daily login streaks. Additionally, several inactive users were identified for targeted re-engagement campaigns.
I identified a 12% drop in sessions in the last quarter, highlighted daily power users, and pinpointed days with zero user activity, which provides valuable insights for improving user retention strategies.

This project enhanced my understanding of SQL for business analytics, especially working with date-based functions and advanced query techniques.
