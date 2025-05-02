library(tidyverse)
library(ggplot2)
library(ggcorrplot)
library(openxlsx)
library(readxl)
library(janitor)
library(dplyr)
library(readr)
library(lubridate)
library(gridExtra)

company_mergedData <- read.csv("D:/Data Analysis/Company_Analysis_Project/companies_mergedData.csv")
names(company_mergedData)

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# save the pdf file

pdf("D:/Data Analysis/Company_Analysis_Project/companies_Financial_plots.pdf", width = 15, height = 10)

# --- 1. Financial Plots ---

# Revenue vs Net Income
p1 <- ggplot(company_mergedData, aes(x = Years)) +
  geom_line(aes(y = Revenue, color = "Revenue")) +
  geom_line(aes(y = Net_Income, color = "Net Income")) +
  labs(title = "Revenue vs Net Income Over Years", x = "Years", y = "Amount") +
  scale_color_manual(name = "Metrics", values = c("Revenue" = "blue", "Net Income" = "green")) +
  theme_minimal()
print(p1)
summary1 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This plot compares the company’s revenue and net income over the years./nIt helps identify profitability trends and assess financial performance.", 
           hjust = 0.5, size = 5) +
  theme_void()
print(summary1)


# Assets vs Total Liabilities
p2 <- ggplot(company_mergedData, aes(x = Years)) +
  geom_line(aes(y = Assets, color = "Assets")) +
  geom_line(aes(y = Total_Liabilities, color = "Total Liabilities")) +
  labs(title = "Assets vs Total Liabilities", x = "Years", y = "Amount") +
  scale_color_manual(name = "Metrics", values = c("Assets" = "red", "Total Liabilities" = "orange")) +
  theme_minimal()
print(p2)

summary2 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This plot shows how the company's assets and liabilities evolved over time./nIt provides insight into financial stability and risk exposure.", 
           hjust = 0.5, size = 5) +
  theme_void()
print(summary2)

# Average Stock Price
p3 <- ggplot(company_mergedData, aes(x = Years, y = Avg_Stock_Price)) +
  geom_line(color = "purple") +
  labs(title = "Average Stock Price Over Years", x = "Years", y = "Average Stock Price") +
  theme_minimal()
print(p3)

summary3 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This plot tracks the average stock price of the company across years,/nreflecting investor confidence and market perception.", 
           hjust = 0.5, size = 5) +
  theme_void()
print(summary3)

# Number of Employees
p4 <- ggplot(company_mergedData, aes(x = Years, y = Employee_Number)) +
  geom_line(color = "brown") +
  labs(title = "Number of Employees Over Years", x = "Years", y = "Employees Number") +
  theme_minimal()
print(p4)

summary4 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This plot shows workforce growth./nIncreasing employee numbers often indicate expansion and investment in human capital.", 
           hjust = 0.5, size = 4) +
  theme_void()
print(summary4)

# --- 2. Company Status Plots ---

# Scatter Plot: Foundation vs Closing Year
p5 <- ggplot(company_mergedData, aes(x = Foundation_Year, y = Closing_Year, color = Current_Status)) +
  geom_point() +
  labs(title = "Company Status by Foundation and Closing Year", 
       x = "Foundation Year", y = "Closing Year") +
  scale_color_manual(values = c("Active" = "green", "Defunct" = "red", "Re-Opened" = "blue")) +
  theme_minimal()
print(p5)

summary5 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This scatter plot shows company statuses (Active, Defunct, Re-Opened)\nby their foundation and closing years.\nUseful to detect trends in longevity and restarts.", 
           hjust = 0.5, size = 4) +
  theme_void()
print(summary5)

# Pie Chart: Proportion of Status
p6 <- company_mergedData %>%
  distinct(Company_Name, .keep_all = TRUE) %>%
  count(Current_Status) %>%
  ggplot(aes(x = "", y = n, fill = Current_Status)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Company Status Proportions") +
  scale_fill_manual(values = c("Active" = "green", "Defunct" = "red", "Re-Opened" = "blue")) +
  theme_void()
print(p6)

summary6 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This pie chart shows the proportion of Active,\nDefunct, and Re-Opened companies,\noffering a quick overview of company lifecycles.", 
           hjust = 0.5, size = 5) +
  theme_void()
print(summary6)


# Histogram: Distribution by Foundation Year
p7 <- ggplot(company_mergedData %>% distinct(Company_Name, .keep_all = TRUE), 
             aes(x = Foundation_Year, fill = Status)) +
  geom_histogram(binwidth = 1, position = "dodge", color = "black") +
  labs(title = "Distribution of Companies by Foundation Year", x = "Foundation Year", y = "Count of Companies") +
  scale_fill_manual(values = c("Active" = "green", "Defunct" = "red")) +
  theme_minimal()
print(p7)

summary7 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, 
           label = "This histogram reveals the frequency of company foundations over time,/nhelping spot peaks in entrepreneurship.", 
           hjust = 0.5, size = 5) +
  theme_void()
print(summary7)
dev.off()



# --- 3. Statistics ---
pdf("D:/Data Analysis/Company_Analysis_Project/companies_Statistical_plots.pdf", width = 15, height = 10)
# Descriptive Statistics
summary_stats <- company_mergedData %>%
  summarise(
    Mean_Revenue = mean(Revenue, na.rm = TRUE),
    SD_Revenue = sd(Revenue, na.rm = TRUE),
    Mean_Income = mean(Net_Income, na.rm = TRUE),
    SD_Income = sd(Net_Income, na.rm = TRUE),
    Mean_Assets = mean(Assets, na.rm = TRUE),
    SD_Assets = sd(Assets, na.rm = TRUE),
    Mean_Liabilities = mean(Total_Liabilities, na.rm = TRUE),
    SD_Liabilities = sd(Total_Liabilities, na.rm = TRUE)
  )
print(gridExtra::grid.table(summary_stats))

# Correlation
cor_val <- cor(company_mergedData$Revenue, company_mergedData$Net_Income, use = "complete.obs")
cor_text_plot <- ggplot() +
  annotate("text", x = 1, y = 1, 
           label = paste("Correlation between Revenue and Net Income:/n", round(cor_val, 2)), 
           size = 6) +
  theme_void()
print(cor_text_plot)

# Linear Regression
lm_model <- lm(Net_Income ~ Revenue, data = company_mergedData)
reg_summary <- summary(lm_model)
reg_text <- paste0(
  "Linear Regression:/n",
  "Intercept: ", round(reg_summary$coefficients[1,1], 2), "/n",
  "Slope: ", round(reg_summary$coefficients[2,1], 2), "/n",
  "R-squared: ", round(reg_summary$r.squared, 2), "/n",
  "p-value: ", signif(reg_summary$coefficients[2,4], 3)
)
reg_text_plot <- ggplot() +
  annotate("text", x = 1, y = 1, label = reg_text, size = 5, hjust = 5) +
  theme_void()
print(reg_text_plot)

# Regression Line Plot
reg_line_plot <- ggplot(company_mergedData, aes(x = Revenue, y = Net_Income)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Linear Regression: Revenue vs Net Income", 
       x = "Revenue", y = "Net Income") +
  theme_minimal()
print(reg_line_plot)
dev.off()


