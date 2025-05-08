use companies_analysis;


CREATE TABLE companies_mergedData (
    Company_ID INT,
    Company_Name VARCHAR(255),
    Foundation_Year INT,
    Closing_Year INT,
    Dynamic_Duration INT,
    Industries VARCHAR(255),
    Status VARCHAR(50),
    Current_Status VARCHAR(50),
    Notes VARCHAR(255),
    Years INT,
    Employee_Number INT,
    Revenue DOUBLE,
    Net_Income DOUBLE,
    Assets DOUBLE,
    Long_Term_Debt DOUBLE,
    Total_Liabilities DOUBLE,
    Holders_Equity DOUBLE,
    Avg_Stock_Price DOUBLE,
    Avg_TTM_Net_EPS DOUBLE,
    Avg_PE_Ratio DOUBLE
);
-- --------------------------------------------------
-- 📊 Company Data Analysis - SQL Queries
-- Dataset: companies_mergedData
-- Prepared by: Abeer Gaber
-- --------------------------------------------------

-- 🔍 1. highest net income 
SELECT c1.`Years`, c1.`Company_Name`, c1.`Net_Income`
FROM `companies_mergedData` c1
WHERE c1.`Net_Income` = (
    SELECT MAX(c2.`Net_Income`)
    FROM `companies_mergedData` c2
    WHERE c2.`Years` = c1.`Years`
);

-- 🔍 2. lowest net income
SELECT c1.`Years`, c1.`Company_Name`, c1.`Net_Income`
FROM `companies_mergedData` c1
WHERE c1.`Net_Income` = (
    SELECT MIN(c2.`Net_Income`)
    FROM `companies_mergedData` c2
    WHERE c2.`Years` = c1.`Years`
);

-- 🔍 3. highest revenue
SELECT `Company_Name`, `Years`, `Revenue`
FROM `companies_mergedData`
ORDER BY `Revenue` DESC
LIMIT 5;

-- 🔍 4. highest assets 
SELECT `Company_Name`, `Years`, `Assets`
FROM `companies_mergedData`
ORDER BY `Assets` DESC
LIMIT 5;

-- 🔍 5. rofit Margin
SELECT `Company_Name`, `Years`, `Revenue`, `Net_Income`,
       (`Net_Income` / `Revenue`) * 100 AS `Profit_Margin`
FROM `companies_mergedData`
WHERE `Revenue` > 0;

-- 🔍 6.  Long-Term Debt to Assets Ratio
SELECT `Company_Name`, `Years`, `long_Term_Debt`, `Assets`,
       (`long_Term_Debt` / `Assets`) * 100 AS `Debt_to_Assets_Ratio`
FROM `companies_mergedData`
WHERE `Assets` > 0;

-- 🔍 7. PE Ratio acoording to company status
SELECT `Status`, AVG(`Avg_PE_Ratio`) AS `Average_PE_Ratio`
FROM `companies_mergedData`
GROUP BY `Status`;

-- 🔍 8. active vs defunct companies financial perforemance 
SELECT `Status`, 
       AVG(`Revenue`) AS `Avg_Revenue`,
       AVG(`Net_Income`) AS `Avg_Net_Income`,
       AVG(`Assets`) AS `Avg_Assets`,
       AVG(`Total_Liabilities`) AS `Avg_Liabilities`
FROM `companies_mergedData`
GROUP BY `Status`;

-- 🔍 9. comapny duration according to status
SELECT `Status`, AVG(`Duration`) AS `Average_Duration`
FROM `companies_mergedData`
GROUP BY `Status`;

-- 🔍 10. highest stock price
SELECT `Company_Name`, `Years`, `Avg_Stock_Price`
FROM `companies_mergedData`
ORDER BY `Avg_Stock_Price` DESC
LIMIT 5;

-- 🔍 11. highest (EPS)
SELECT `Company_Name`, `Years`, `Avg_TTM_Net_EPS`
FROM `companies_mergedData`
ORDER BY `Avg_TTM_Net_EPS` DESC
LIMIT 5;

-- 🔍 12. The Most Volatile Companies in Net Income
SELECT `Company_Name`,
       (MAX(`Net_Income`) - MIN(`Net_Income`)) AS `Profit_Variation`
FROM `companies_mergedData`
GROUP BY `Company_Name`
ORDER BY `Profit_Variation` DESC
LIMIT 5;

-- 🔍 13.  Companies with Above-Average Stock Prices
SELECT `Company_Name`, `Avg_Stock_Price`
FROM `companies_mergedData`
WHERE `Avg_Stock_Price` > (
    SELECT AVG(`Avg_Stock_Price`) FROM `companies_mergedData`
);

-- 🔍 14. Companies with the Highest Debt-to-Equity Ratios
SELECT `Company_Name`, `Years`, `Total_Liabilities`, `Holders_Equity`,
       (`Total_Liabilities` / `Holders_Equity`) AS `Debt_to_Equity_Ratio`
FROM `companies_mergedData`
WHERE `Holders_Equity` > 0
ORDER BY `Debt_to_Equity_Ratio` DESC
LIMIT 5;
