install.packages("tidyverse")
library(tidyverse)
library(dplyr)

#Data Wrangling with R

# Step 1: Load and Explore the Dataset
superstore <- read.csv("C:/Users/makwe/Downloads/Sample - Superstore.csv")
View(superstore)

#Explore the dataset using str(), head(), and summary().

head(superstore)
str(superstore)
summary(superstore)

# Identify the number of rows and columns.

nrow(superstore)
ncol(superstore)

# Step 2: Basic Data Manipulation
# Select the following columns: Order ID, Order Date, Customer Name, Sales, Profit.

selected_cols <- superstore[, c("Order.ID", "Order.Date", "Customer.Name", "Sales", "Profit")]

View(selected_cols)

# Filter the dataset to show only orders with a profit greater than $100.

filtered_profit <- superstore[superstore$Profit > 100, ]

View(filtered_profit)

# Sort the dataset by Sales in descending order

sort_sales <- superstore[order(superstore$Sales, decreasing = TRUE), ]

View(sort_sales)

# Step 3: Handle Missing Data

# Check for missing values in the dataset.

# Replace missing values in the Postal Code column with the mode (most frequent value).

sum(is.na(superstore))
colSums(is.na(superstore))

grouped_plz <- superstore %>%
  group_by(`Postal.Code`) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) 

postal_mode <- grouped_plz$`Postal.Code`[1]
postal_mode

superstore$Postal.Code[is.na(superstore$Postal.Code)] <- postal_mode

# Remove rows with missing values in the Customer Name column.

superstore <- superstore[!is.na(superstore$Customer.Name), ]

# Step 4: Create and Modify Columns
# Create a new column Profit_Margin as the ratio of Profit to Sales.

superstore$Profit_Margin <- superstore$Profit / superstore$Sales
head(superstore[, c("Sales", "Profit", "Profit_Margin")])

# Create a new column Order_Year by extracting the year from Order Date.

superstore$Order.Date <- as.Date(superstore$Order.Date, format = "%m/%d/%Y")
superstore$Order_Year <- format(superstore$Order.Date, "%Y")

head(superstore[, c("Order.Date", "Order_Year")])

# Convert the Order.Date column to a Date data type.

superstore$Order.Date <- as.Date(superstore$Order.Date, format = "%m/%d/%Y")
str(superstore$Order.Date)
head(superstore$Order.Date)

# Step 5: Aggregating and Summarizing Data
# Calculate the total sales and profit by Category.


sales_profits <- superstore %>%
  group_by(Category) %>%
  summarise(
    Total_Sales = sum(Sales),
    Total_Profit = sum(Profit)
  )

sales_profits

# Find the average profit margin by Region.

avg_profits <- superstore %>%
  group_by(Region) %>%
  summarise(
    Avg_Profit_Margin = mean(Profit_Margin, na.rm = TRUE)
  )

avg_profits


# Count the number of orders by Customer Segment.

orders_by_segment <- superstore %>%
  group_by(Segment) %>%
  summarise(Number_of_Orders = n())

orders_by_segment

