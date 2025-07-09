# Load necessary libraries
library(dplyr)
print('Load and Explore the Dataset')
print(strrep('-', 50))
# Set the working directory to the folder containing the CSV file
setwd("c:/Users/User/Desktop/Ironhack DS AI/week-8/lab-r-data-wrangling")

# Load the dataset
df <- read.csv("Sample - Superstore.csv")
# Display the first few rows of the dataframe
print('Head of the dataframe:')
print(strrep('-', 50))
print(head(df, n = 10))
print(strrep('-', 50))
# Display the structure of the dataframe
print('Structure of the dataframe:')
print(strrep('-', 50))
print(str(df))
print(strrep('-', 50))
# Display the summary statistics of the dataframe
print('Summary statistics of the dataframe:')
print(strrep('-', 50))
print(summary(df))
print(strrep('-', 50))
# Identify number of rows and columns
print('Number of rows and columns:')
print(strrep('-', 50))
print(paste("Number of rows:", nrow(df)))
print(paste("Number of columns:", ncol(df)))
print(strrep('-', 50))
print('Basic Data Manipulation')
print(strrep('-', 50))
print('Select, Filter, and Sort Data')
print(strrep('-', 50))
# Select the following columns: Order ID, Order Date, Customer Name, Sales and Profit
df_selected <- df %>%
    select(`Order.ID`, `Order.Date`, `Customer.Name`, `Sales`, `Profit`)
print(head(df_selected, n = 3))
print(strrep('-', 50))
# Filter the dataframe to include only orders with a Profit greater than 100
df_filtered <- df_selected %>%
    filter(Profit > 100)
print(head(df_filtered, n = 3))
print(strrep('-', 50))
# Sort the dataset by Sales in descending order
df_sorted <- df_filtered %>%
    arrange(desc(Sales))
print(head(df_sorted, n = 3))
print(strrep('-', 50))
print('Handle Missing Data')
print(strrep('-', 50))
# Check for missing values in the dataset 
missing_values <- colSums(is.na(df))
print('Missing values in each column:')
print(missing_values)
print(strrep('-', 50))
# Replace missing values in the Postal Code column with the mode (most frequent value)
mode_postal_code <- as.character(df$`Postal Code`[which.max(table(df$`Postal Code`))])
df$`Postal Code`[is.na(df$`Postal Code`)] <- mode_postal_code
print('Postal Code missing values replaced with mode:')
print(head(df$`Postal Code`, n = 3))
print(strrep('-', 50))
# Remove rows with missing values in the Customer Name column
df_cleaned <- df %>%
    filter(!is.na(`Customer.Name`))
print('Rows with missing Customer Name removed:')
print(head(df_cleaned, n = 3))
print(strrep('-', 50))
print('Create and Modify Columns')
print(strrep('-', 50))
# Create a new column Profit_Margin as the ratio of Profit to Sales
df_cleaned <- df_cleaned %>%
    mutate(Profit_Margin = Profit / Sales)
print('New column Profit_Margin created:')
print(head(df_cleaned, n = 3))
print(strrep('-', 50))
# Create a new column Order_Year by extracting the year from the Order Date
df_cleaned <- df_cleaned %>%
    mutate(Order_Year = as.numeric(format(as.Date(`Order.Date`, format="%m/%d/%Y"), "%Y")))
print('New column Order_Year created:')
print(head(df_cleaned, n = 3))
print(strrep('-', 50))
# Convert the Order Date to a Date object
df_cleaned$`Order.Date` <- as.Date(df_cleaned$`Order.Date`, format="%m/%d/%Y")
print('Order Date converted to Date object:')
print(head(df_cleaned$`Order.Date`, n = 3))
print(strrep('-', 50))
print('Aggregating and Summarizng Data')
print(strrep('-', 50))
# Calculate total sales and profit by Category
df_category_summary <- df_cleaned %>%
    group_by(Category) %>%
    summarize(Total_Sales = sum(Sales, na.rm = TRUE),
                Total_Profit = sum(Profit, na.rm = TRUE))
print('Total sales and profit by Category:')
print(head(df_category_summary, n = 3))
print(strrep('-', 50))
# Find the average profit margin by Region 
df_region_summary <- df_cleaned %>%
    group_by(Region) %>%
    summarize(Average_Profit_Margin = mean(Profit_Margin, na.rm = TRUE))
print('Average profit margin by Region:')
print(head(df_region_summary, n = 3))
print(strrep('-', 50))
# Count the number of orders by Customer segments 
df_segment_summary <- df_cleaned %>%
    group_by(Segment) %>%
    summarize(Order_Count = n())
print('Number of orders by Customer Segment:')
print(head(df_segment_summary, n = 3))
print(strrep('-', 50))