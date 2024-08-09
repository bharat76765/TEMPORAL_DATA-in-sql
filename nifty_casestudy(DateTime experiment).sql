SELECT * FROM data.nifty;
USE data;
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE nifty
ADD COLUMN date1 DATE AFTER `Date`;
UPDATE nifty 
SET date1= STR_TO_DATE(`Date`,'%d-%b-%Y');
SELECT * FROM data.nifty;
ALTER TABLE nifty
DROP COLUMN `Date`;

-- 1. What was the highest closing price recorded in 2020 (limited to first 4 months)?
SELECT date1, Close
FROM nifty
WHERE YEAR(date1) = 2020
ORDER BY Close DESC
LIMIT 1;

-- 2. Which month had the highest average closing price in the first four months of 2020?
SELECT DATE_FORMAT(date1, '%Y-%m') AS month, AVG(Close) AS avg_closing_price
FROM nifty
WHERE date1 BETWEEN '2020-01-01' AND '2020-04-30'
GROUP BY month
ORDER BY avg_closing_price DESC
LIMIT 1;

SELECT * FROM nifty;
-- 3. What was the total number of shares traded on the last trading day of each month in 2020 (first 4 months)?
SELECT DATE_FORMAT(date1, '%Y-%m-%d') AS month, `Shares Traded`
FROM nifty
WHERE date1 = LAST_DAY(date1) AND YEAR(date1) = 2020
ORDER BY month;

SELECT * FROM nifty;

-- 4. Which day in the first quarter of 2020 had the highest turnover?
SELECT date1, `Turnover (Rs. Cr)`
FROM nifty
WHERE date1 BETWEEN '2020-01-01' AND '2020-03-31'
ORDER BY `Turnover (Rs. Cr)` DESC
LIMIT 1;

SELECT * FROM nifty;

-- 5. What was the average opening price of the stock on Mondays in the first four months of 2020?
SELECT AVG(Open) AS avg_opening_price
FROM nifty
WHERE DAYOFWEEK(date1) = 2 AND date1 BETWEEN '2020-01-01' AND '2020-04-30';

-- 6. On which day did the stock reach its highest price in the first four months of 2020?
SELECT date1, High
FROM nifty
WHERE date1 BETWEEN '2020-01-01' AND '2020-04-30'
ORDER BY High DESC
LIMIT 1;

SELECT * FROM nifty;

-- 7. How many shares were traded in total during the first week of January 2020?
SELECT SUM(`Shares Traded`) AS total_shares_traded
FROM nifty
WHERE date1 BETWEEN '2020-01-01' AND '2020-01-07';

SELECT * FROM nifty;

-- 8. What was the lowest closing price recorded on the last trading day of each week in the first four months of 2020?
SELECT DATE_FORMAT(date1, '%Y-%u') AS week, MIN(Close) AS min_closing_price
FROM nifty
WHERE date1 IN (
    SELECT MAX(date1) FROM nifty GROUP BY YEARWEEK(date1))
AND date1 BETWEEN '2020-01-01' AND '2020-04-30'
GROUP BY week
ORDER BY min_closing_price ASC
LIMIT 1;

SELECT * FROM nifty;

-- 9. What was the average turnover on the first trading day of each mpnth in the first four months of 2020?
SELECT DATE_FORMAT(date1, '%Y-%m') AS month, AVG(`Turnover (Rs. Cr)`) AS avg_turnover
FROM nifty
WHERE YEAR(date1) = 2020
GROUP BY month;

-- 10. How many days in the first four months of 2020 had a closing price higher than the opening price?
SELECT COUNT(*) AS num_days
FROM nifty
WHERE Close > Open AND date1 BETWEEN '2020-01-01' AND '2020-04-30';
