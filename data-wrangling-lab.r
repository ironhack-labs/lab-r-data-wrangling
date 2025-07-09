# 1. Load the dataset
# Adjust the path if your CSV lives elsewhere
superstore <- read.csv("Sample - Superstore.csv", stringsAsFactors = FALSE)

# 2. Explore the dataset
# a) Structure
str(superstore)

# b) First few rows
head(superstore)

# c) Summary statistics
summary(superstore)

# 3. Dimensions
cat("Number of rows: ", nrow(superstore), "\n")
cat("Number of columns: ", ncol(superstore), "\n")

library(dplyr)

# 1. Select specific columns
df_step2 <- superstore %>%
  select(`Order.ID`, `Order.Date`, `Customer.Name`, Sales, Profit)

  # 2. Filter for Profit > 100
df_step2 <- df_step2 %>%
  filter(Profit > 100)

  # 3. Sort by Sales descending
df_step2 <- df_step2 %>%
  arrange(desc(Sales))

  # Inspect the result
head(df_step2)

# 1. Check for missing values
missing_counts <- colSums(is.na(superstore))
print(missing_counts)

# 2. Replace missing Postal.Code with the mode
#   a) Compute the mode of Postal.Code
mode_postal <- superstore %>%
  filter(!is.na(Postal.Code)) %>%
  count(Postal.Code) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  pull(Postal.Code)

  #   b) Fill NAs with that mode
superstore <- superstore %>%
  mutate(
    Postal.Code = ifelse(
      is.na(Postal.Code),
      mode_postal,
      Postal.Code
    )
  )
# 3. Remove rows with missing Customer.Name
superstore <- superstore %>%
  filter(!is.na(Customer.Name) & Customer.Name != "")

# Verify
colSums(is.na(superstore))

library(lubridate)

# 3. Convert Order.Date to Date type (if it’s character in “mm/dd/yyyy” format)
superstore <- superstore %>%
  mutate(Order.Date = mdy(`Order.Date`)) %>%
  
  # 1. Create Profit_Margin
  mutate(Profit_Margin = Profit / Sales) %>%
  
  # 2. Extract Order_Year
  mutate(Order_Year = year(Order.Date))

# Inspect the new columns
head(superstore %>% 
       select(, Order.Date, Profit, Sales, Profit_Margin, Order_Year))

# 1. Total sales and profit by Category
category_summary <- superstore %>%
  group_by(Category) %>%
  summarize(
    total_sales  = sum(Sales,  na.rm = TRUE),
    total_profit = sum(Profit, na.rm = TRUE),
    .groups = "drop"
  )

# 2. Average profit margin by Region
region_margin <- superstore %>%
  group_by(Region) %>%
  summarize(
    avg_profit_margin = mean(Profit / Sales, na.rm = TRUE) * 100,
    .groups = "drop"
  )

# 3. Count of orders by Customer Segment
orders_by_segment <- superstore %>%
  group_by(Segment) %>%
  summarize(
    order_count = n(),
    .groups = "drop"
  )

# Inspect results
category_summary
region_margin
orders_by_segment       