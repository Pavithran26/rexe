install.packages(c("tidyverse", "DataExplorer", "skimr", "corrplot", "GGally"))
library(tidyverse) 
library(DataExplorer)  
library(skimr) 
library(corrplot) 
library(GGally)  
data <- mtcars  # Using mtcars as an example
cat("\n=== Dataset Structure ===\n")
str(data)
cat("\n=== First Few Rows ===\n")
head(data)
cat("\n=== Summary Statistics ===\n")
summary(data)
cat("\n=== Detailed Summary with skimr ===\n")
skim(data)
cat("\n=== Missing Data Summary ===\n")
plot_missing(data)  # Visual representation
print(colSums(is.na(data)))  # Count of NAs per column
numeric_vars <- data %>% select_if(is.numeric)
cat("\n=== Histograms for Numeric Variables ===\n")
plot_histogram(numeric_vars)
cat("\n=== Density Plots for Numeric Variables ===\n")
plot_density(numeric_vars)
cat("\n=== Boxplots for Numeric Variables ===\n")
plot_boxplot(numeric_vars)
categorical_vars <- data %>% select_if(is.factor)
if(ncol(categorical_vars) > 0) {
  cat("\n=== Bar Plots for Categorical Variables ===\n")
  plot_bar(categorical_vars)
}
cat("\n=== Scatterplot Matrix ===\n")
ggpairs(data, progress = FALSE)
cat("\n=== Correlation Matrix ===\n")
cor_matrix <- cor(numeric_vars, use = "complete.obs")
print(cor_matrix)
corrplot(cor_matrix, method = "circle")
if("mpg" %in% names(data) && "cyl" %in% names(data) && "gear" %in% names(data)) {
  cat("\n=== Multivariate Boxplot (mpg by cyl and gear) ===\n")
  ggplot(data, aes(x = factor(cyl), y = mpg, fill = factor(gear))) +
    geom_boxplot() +
    labs(title = "MPG by Cylinders and Gears",
         x = "Number of Cylinders",
         y = "Miles per Gallon",
         fill = "Gears")
}
cat("\n=== EDA Completed ===\n")
