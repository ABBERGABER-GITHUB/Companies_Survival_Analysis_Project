# Load necessary libraries
library(gridExtra)
library(caret)
library(randomForest)
library(GGally)
library(corrplot)
library(tidyverse)
library(ggplot2)
library(ggcorrplot)
library(openxlsx)
library(readxl)
library(janitor)
library(dplyr)
library(readr)
library(lubridate)
library(stringr)
library(tidyr)
library(stringi)

# Load cleaned companies data
companiesData <- read.csv("D:/Data Analysis/Company_Analysis_Project/Data/companiesDataCleaned.csv")

# Check the structure and column names
names(companiesData)
str(companiesData)

# Open PDF device to save the plots
pdf(file = "D:/Data Analysis/Company_Analysis_Project/Visuals/Company_Analysis_Plots.pdf", width = 8, height = 6)

# --- Company Status Prediction Model (Active, Defunct, Re-Opened) ---
industry_status_summary <- companiesData %>%
  group_by(Industries, Current_Status) %>%
  summarise(Count = n(), .groups = 'drop')

# Create plot for Company Status by Industry
industry_status_plot <- ggplot(industry_status_summary, aes(x = reorder(Industries, -Count), y = Count, fill = Current_Status)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip() + 
  labs(title = "Company Status by Industry", x = "Industries", y = "Count") +
  scale_fill_manual(values = c("Active" = "green", "Defunct" = "red", "Re-Opened" = "blue")) +
  theme_minimal()

# Print to PDF
print(industry_status_plot)

# --- Average Revenue and Net Income by Industry ---
industry_summary <- companiesData %>%
  group_by(Industries) %>%
  summarise(
    Avg_Revenue = mean(Revenue, na.rm = TRUE),
    Avg_Income = mean(Net_Income, na.rm = TRUE),
    Avg_Duration = mean(Dynamic_Duration, na.rm = TRUE),
    Company_Count = n()
  ) %>%
  arrange(desc(Avg_Revenue))

# Reshape the data into long format for better handling in ggplot
industry_finance_long <- industry_summary %>%
  pivot_longer(cols = c(Avg_Revenue, Avg_Income), names_to = "Metric", values_to = "Value")

# Create the plot for Average Revenue and Net Income by Industry
industry_plot <- ggplot(industry_finance_long, aes(x = reorder(Industries, Value), y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip() +
  labs(title = "Average Revenue and Net Income by Industry", x = "Industry", y = "Amount") +
  scale_fill_manual(values = c("Avg_Revenue" = "blue", "Avg_Income" = "green")) +
  theme_minimal()

# Print to PDF
print(industry_plot)

# --- Company Lifespan (Dynamic Duration) by Industry ---
duration_plot <- ggplot(companiesData, aes(x = reorder(Industries, Dynamic_Duration, FUN = median), y = Dynamic_Duration)) +
  geom_boxplot(fill = "skyblue") +
  coord_flip() +
  labs(title = "Company Lifespan by Industry", x = "Industries", y = "Dynamic Duration (Years)") +
  theme_minimal()

# Print to PDF
print(duration_plot)

# --- Correlation Analysis ---
num_data <- companiesData %>%
  select_if(is.numeric) %>%
  drop_na()

# Calculate correlation matrix
cor_matrix <- cor(num_data)

# Plot the correlation matrix
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.7, title = "Correlation Matrix", mar = c(0,0,1,0))

# Print to PDF
grid.newpage()
grid.text("Correlation Matrix", y = 0.95, gp = gpar(fontsize = 16, fontface = "bold"))

# --- Linear Regression Model for Net Income Prediction ---
lm_model <- lm(Net_Income ~ Revenue + Assets + Total_Liabilities + Dynamic_Duration + Industries, data = companiesData)
summary(lm_model)

# --- Random Forest Classification Model to Predict Company Status ---
classification_data <- companiesData %>%
  select(Current_Status, Revenue, Net_Income, Assets, Total_Liabilities, Dynamic_Duration, Industries) %>%
  drop_na()

classification_data$Current_Status <- as.factor(classification_data$Current_Status)
classification_data$Industries <- as.factor(classification_data$Industries)

# Split the data into training and test sets
set.seed(123)
splitIndex <- createDataPartition(classification_data$Current_Status, p = 0.7, list = FALSE)
train_data <- classification_data[splitIndex, ]
test_data <- classification_data[-splitIndex, ]

# Train the Random Forest model
rf_model <- randomForest(Current_Status ~ ., data = train_data, importance = TRUE)

# Make predictions on the test data
pred <- predict(rf_model, newdata = test_data)

# Display the confusion matrix
confusionMatrix(pred, test_data$Current_Status)

# Display variable importance plot
varImpPlot(rf_model, main = "Variable Importance - Random Forest")

# --- Additional Analysis ---

# Average Revenue and Net Income by Industry
industry_finance <- companiesData %>%
  group_by(Industries) %>%
  summarise(Avg_Revenue = mean(Revenue, na.rm = TRUE),
            Avg_Net_Income = mean(Net_Income, na.rm = TRUE)) %>%
  arrange(desc(Avg_Revenue))

# Reshape the data into long format for better handling in ggplot
industry_finance_long <- industry_finance %>%
  pivot_longer(cols = c(Avg_Revenue, Avg_Net_Income), 
               names_to = "Metric", values_to = "Value")

# Create the plot for Average Revenue and Net Income by Industry
ggplot(industry_finance_long, aes(x = reorder(Industries, Value), y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip() +
  labs(title = "Average Revenue and Net Income by Industry", x = "Industry", y = "Amount") +
  scale_fill_manual(values = c("Avg_Revenue" = "blue", "Avg_Net_Income" = "green")) +
  theme_minimal()

# Print to PDF
grid.newpage()

# Company Survival Analysis (Lifespan by Industry)
survival_analysis <- companiesData %>%
  distinct(Company_Name, .keep_all = TRUE) %>%
  group_by(Industries) %>%
  summarise(Avg_Duration = mean(Dynamic_Duration, na.rm = TRUE),
            Count = n()) %>%
  arrange(desc(Avg_Duration))

# Create plot for Average Duration by Industry
ggplot(survival_analysis, aes(x = reorder(Industries, Avg_Duration), y = Avg_Duration)) +
  geom_col(fill = "darkorange") +
  coord_flip() +
  labs(title = "Average Company Lifespan by Industry", x = "Industry", y = "Average Duration (Years)") +
  theme_minimal()

# Print to PDF
dev.off()  # Close the PDF device to save the file
