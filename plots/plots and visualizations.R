# Step 1: Reading companies dataset files:

finance <- read.csv("D:/Data Analysis/Company_Analysis_Project/data/finance_cleaned.csv")
Status <- read.csv("D:/Data Analysis/Company_Analysis_Project/data/status_cleaned.csv")
stock <- read.csv("D:/Data Analysis/Company_Analysis_Project/data/stock_cleaned.csv")
emp_count <- read.csv("D:/Data Analysis/Company_Analysis_Project/data/emp_count_cleaned.csv")


# creating visualizations in PDF file

# load libraries 
library(ggplot2)
library(dplyr)
library(ggcorrplot)
library(gridExtra)

# Start saving the plots in a PDF file
pdf("D:/Data Analysis/Company_Analysis_Project/plots/project_plots_combined.pdf")

# 1. Financial Plots

# Plot showing Revenue vs Net Income over the years
p1 <- ggplot(finance, aes(x = years)) +
  geom_line(aes(y = revenue, color = "Revenue")) +
  geom_line(aes(y = net_income, color = "Net Income")) +
  labs(title = "Revenue vs Net Income Over Years", 
       x = "Years", y = "Amount") +
  scale_color_manual(name = "Metrics", values = c("Revenue" = "blue", "Net Income" = "green")) +
  theme_minimal()

print(p1)

summary1 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This plot compares the company’s revenue and net income over the years.\nIt helps identify profitability trends and assess financial performance.", hjust = 0.5, size = 5) +
  theme_void()

print(summary1)

# Plot showing Assets vs Total Liabilities over the years
p2 <- ggplot(finance, aes(x = years)) +
  geom_line(aes(y = assets, color = "Assets")) +
  geom_line(aes(y = total_liabilities, color = "Total Liabilities")) +
  labs(title = "Assets vs Total Liabilities", 
       x = "Years", y = "Amount") +
  scale_color_manual(name = "Metrics", values = c("Assets" = "red", "Total Liabilities" = "orange")) +
  theme_minimal()

print(p2)

summary2 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This plot shows how the company's assets and liabilities evolved over time.\nIt provides insight into financial stability and risk exposure.", hjust = 0.5, size = 5) +
  theme_void()

print(summary2)

# Plot showing Average Stock Price over the years
p3 <- ggplot(stock, aes(x = years, y = Avg_Stock_Price)) +
  geom_line(color = "purple") +
  labs(title = "Average Stock Price Over Years", 
       x = "Years", y = "Average Stock Price") +
  theme_minimal()

print(p3)

summary3 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This plot tracks the average stock price of the company across years,\nreflecting investor confidence and market perception.", hjust = 0.5, size = 5) +
  theme_void()

print(summary3)

# Plot showing the number of employees over the years
p4 <- ggplot(emp_count, aes(x = years, y = employees_number)) +
  geom_line(color = "brown") +
  labs(title = "Number of Employees Over Years", 
       x = "Years", y = "Employees Number") +
  theme_minimal()

print(p4)

summary4 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This plot shows workforce growth.\nIncreasing employee numbers often indicate expansion and investment in human capital.", hjust = 0.5, size = 4) +
  theme_void()

print(summary4)

# 2. Company Status Plots

# Scatter Plot to show the difference between active and defunct companies
p5 <- ggplot(Status, aes(x = foundation_year, y = closing_year, color = status)) +
  geom_point() +
  labs(title = "Active vs Defunct Companies by Foundation and Closing Year", 
       x = "Foundation Year", y = "Closing Year") +
  scale_color_manual(values = c("active" = "green", "defunct" = "red")) +
  theme_minimal()

print(p5)

summary5 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This scatter plot contrasts active and defunct companies by their founding and closing years.\nUseful to detect business longevity and failure trends.", hjust = 0.5, size = 4) +
  theme_void()

print(summary5)

