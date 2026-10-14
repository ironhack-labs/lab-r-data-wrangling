### ============================================================
### Lab | Data Wrangling with R
### Dataset: Sample - Superstore.csv
### ============================================================

# Install packages if needed (run once)
# install.packages("dplyr")
# install.packages("ggplot2")

library(dplyr)
library(ggplot2)


### ========= Step 1: Load and Explore the Dataset =========

# 1. Load the dataset into R.
superstore <- read.csv("Sample - Superstore.csv", stringsAsFactors = FALSE)

# 2. Explore the dataset using str(), head(), and summary().
str(superstore)
head(superstore)
summary(superstore)

# 3. Identify the number of rows and columns.
nrow(superstore)   # number of rows
ncol(superstore)   # number of columns
dim(superstore)    # both at once


### ========= Step 2: Basic Data Manipulation =========

# 1. Select the following columns:
#    Order ID, Order Date, Customer Name, Sales, Profit.
selected_data <- superstore[, c("Order.ID", "Order.Date", "Customer.Name", "Sales", "Profit")]

# 2. Filter the dataset to show only orders with a profit greater than $100.
profit_over_100 <- selected_data[selected_data$Profit > 100, ]

# 3. Sort the dataset by Sales in descending order.
sorted_data <- profit_over_100[order(profit_over_100$Sales, decreasing = TRUE), ]

# Preview
head(sorted_data)


### ========= Step 3: Handle Missing Data =========

# 1. Check for missing values in the dataset.
colSums(is.na(superstore))

# 2. Replace missing values in the Postal Code column with the mode
#    (most frequent value).

# Function to calculate the mode
get_mode <- function(x) {
  ux <- unique(x[!is.na(x)])
  ux[which.max(tabulate(match(x, ux)))]
}

mode_postal <- get_mode(superstore$Postal.Code)
mode_postal

superstore$Postal.Code[is.na(superstore$Postal.Code)] <- mode_postal

# Verify no more NAs in Postal.Code
sum(is.na(superstore$Postal.Code))

# 3. Remove rows with missing values in the Customer Name column.
superstore <- superstore[!is.na(superstore$Customer.Name), ]

# Verify
sum(is.na(superstore$Customer.Name))


### ========= Step 4: Create and Modify Columns =========

# 3. Convert the Order.Date column to a Date data type first
#    (must be done BEFORE extracting year).
superstore$Order.Date <- as.Date(superstore$Order.Date, format = "%m/%d/%Y")

# 1. Create a new column Profit_Margin as the ratio of Profit to Sales.
superstore$Profit_Margin <- superstore$Profit / superstore$Sales

# 2. Create a new column Order_Year by extracting the year from Order Date.
superstore$Order_Year <- format(superstore$Order.Date, "%Y")

# (Optional) also convert Ship.Date if you plan to use it later
superstore$Ship.Date <- as.Date(superstore$Ship.Date, format = "%m/%d/%Y")

# Preview
head(superstore[, c("Order.Date", "Order_Year", "Profit_Margin")])


### ========= Step 5: Aggregating and Summarizing Data =========

# 1. Calculate the total sales and profit by Category.
aggregate(cbind(Sales, Profit) ~ Category, data = superstore, sum)

# 2. Find the average profit margin by Region.
aggregate(Profit_Margin ~ Region, data = superstore, mean)

# 3. Count the number of orders by Customer Segment.
aggregate(Order.ID ~ Segment, data = superstore, length)


### ============================================================
### Optional — Extra 1: Advanced Challenges
### ============================================================

# 1. Identify and remove duplicate rows based on Order ID.
duplicated_orders <- superstore[duplicated(superstore$Order.ID), ]
nrow(duplicated_orders)

# Keep only the first occurrence of each Order ID
superstore_dedup <- superstore[!duplicated(superstore$Order.ID), ]
nrow(superstore_dedup)

# Note: this is destructive — in a real scenario you'd decide which
# duplicate to keep based on business rules. We keep the first.

# 2. Create a new column Discount_Level:
#    "Low" (<10%), "Medium" (10-20%), "High" (>20%).
superstore$Discount_Level <- ifelse(
  superstore$Discount < 0.10, "Low",
  ifelse(superstore$Discount <= 0.20, "Medium", "High")
)

# Preview counts
table(superstore$Discount_Level)

# 3. Merge the dataset with a new dataset containing regional population data
#    (dummy dataset).
region_population <- data.frame(
  Region = c("East", "West", "Central", "South"),
  Population = c(56000000, 78000000, 42000000, 62000000)
)

superstore_merged <- merge(superstore, region_population, by = "Region", all.x = TRUE)

# Preview
head(superstore_merged[, c("Region", "Population", "Sales", "Profit")])


### ============================================================
### Optional — Extra 2: Data Visualization
### ============================================================

# 1. Bar plot of total sales by Category.
sales_by_category <- aggregate(Sales ~ Category, data = superstore, sum)

ggplot(sales_by_category, aes(x = Category, y = Sales, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Sales by Category", x = "Category", y = "Total Sales") +
  theme_minimal()

# 2. Scatter plot of Sales vs. Profit with a trend line.
ggplot(superstore, aes(x = Sales, y = Profit)) +
  geom_point(alpha = 0.4, color = "steelblue") +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(title = "Sales vs. Profit", x = "Sales", y = "Profit") +
  theme_minimal()

# 3. Histogram of Profit_Margin.
ggplot(superstore, aes(x = Profit_Margin)) +
  geom_histogram(bins = 50, fill = "darkgreen", color = "white") +
  labs(title = "Distribution of Profit Margin", x = "Profit Margin", y = "Count") +
  theme_minimal()