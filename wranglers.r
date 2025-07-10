setwd("C:/Users/profe/Desktop/Ironhack/praxis")
superstore <- read.csv("Sample - Superstore.csv")

# View structure of the dataset
str(superstore)

# View first few rows
head(superstore)

# View statistical summary
summary(superstore)

# Get number of rows and columns
dim(superstore)  # Returns: [rows, columns]

# Alternatively:
nrow(superstore)  # Number of rows
ncol(superstore)  # Number of columns

# 2
superstore <- read.csv("Sample - Superstore.csv")
library(dplyr)  # Load the dplyr package for data manipulation

result <- superstore %>%
# 1. Select specific columns
select(`Order.ID`, `Order.Date`, `Customer.Name`, Sales, Profit) %>%
# 2. Filter for profits > $100
filter(Profit > 100) %>%

# 3. Sort by Sales in descending order
arrange(desc(Sales))

# View the first few rows of the final output
head(result)

# View the structure
str(result)

# Get dimensions
dim(result)

# step 3

# Check NA counts per column
missing_counts <- colSums(is.na(superstore))
print("Missing values per column:")
print(missing_counts)

# Visual Pres
cat("\nMissing value summary:\n")
print(summary(is.na(superstore)))

# Calculate mode function
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Replace NAs in Postal.Code
postal_mode <- get_mode(superstore$Postal.Code)
superstore$Postal.Code <- ifelse(
    is.na(superstore$Postal.Code),
    mode(superstore$Postal.Code),
    superstore$Postal.Code
    )


# Verification
cat("\nPostal Code handling results:\n")
cat("- Mode value used:", postal_mode, "\n")
cat("- Remaining NAs in Postal.Code:", sum(is.na(superstore$Postal.Code)), "\n")

# Before removal
initial_rows <- nrow(superstore)
cat("\nRow removal summary:\n")
cat("- Initial rows:", initial_rows, "\n")

# Remove NA in Customer.Name
superstore_clean <- superstore[complete.cases(superstore$Customer.Name), ]

# After removal
remaining_rows <- nrow(superstore_clean)
cat("- Rows after cleaning:", remaining_rows, "\n")
cat("- Rows removed:", initial_rows - remaining_rows, "\n")

# Final missing value check
cat("\nFinal NA counts:\n")
print(colSums(is.na(superstore_clean)))

# Step 4
# Load required libraries
library(dplyr)
library(lubridate)

# Load the CSV file
superstore <- read.csv("Sample - Superstore.csv", stringsAsFactors = FALSE)

# Convert Order Date to Date type (assuming format is mm/dd/yyyy)
superstore$Order.Date <- as.Date(superstore$Order.Date, format = "%m/%d/%Y")

# Create Profit_Margin column (Profit divided by Sales)
superstore <- superstore %>%
  mutate(Profit_Margin = Profit / Sales)

# Create Order_Year column by extracting year from Order Date
superstore <- superstore %>%
  mutate(Order_Year = year(Order.Date))


# Step 5 - Aggregating and Summarizing Data
library(dplyr)
library(lubridate)

# Load the data
superstore <- read.csv("Sample - Superstore.csv", stringsAsFactors = FALSE)

# Convert Order Date to Date format
superstore$Order.Date <- as.Date(superstore$Order.Date, format = "%m/%d/%Y")

# Create Profit_Margin column
superstore <- superstore %>%
  mutate(Profit_Margin = Profit / Sales)
