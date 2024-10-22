# User_Activity_Analysis_SQL

🔍 Project Description 🔍
--------------------
This project aimed to analyze user engagement by querying login data to uncover activity patterns, inactive users, and trends across different time periods.
The goal of this project is to uncover trends in user engagement by analyzing login data, providing insights for optimizing user retention strategies.

🚀 Tools and technologies:
-----------------------
The analysis was conducted using MS SQL Server, used Common Table Expressions (CTEs) and window functions to handle complex queries across large datasets.

⚡Data Model:
-----------
The data consisted of two tables: users and logins. I used SQL queries to filter login records, group data by time periods (e.g., quarters), and compute session counts and activity metrics.

💡Learnings:
--------------
I wrote queries and utilized various SQL functions and techniques, including date functions like `DATETRUNC`, `DATEADD`, `DATEDIFF`, `DATEPART`, and `GETDATE` to handle date-based calculations such as finding the month, year, and specific time periods. I also leveraged `MAX` to extract the latest login, along with `GROUP BY` and `HAVING` to aggregate data. CTEs and subqueries helped simplify complex queries, and I applied window functions for tasks like calculating session percentage changes and ranking users based on activity.

🛑Challenges Faced:
-----------------
One challenge was calculating percentage change in session counts across quarters, which required advanced SQL techniques like window functions and date partitioning. Also faced issue in identifying few date functions to uncover the insights.

📊 Key Insights:
--------------
There was a 40% increase in Quarter 4 and a 14.29% increase in Quarter 1, but there is no drop in the sessions, highlighted daily power users, and pinpointed days with zero user activity, which provides valuable insights for improving user retention strategies.

This project enhanced my understanding of SQL for business analytics, especially working with date-based functions and advanced query techniques.
