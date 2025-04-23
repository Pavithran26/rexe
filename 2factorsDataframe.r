# === FACTOR OPERATIONS ===
# Create original factor with 5 elements
employee_levels <- factor(c("Junior", "Senior", "Mid", "Junior", "Director"))
levels(employee_levels)[levels(employee_levels) == "Director"] <- "Executive"

# Create ordered performance factor
performance <- factor(c("Good", "Excellent", "Poor", "Good"), 
                      levels = c("Poor", "Good", "Excellent"),
                      ordered = TRUE)

# Create department factor (4 elements)
department <- factor(c("IT", "HR", "IT", "Finance"))

# === DATA FRAME OPERATIONS ===
# Create initial data frame with 4 employees
company_data <- data.frame(
  EmployeeID = c(101, 102, 103, 104),
  Name = c("John", "Sarah", "Mike", "Lisa"),
  Department = department,
  Level = employee_levels[1:4],  # Use first 4 levels to match 4 employees
  Salary = c(50000, 65000, 72000, 88000),
  JoinDate = as.Date(c("2020-01-15", "2018-05-22", "2019-11-03", "2017-07-30")),
  stringsAsFactors = FALSE
)

# Add bonus column
company_data$Bonus <- company_data$Salary * 0.1

# Add new employee (now 5 total)
new_employee <- data.frame(
  EmployeeID = 105,
  Name = "David",
  Department = "IT",
  Level = "Junior",
  Salary = 48000,
  JoinDate = as.Date("2021-02-18"),
  Bonus = 4800
)
company_data <- rbind(company_data, new_employee)

# Fix factor levels after rbind
company_data$Department <- factor(company_data$Department)
company_data$Level <- factor(company_data$Level)

# === ANALYSIS OPERATIONS ===
# Subset IT department
cat("IT Department Employees:\n")
print(subset(company_data, Department == "IT"))

# Sort by salary
cat("\nEmployees Sorted by Salary:\n")
print(company_data[order(-company_data$Salary), ])

# Average salary by department
cat("\nAverage Salaries by Department:\n")
print(aggregate(Salary ~ Department, data = company_data, mean))

# Cross-tabulation
cat("\nDepartment vs Level Counts:\n")
print(table(company_data$Department, company_data$Level))

# ANOVA
cat("\nSalary ANOVA by Department:\n")
print(summary(aov(Salary ~ Department, data = company_data)))

# === VISUALIZATION ===
par(mfrow = c(1, 2))
barplot(table(company_data$Department), 
        main = "Employees by Department", 
        col = "skyblue")
boxplot(Salary ~ Department, data = company_data,
        main = "Salary Distribution",
        col = "lightgreen")

# === DATA EXPORT ===
write.csv(company_data, "company_data.csv", row.names = FALSE)
cat("\nData exported to company_data.csv\n")

# === CLEANUP ===
rm(list = ls())
cat("Workspace cleared\n")
