
<p align="center">
  <strong style="font-size: 32px;">📉 How to Avoid Company Closure:</strong><br>
  <em style="font-size: 18px;">A Data-Driven Survival Guide</em>
</p>

**Author:** Abeer Gaber  
**Date:** 2025-05-02

---


## 🔍 Overview

This project delves into the financial, stock, and operational data of companies to uncover critical patterns associated with their long-term success or potential closure. By leveraging real-world company data, this report provides actionable insights to help business owners identify early warning signs of failure and take proactive measures to sustain their operations.



## 📂 Dataset Description

The dataset includes key financial and performance metrics for various companies, offering a comprehensive view of their operational health. The following variables are included:

- **Status:** Indicates whether the company is active or closed.
- **Lifespan (duration):** The number of years the company operated.
- **Annual Revenue:** Yearly revenue data for each company.
- **P/E Ratio:** A financial metric used to assess the company's valuation.
- **Average Stock Price:** Reflects the company’s stock performance over time.
- **Company Name and Year:** The identity and operational timeline of each company.



## 📊 Visualizations (R)

Several interactive and insightful visualizations are included to illustrate key findings:

- **Company Status Distribution:** A bar chart showing the number of active vs. closed and Re-Opened companies.
- **Company Lifespan Comparison:** A boxplot comparing the lifespan of companies that survived vs. those that closed.
- **Revenue Trends Over Time:** A line chart tracking revenue changes over the years for each company.
- **PE Ratio and Stock Price Correlation:** A scatter plot analyzing the relationship between P/E ratio and stock price.



## 📊 Statistical Analysis Visualizations

In-depth statistical analyses provide a clearer understanding of the factors influencing company survival:

- **Descriptive Statistics:** A summary of key metrics like revenue, stock price, and P/E ratio.
- **Correlation Analysis:** Investigates relationships between variables (e.g., revenue and net income).
- **Linear Regression (net_income ~ revenue):** Explores the impact of revenue on net income with a regression model.
- **Regression Line Plot:** A visual representation of the regression line to understand trends and deviations.
- **Prediction Model:** Forecasting Future Company Status.



## 📊 SQL-Based Financial Analysis

In addition to R-based visualizations, this project also includes an **SQL analysis** part that dives deeper into company performance across multiple financial aspects.

The SQL queries explore:

- **Top Profitable Companies per Year:** Finding companies with the highest net income each year.
- **Average PE Ratio by Company Status:** Comparing active and closed companies.
- **Profit Margins:** Analyzing the percentage of net income relative to revenue.
- **Stock Price Analysis:** Identifying companies with above-average stock prices.
- **Revenue and Debt Comparison:** Understanding how revenue and long-term debt differ between surviving and closed companies.
- **Lowest Profitability in Recent Years:** Detecting companies at financial risk.
- **Profit Variability:** Measuring how much net income fluctuated over time.
- **Debt-to-Equity Ratio Insights:** Evaluating financial leverage.

> 📂 All SQL queries are provided in the file `company_data_analysis.sql`.


## 📈 Power BI Dashboards

Power BI was used to build dynamic dashboards that present real-time insights with user-friendly visuals:

- 📊 **Profit Trends and Forecasting**  
  ![Profit Analysis](https://github.com/ABBERGABER-GITHUB/Companies_Analysis_Project/blob/main/images/Powerbi_Profit_Analysis.png)

- 📉 **Status Breakdown by Year**  
  ![Status Breakdown](https://github.com/ABBERGABER-GITHUB/Companies_Analysis_Project/blob/main/images/powerbi_Status_Analysis.png)

- 💵 **Operation & Market Performance**  
  ![Revenue Net Income](https://github.com/ABBERGABER-GITHUB/Companies_Analysis_Project/blob/main/images/Powerbi_Stock_Analysis.png)

- ⚠️ **Warning Flags and Risk Prediction**  
  ![Revenue Net Income](https://github.com/ABBERGABER-GITHUB/Companies_Analysis_Project/blob/main/images/Powerbi_Warning_Flags.png)
  
> 🎯 The Power BI file (`Companies_Data_Analysis.pbix`) is included for exploration.



## 📉 Excel-Based Analysis

Excel was used for data cleaning, sorting, conditional formatting, and creating pivot tables that highlight:

- **Revenue and Net Income Trends**
- **Top 10 Companies by Stock Price**
- **Year-over-Year Growth Summaries**
- **Interactive Slicers for Company Status and Year**

> 📂 Excel workbook included: `financial_summary_analysis.xlsx`



## 📌 Key Findings

- **Lifespan and Survival:** Surviving companies typically have much longer lifespans than those that close.
- **Revenue Fluctuations:** Companies experiencing significant revenue fluctuations or sharp declines are at a higher risk of closure.
- **PE Ratio Indicator:** A low P/E ratio often signals poor investor confidence and a higher likelihood of closure.
- **Critical Factors for Survival:** Adaptability, financial health, and innovation are crucial to ensuring a company’s survival in the long run.



## 🛠️ Tools Used

This analysis leverages the following tools and technologies:

- **R** (ggplot2, dplyr, readr, knitr, openxlsx, tidyverse, readxl, janitor, lubridate, gridExtra, scales, tidyr, ggthemes, kableExtra, DT)
- **MySQL Workbench** (for advanced SQL queries and financial insights)
- **R Markdown:** For generating dynamic reports.
- **CSV & Excel Files:** Cleaned and pre-processed data for analysis.
- **Power Bi:** Create an interactive dashboard with slicers analyzing various type of companies data and predict closure and profit.
- **Visualization & Insight Reporting:** A focus on creating clear and actionable insights through interactive visualizations.



## 🧭 How to Run This Report

1. Clone the repository or download the `.Rmd` and `.sql` files.
2. Open the R Markdown file in **RStudio** to view and run the R-based analysis.
3. Install the necessary R packages:
   ```R
   install.packages(c("ggplot2", "dplyr", "readr", "knitr", "openxlsx", "tidyverse", "readxl", "janitor", "lubridate", "gridExtra", "scales", "tidyr", "ggthemes", "kableExtra", "DT"))
  ```
4. Adjust the dataset


## 👩‍💻 About the Author

**Abeer Gaber**  
An aspiring Data Analyst with a passion for turning complex data into actionable business insights. I am skilled in R, Power BI, MySQL, and Excel, focusing on real-world applications related to business survival, financial health, and strategic decision-making.



## 📫 Contact

- 📧 **Email:** [gaberabeer19@gmail.com](mailto:gaberabeer19@gmail.com)
- 💼 **LinkedIn:** [linkedin.com/in/abeer-gaber-88a271118](https://www.linkedin.com/in/abeer-gaber-88a271118/)
- 🗂 **GitHub:** [github.com/ABBERGABER-GITHUB](https://github.com/ABBERGABER-GITHUB)


### Quick Recap:

1. **Add the above text** into your `README.md` file.
2. **Upload sample images** of your reports, charts, or any relevant visuals into the `Images/` folder, then link them under the **Sample Images** section.

## 🧾 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

*Feel free to explore the project and reach out for collaboration or inquiries!*

