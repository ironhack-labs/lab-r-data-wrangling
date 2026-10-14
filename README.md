
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

### Step 1: Load and Explore the Dataset

1. Load the dataset into R.
2. Explore the dataset using str(), head(), and summary().
3. Identify the number of rows and columns.

### Step 2: Basic Data Manipulation

1. Select the following columns: Order ID, Order Date, Customer Name, Sales, Profit.
2. Filter the dataset to show only orders with a profit greater than $100.
3. Sort the dataset by Sales in descending order.

### Step 3: Handle Missing Data

1. Check for missing values in the dataset.
2. Replace missing values in the Postal Code column with the mode (most frequent value).
3. Remove rows with missing values in the Customer Name column.

### Step 4: Create and Modify Columns

1. Create a new column Profit_Margin as the ratio of Profit to Sales.
2. Create a new column Order_Year by extracting the year from Order Date.
3. Convert the Order.Date column to a Date data type.

### Step 5: Aggregating and Summarizing Data

1. Calculate the total sales and profit by Category.
2. Find the average profit margin by Region.
3. Count the number of orders by Customer Segment.

## Optional

### Extra 1: Advanced Challenges

1. Identify and remove duplicate rows based on Order ID.
2. Create a new column Discount_Level that categorizes discounts as "Low" (<10%), "Medium" (10-20%), and "High" (>20%).
3. Merge the dataset with a new dataset containing regional population data (create a dummy dataset for this purpose).

### Extra 2: Data Visualization

Next class we will talk about data visualization, but let's see if you can pull it off on your own.

1. Create a bar plot of total sales by Category.
2. Create a scatter plot of Sales vs. Profit with a trend line.
3. Create a histogram of Profit_Margin.

## Deliverables

- Submitted notebook (or file) with your responses to each of the exercises.

## Submission

- Upon completion, add your deliverables to git. 
- Then commit git and push your branch to the remote.
- Make a pull request and paste the PR link in the submission field in the Student Portal.

<br>

**Good luck!**