# Pie Chart to show the proportion of active vs defunct companies
p6 <- Status %>%
  count(status) %>%
  ggplot(aes(x = "", y = n, fill = status)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Proportion of Active vs Defunct Companies") +
  scale_fill_manual(values = c("active" = "green", "defunct" = "red")) +
  theme_void()

print(p6)

summary6 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This pie chart shows the ratio of active to defunct companies,\noffering a quick overview of business survival.", hjust = 0.5, size = 5) +
  theme_void()

print(summary6)

# Histogram to show the distribution of companies by foundation year
p7 <- ggplot(Status, aes(x = foundation_year, fill = status)) +
  geom_histogram(binwidth = 1, position = "dodge", color = "black") +
  labs(title = "Distribution of Companies by Foundation Year", 
       x = "Foundation Year", y = "Count of Companies") +
  scale_fill_manual(values = c("active" = "green", "defunct" = "red")) +
  theme_minimal()

print(p7)

summary7 <- ggplot() +
  annotate("text", x = 0.5, y = 0.5, label = "This histogram reveals the frequency of company foundations over time,\nhelping spot peaks in entrepreneurship.", hjust = 0.5, size = 5) +
  theme_void()

print(summary7)

# Close the PDF file after saving all the plots
dev.off()



# -------------- Statistics Visualizations ---------------------


# saving statistics plots as pdf
pdf("D:/Data Analysis/Company_Analysis_Project/plots/project_plots_and_statistics.pdf", 
    width = 15, height = 10) # Set PDF size to avoid cropping

# Load required libraries
library(ggplot2)
library(dplyr)
library(gridExtra)

# 1. Financial Plot: Revenue vs Net Income over the years
p <- ggplot(finance, aes(x = years)) + 
  geom_line(aes(y = revenue, color = "Revenue")) +
  geom_line(aes(y = net_income, color = "Net Income")) +
  labs(title = "Revenue vs Net Income Over Years", 
       x = "Years", y = "Amount") +
  scale_color_manual(name = "Metrics", values = c("Revenue" = "blue", "Net Income" = "green")) +
  theme_minimal() +
  theme(plot.margin = margin(10, 10, 10, 10)) +  # Add margin to avoid cropping
  scale_x_continuous(expand = c(0.01, 0)) +       # Tiny padding on x-axis
  scale_y_continuous(expand = c(0.01, 0))         # Tiny padding on y-axis

# Print the plot into the opened PDF
print(p)

# 2. Statistical Analysis

# 1. Descriptive Statistics
library(gridExtra)

summary_stats <- finance %>%
  summarise(
    Mean_Revenue = mean(revenue, na.rm = TRUE),
    SD_Revenue = sd(revenue, na.rm = TRUE),
    Mean_Income = mean(net_income, na.rm = TRUE),
    SD_Income = sd(net_income, na.rm = TRUE),
    Mean_Assets = mean(assets, na.rm = TRUE),
    SD_Assets = sd(assets, na.rm = TRUE),
    Mean_Liabilities = mean(total_liabilities, na.rm = TRUE),
    SD_Liabilities = sd(total_liabilities, na.rm = TRUE)
  )

# Display as table in PDF
print(gridExtra::grid.table(summary_stats))


# 2. Correlation Analysis
cor_val <- cor(finance$revenue, finance$net_income, use = "complete.obs")

# Display correlation result in a plot
cor_text_plot <- ggplot() +
  annotate("text", x = 1, y = 1, 
           label = paste("Correlation between Revenue and Net Income:\n", round(cor_val, 2)), 
           size = 6) +
  theme_void()

print(cor_text_plot)


# 3. Linear Regression: net_income ~ revenue
lm_model <- lm(net_income ~ revenue, data = finance)

# Regression summary text as a plot (simplified output)
reg_summary <- summary(lm_model)
reg_text <- paste0(
  "Linear Regression:\n",
  "Intercept: ", round(reg_summary$coefficients[1,1], 2), "\n",
  "Slope: ", round(reg_summary$coefficients[2,1], 2), "\n",
  "R-squared: ", round(reg_summary$r.squared, 2), "\n",
  "p-value: ", signif(reg_summary$coefficients[2,4], 3)
)

reg_text_plot <- ggplot() +
  annotate("text", x = 1, y = 1, label = reg_text, size = 5, hjust = 0) +
  theme_void()

print(reg_text_plot)

# 4. Regression line plot
reg_line_plot <- ggplot(finance, aes(x = revenue, y = net_income)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Linear Regression: Revenue vs Net Income", 
       x = "Revenue", y = "Net Income") +
  theme_minimal()

print(reg_line_plot)

# === Close the PDF device when finished ===
dev.off()

