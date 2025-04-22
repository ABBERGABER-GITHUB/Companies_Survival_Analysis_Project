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
stock <- read.csv("D:/Data Analysis/CompanyAnalysisProject/SQL/stockAnalysisCleaned.csv" ,na.strings = "N/A" ,stringsAsFactors = FALSE)
# Step 2: Clean column names (remove leading/trailing spaces)
names(stock) <- trimws(names(stock))
colnames(stock)[colnames(stock) == "year"] <- "years"
# Step 3: Convert 'Date' column to proper date format
# Step 4: check unique values 
unique(stock$year)
#step 5: extract the year from the dates  
stock$year <- gsub(".*([0-9]{4})$", "//1", stock$year)  
# Step 6: convert column into numeric
stock$year <- as.numeric(stock$year)
# Step 7: check for NA's
if (any(is.na(stock$year))) {
  warning("there is unconverted values in the column")
  print(stock[is.na(stock$year), ])  # عرض الصفوف التي تحتوي على NA
}
# Step 8: show unique values
unique(stock$year)
# Step 9: Clean 'stock_price' column (remove $ and convert to numeric)
stock$Avg_Stock_Price <- as.numeric(gsub("[$]", "", trimws(stock$Avg_Stock_Price)))
# Step 10: Clean 'TTM_Net_EPS' column (convert parentheses to negative numbers)
stock$Avg_TTM_Net_EPS <- as.numeric(gsub("[$]", "", trimws(stock$Avg_TTM_Net_EPS)))
# Step 11: Clean 'PE_Ratio' column (same treatment as prices if needed)
stock$PE_Ratio <- as.numeric(gsub("[$]", "", trimws(stock$PE_Ratio)))
stock$PE_Ratio <- round(stock$PE_Ratio, 2)
# Step 12: (Optional): Check summary to make sure all looks good
Stocksummary <- summary(stock)
write.csv(stock,"D:/Data Analysis/Company_Analysis_Project/data/stock_cleaned.csv" )
write.csv(Stocksummary,"D:/Data Analysis/Company_Analysis_Project/data/stock_Summary.csv" )
names(stock)
str(stock)
view(stock)

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#cleaning company status file
#step 1: Read file
Status <- read.csv("D:/Data Analysis/CompanyAnalysisProject/SQL/companyStatusCleaned.csv" ,na.strings = "N/A" ,stringsAsFactors = FALSE)
# Step 2: Clean column names (remove leading/trailing spaces)
Status <- clean_names(Status)
# Step 2: Clean column names (remove leading/trailing spaces)
names(Status) <- trimws(names(Status))
# Step 3: Convert 'foundation year' column to proper date format
unique(Status$foundation_year)
#step 4: extract the year from the dates  
Status$foundation_year <- gsub(".*([0-9]{4})$", "//1", Status$foundation_year)  
# Step 5: convert column into numeric
Status$foundation_year <- as.numeric(Status$foundation_year)
# Step 6: check for NA's
if (any(is.na(Status$foundation_year))) {
  warning("there is unconverted values in the column")
  print(stock[is.na(Status$foundation_year), ])  # عرض الصفوف التي تحتوي على NA
}
# Step 7: show unique values
unique(Status$foundation_year)
#Step 8:convert closing year column to proper date format
unique(Status$closing_year)
#step 9: extract the year from the dates  
Status$closing_year <- gsub(".*([0-9]{4})$", "//1", Status$closing_year)  
# Step 10: convert column into numeric
Status$closing_year <- as.numeric(Status$closing_year)
# Step 11: check for NA's
if (any(is.na(Status$closing_year))) {
  warning("there is unconverted values in the column")
  print(stock[is.na(Status$closing_year), ])  # عرض الصفوف التي تحتوي على NA
}
# Step 12: show closing_year unique values
unique(Status$closing_year)
str(Status)
names(Status)
# Step 13: Clean 'duration' column and convert to numeric
unique(Status$duration)
# أولًا نحول القيم غير الرقمية لـ NA
# Step 14: Remove extra spaces in column names
names(Status) <- trimws(names(Status))
# Step 15: Convert 'status' column to factor
Status$status <- as.factor(Status$status)
Status$duration_numeric <- as.numeric(ifelse(Status$duration == "Still Active", NA, Status$duration))
Status$duration[is.na(Status$duration)] <- "Still Active"
names(Status)
head(Status)
view(Status)
str(Status)
Status_Sammary <- summary(Status)
write.csv(Status,"D:/Data Analysis/Company_Analysis_Project/data/status_cleaned.csv" )
write.csv(Status_Sammary,"D:/Data Analysis/Company_Analysis_Project/data/Status_Sammary.csv" )

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#cleaning financial Data file
# Step 1: Read the CSV file and replace "N/A" with NA
finance <- read.csv("D:/Data Analysis/CompanyAnalysisProject/SQL/financialDataCleaned.csv", na.strings = "N/A")
finance <- janitor::clean_names(finance)
names(finance) <- trimws(names(finance))  # Remove leading/trailing spaces
# Step 2: Define function to clean and convert financial values
clean_and_round_column <- function(x) {
  # Remove $ and , and spaces
  x <- gsub("[$, ]", "", x)
  # Convert (123) to -123
  x <- gsub("//(([^)]+)//)", "-//1", x)
  # Convert to numeric
  x <- as.numeric(x)
  # Replace NA with 0
  x[is.na(x)] <- 0
  # Round
  round(x, 2)
}
# Step 3: Clean all financial columns
finance$revenue            <- clean_and_round_column(finance$revenue)
finance$assets             <- clean_and_round_column(finance$assets)
finance$total_liabilities  <- clean_and_round_column(finance$total_liabilities)
finance$holders_equity     <- clean_and_round_column(finance$holders_equity)
finance$net_income         <- clean_and_round_column(finance$net_income)
finance$long_term_debt     <- clean_and_round_column(finance$long_term_debt)
# Step 4: Extract year from "years" column
finance$years <- gsub(".*([0-9]{4})$", "//1", finance$years)
finance$years <- as.numeric(finance$years)
finance_summary <- summary(finance)
names(finance)
head(finance)
view(finance)
str(finance)
# Step 5: Save cleaned file
write.csv(finance,"D:/Data Analysis/Company_Analysis_Project/data/finance_cleaned.csv", row.names = FALSE )
write.csv(finance_summary,"D:/Data Analysis/Company_Analysis_Project/data/finance_summary.csv" )

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Step 1: cleaning employee count file
emp_count <- read.csv("D:/Data Analysis/CompanyAnalysisProject/SQL/employeeCountCleaned.csv" ,na.strings = "N/A")
head(emp_count)
emp_count <- clean_names(emp_count)
# Step 2: convert years column into date type
unique(emp_count$years)
# step 3: extract the year from the dates  
emp_count$years <- gsub(".*([0-9]{4})$", "//1", emp_count$years)  
# Step 4: convert column into numeric
emp_count$years <- as.numeric(emp_count$years)
# Step 5: check for NA's
if (any(is.na(emp_count$years))) {
  warning("there is unconverted values in the column")
  print(emp_count[is.na(emp_count$years), ])  # عرض الصفوف التي تحتوي على NA
}
# Step 6: show emp_count$years unique values
unique(emp_count$years)
# Step 7: convert employees_number column into numeric 
clean_employees_count <- function(x) {
  # remove spaces and separators only
  x <- gsub(",", "", x)  # remove separators
  x <- trimws(x)         # remove extra spaces
  as.numeric(x)          # convert to numeric
}
# Step 8: apply function
emp_count$employees_number <- clean_employees_count(emp_count$employees_number)
str(emp_count)
emp_count_summary <- summary(emp_count)
names(emp_count)
head(emp_count)
str(emp_count)
View(emp_count)
write.csv(emp_count,"D:/Data Analysis/Company_Analysis_Project/data/emp_count_cleaned.csv", row.names = FALSE)
write.csv(emp_count_summary,"D:/Data Analysis/Company_Analysis_Project/data/emp_count_summary.csv", row.names = FALSE)

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

