library(tidyverse)
library(ggplot2)
library(ggcorrplot)
library(openxlsx)
library(readxl)
library(janitor)
library(dplyr)
library(readr)
library(lubridate)
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Step 1: Read File
company_merged_data <- read.csv("D:/Data Analysis/Company_Analysis_Project/company_data_merged.csv",na.strings = "N/A" ,stringsAsFactors = FALSE)

company_merged_data[ , (ncol(company_merged_data)-9):ncol(company_merged_data)] <- 
  lapply(company_merged_data[ , (ncol(company_merged_data)-9):ncol(company_merged_data)], function(x) {
    x_num <- as.numeric(gsub("[\\$,\\(\\)\\s]", "", x)) * ifelse(grepl("\\(", x), -1, 1)
    x_num[is.na(x_num)] <- 0
    return(x_num)
  })

# --- Company Status Prediction Model (3 Classes: Active, Defunct, Re-Opened) ---

# Load necessary libraries
library(caret)
library(randomForest)

# Prepare the data
model_data <- company_mergedData %>%
  filter(Current_Status %in% c("Active", "Defunct", "Re-Opened")) %>%
  mutate(Status_Class = as.factor(Current_Status)) %>%
  select(Status_Class, Foundation_Year, Closing_Year, Duration, Employee_Number,
         Revenue, Net_Income, Assets, long_Term_Debt, Total_Liabilities,
         Holders_Equity, Avg_Stock_Price, Avg_TTM_Net_EPS, Avg_PE_Ratio) %>%
  drop_na()  # Remove rows with missing financial data

# Train-test split
set.seed(42)
trainIndex <- createDataPartition(model_data$Status_Class, p = 0.8, list = FALSE)
train <- model_data[trainIndex, ]
test <- model_data[-trainIndex, ]

# Train Random Forest Model
rf_model <- randomForest(Status_Class ~ ., data = train, ntree = 300, importance = TRUE)

# Predict on test set
test$Prediction <- predict(rf_model, newdata = test)

# Evaluate model performance
confusionMatrix(test$Prediction, test$Status_Class)

# Feature Importance Plot
varImpPlot(rf_model)

# --- Optional: Predict New Companies ---
# Example: Predict status for a new company (replace values with real ones)
 new_company <- data.frame(
   Foundation_Year = 2015,
   Closing_Year = NA,
   Duration = 9,
   Employee_Number = 150,
   Revenue = 5000000,
   Net_Income = 500000,
   Assets = 20000000,
   long_Term_Debt = 1000000,
   Total_Liabilities = 3000000,
   Holders_Equity = 17000000,
   Avg_Stock_Price = 50,
   Avg_TTM_Net_EPS = 2.5,
   Avg_PE_Ratio = 20
 )

 prediction <- predict(rf_model, newdata = new_company)
 print(prediction)


names(company_merged_data)
str(company_merged_data)
View(company_merged_data)
write.csv(company_merged_data,"D:/Data Analysis/Company_Analysis_Project/companies_mergedData.csv")


