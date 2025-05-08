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

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Step 1: Read File
companiesData <- read.csv("D:/Data Analysis/Company_Analysis_Project/Data/companies_data.csv")
str(companiesData)

#create a unique names column
company_ids <- companiesData %>%
  distinct(Company_Name) %>%
  mutate(Company_ID = row_number())

#create id for unique names
companiesData <- companiesData %>%
  left_join(company_ids, by = "Company_Name")

#change columns arrange
companiesData <- companiesData %>% select(Company_ID, everything())

#changing data type
convertDataType <- c("Revenue", "Net_Income", "Assets", "long_Term_Debt",
                     "Total_Liabilities", "Holders_Equity", "Avg_Stock_Price",
                     "Avg_TTM_Net_EPS", "Avg_PE_Ratio")

# clean and convert columns into numeric
companiesData <- companiesData %>%
  mutate(across(all_of(convertDataType), ~ as.numeric(str_replace_all(., 
                                                                      c("//$" = "", "," = "", "//(" = "-", "//)" = "", "//s+" = "")))))

companiesData <- companiesData %>%
  mutate(across(all_of(convertDataType), ~ replace_na(
    as.numeric(str_replace_all(., 
                               c("//$" = "", "," = "", "//(" = "-", "//)" = "", "//s+" = ""))), 0)))

companiesData <- companiesData %>%
  rename(Dynamic_Duration = Dynamic.Duration)

companiesData <- companiesData %>%
  rename(Current_Status = Currect_Status)

# remove unprintable characters 
companiesData$Industries <- stri_replace_all_fixed(companiesData$Industries, "�", "")

# find rows with non printable characters 
bad_rows <- grep("�", companiesData$Industries)
print(bad_rows)

companiesData$Industries <- iconv(companiesData$Industries, from = "", to = "UTF-8", sub = "")

table(companiesData$Currect_Status)

str(companiesData)
names(companiesData)
View(companiesData)



# ----------------------------------------------------------------------------------------------------------------------


write.csv(companiesData, "D:/Data Analysis/Company_Analysis_Project/Data/companiesDataCleaned.csv", row.names = FALSE)

