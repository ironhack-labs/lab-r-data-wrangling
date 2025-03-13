# Lab | Data Wrangling with R

## Objective

Practice data wrangling, cleaning, and manipulation techniques in R using the Sample Super Store dataset. By the end of this activity, you should be able to:
  
  - Load and explore the dataset.
- Perform basic and advanced data manipulations.
- Handle missing data and duplicates.
- Aggregate and summarize data.
- Dataset Overview.

The Sample Super Store dataset contains sales, profit, and customer information for a retail store. It includes columns such as:
  
  - Order ID, Order Date, Ship Date
- Customer ID, Customer Name, Segment
- City, State, Region, Category, Sub-Category
- Sales, Quantity, Discount, Profit

## Instructions

library(dplyr)

### Step 1: Load and Explore the Dataset

1. Load the dataset into R.

superstore <- read.csv("C:\\Users\\fee10\\Ironhack\\Module2\\Labs\\lab-r-dataframes\\dataset\\Sample - Superstore.csv")

2. Explore the dataset using str(), head(), and summary().

str(superstore)
head(superstore)
summary(superstore)

3. Identify the number of rows and columns.

dim(superstore)

### Step 2: Basic Data Manipulation

1. Select the following columns: Order ID, Order Date, Customer Name, Sales, Profit.

selected_columns <- select(superstore, Order.ID, Order.Date, Customer.Name, Sales, Profit)

2. Filter the dataset to show only orders with a profit greater than $100.

profit_greater100 <- filter(superstore, Profit>=100)

3. Sort the dataset by Sales in descending order.

sorted_profit_greater100 <- profit_greater100 %>%
  arrange(desc(Sales))

### Step 3: Handle Missing Data

1. Check for missing values in the dataset.

colSums(is.na(superstore))


2. Replace missing values in the Postal Code column with the mode (most frequent value).
3. Remove rows with missing values in the Customer Name column.

### Step 4: Create and Modify Columns

1. Create a new column Profit_Margin as the ratio of Profit to Sales.

superstore <- superstore %>%
  mutate(Profit_Margin = (Profit/Sales)*100)

2. Create a new column Order_Year by extracting the year from Order Date.

library(stringr)

superstore <- superstore %>%
mutate(Order_Year = str_extract(Order.Date, "\\d{4}"))
str(superstore$Order_Year)


3. Convert the Order.Date column to a Date data type.

superstore$Order_Year <- as.Date(superstore$Order.Date, fromat= "%m/%d/%Y")
  

### Step 5: Aggregating and Summarizing Data

1. Calculate the total sales and profit by Category.

Total_Sales_Profit <- superstore %>%
  group_by(Category) %>%
  summarize(
    Total.Sales = sum(Sales),
    Total.Profit = sum(Profit)
  )

2. Find the average profit margin by Region.

avg_profit_margin_region <- superstore %>%
  group_by(Region) %>%
  summarize(
    Average_Profit_Margin = mean(Profit_Margin)
  )

3. Count the number of orders by Customer Segment.

number_orders_by_segment <- superstore %>%
  group_by(Segment) %>%
  summarize(
    Number_Orders = n_distinct(Order.ID)
  )
  

## Optional

### Extra 1: Advanced Challenges

1. Identify and remove duplicate rows based on Order ID.

duplicated_rows <- superstore[duplicated(superstore$Order.ID),]

superstore <- superstore %>%
  distinct(Order.ID, .keep_all = TRUE)


2. Create a new column Discount_Level that categorizes discounts as "Low" (<10%), "Medium" (10-20%), and "High" (>20%).

Discount_Level <- superstore %>%
  mutate(Discount_Level = case_when(
    Discount >= 20 ~ "High",
    Discount >= 10 & Discount < 20 ~ "Medium",
    Discount < 10 ~ "Low"
  ))

3. Merge the dataset with a new dataset containing regional population data (create a dummy dataset for this purpose).

population_data <- data.frame(
  Region = c("East", "West", "North", "South"),
  Population = c(500000, 300000, 700000, 400000)
)

merged_data <- superstore %>%
  left_join(population_data, by="Region")


### Extra 2: Data Visualization

Next class we will talk about data visualization, but lets see if you can pull it off on your own.

1. Create a bar plot of total sales by Category.

library(ggplot2)

ggplot(Total_Sales_Profit, aes(x=Category, y=Total.Sales)) +
geom_bar(stat = "identity", fill = "skyblue") +  # Erstelle die Balken
  labs(title = "Total Sales by Category", x = "Category", y = "Total Sales") +
  theme_minimal()  # Verwende ein einfaches Thema


2. Create a scatter plot of Sales vs. Profit with a trend line.

library(ggplot2)
ggplot(superstore, aes(x = Sales, y=Profit)) +
  geom_point(aes(y = Profit, x=Sales), stat = "identity", fill = "skyblue") +  
  geom_smooth(aes(y = Profit), method = "lm", color = "red", size = 1) +  
  labs(title = "Total Sales by Category with Trendline for Total Profit", 
       x = "Category", y = "Total Sales / Total Profit") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


3. Create a histogram of Profit_Margin.

ggplot(profit_margin, aes(x = Profit_Margin)) + 
  geom_histogram(binwidth = 0.05, fill = "skyblue", color = "black", alpha = 0.7) +  # Histogramm
  labs(title = "Histogram of Profit Margin", x = "Profit Margin", y = "Frequency") +  # Titel und Achsenbeschriftung
  theme_minimal()

## Deliverables

- Submitted notebook (or file) with your responses to each of the exercises.

## Submission

- Upon completion, add your deliverables to git. 
- Then commit git and push your branch to the remote.
- Make a pull request and paste the PR link in the submission field in the Student Portal.

<br>

**Good luck!**
