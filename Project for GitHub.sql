create database practicesql;
use practicesql;
CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');
-----
INSERT INTO LOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO LOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO LOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO LOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO LOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);
INSERT INTO LOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO LOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO LOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO LOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);

select * from users;
select * from logins;

-- Q1). Management wants to see all the users that did not login in the past 5 months --

with user_login as (
select USER_ID, MAX(LOGIN_TIMESTAMP) as maximum_login
from logins 
group by USER_ID
having MAX(LOGIN_TIMESTAMP) < DATEADD(MONTH, -5, GETDATE()))
select ul.USER_ID, u.USER_NAME from user_login ul join users u on ul.USER_ID = u.USER_ID;
-- or
select distinct USER_ID from logins where USER_ID not in (
select USER_ID
from logins
group by USER_ID
having max(LOGIN_TIMESTAMP) > DATEADD(MONTH, -5, GETDATE()));

-- Q2). For the business units' quarterly analysis, calculate how many users and how many sessions were at each quarter
-- order by quarter from newest to oldest
-- return: first day of quarter, user_cnt, session_cnt

select min(LOGIN_TIMESTAMP) as quarter_first_login,
DATETRUNC(QUARTER, min(LOGIN_TIMESTAMP)) as quarter_first_day, count(distinct user_id) as user_cnt, count(*) as sessions_cnt,
DATEPART(QUARTER, LOGIN_TIMESTAMP) as quarter
from logins
group by DATEPART(QUARTER, LOGIN_TIMESTAMP);

-- Q3). Display user id's that log-in in january 2024 and did not login in on November 2023.
-- return: user_id

with cte as (
select distinct USER_ID, YEAR(LOGIN_TIMESTAMP) as year, MONTH(LOGIN_TIMESTAMP) as month
from logins
where YEAR(LOGIN_TIMESTAMP)= 2024 and MONTH(LOGIN_TIMESTAMP) = 1)
select USER_ID from cte where USER_ID not in (
select distinct USER_ID
from logins
where YEAR(LOGIN_TIMESTAMP)= 2023 and MONTH(LOGIN_TIMESTAMP) = 11
);

-- or
select distinct USER_ID
from logins where LOGIN_TIMESTAMP between '2024-01-01' and '2024-01-31'
and USER_ID not in (select distinct USER_ID
from logins where LOGIN_TIMESTAMP between '2023-11-01' and '2023-11-30');

-- Q4). Add to the query from 2 percentage change in sessions from last quarter.
-- return: first day of quarter, session_cnt, session_cnt_prev, session_pct_change.

with cte as (
select DATEPART(QUARTER, LOGIN_TIMESTAMP) as quarter, DATETRUNC(QUARTER,MIN(login_timestamp)) as first_day_quarter, count(*) as session_cnt
from logins
group by DATEPART(QUARTER, LOGIN_TIMESTAMP)),
cte1 as (
select quarter, session_cnt, 
Lag(session_cnt,1) over(order by first_day_quarter) as 'session_cnt_prev' from cte)
select *, (session_cnt-session_cnt_prev)*100.0/session_cnt_prev as session_pct_change from cte1;

-- Q5.) Display the user that had the highest session score (max) for each day;
-- return: date, username, score

with cte as (
select USER_ID, cast(LOGIN_TIMESTAMP as date) as day, sum(session_score) as score
from logins
group by USER_ID, cast(LOGIN_TIMESTAMP as date)),
cte1 as (
select *, ROW_NUMBER() over(partition by day order by score desc) as 'rn' from cte)
select c1.day,c1.score, c1.rn, u.USER_NAME from cte1 c1 join users u on c1.user_id = u.USER_ID where rn = 1;


-- Q6.) To identify our best users - Return the users that had a session on every single day since their first login
-- (make assumptions if needed)
-- return: user_id 

select USER_ID, MIN(CAST(LOGIN_TIMESTAMP as date)) as first_login_date,
DATEDIFF(DAY, MIN(CAST(LOGIN_TIMESTAMP as date)), '2024-06-28')+1 as no_of_login_days_required,
count(distinct CAST(LOGIN_TIMESTAMP as date)) as no_of_login_days
from logins
group by USER_ID
having count(distinct CAST(LOGIN_TIMESTAMP as date)) = DATEDIFF(DAY, MIN(CAST(LOGIN_TIMESTAMP as date)), '2024-06-28')+1
order by USER_ID;

-- Q7.) On what dates there were no login at all ?
-- return: login_dates

select cal_date
from calendar_dim c
inner join (select CAST(min(LOGIN_TIMESTAMP) as date) as first_date, cast(GETDATE() as date) as last_date
from logins) as a on c.cal_date between first_date and last_date 
where cal_date not in 
(select cast(login_timestamp as date) from logins);

-- or

with cte as (
select cast(MIN(LOGIN_TIMESTAMP) as date) as first_login, cast(GETDATE() as date) as last_login
from logins l)
select distinct cast(login_timestamp as date) from logins where login_timestamp not in(
select cal_date from calendar_dim cal join cte c on cal.cal_date between c.first_login and c.last_login);