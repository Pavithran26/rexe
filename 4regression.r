set.seed(123)  
age <- 20:60
height <- 50 + 0.5 * age + rnorm(length(age), mean = 0, sd = 3) 
df <- data.frame(age, height)
model <- lm(height ~ age, data = df)
summary(model)
plot(df$age, df$height, main = "Height vs Age with Regression Line",
     xlab = "Age", ylab = "Height", pch = 19, col = "blue")
abline(model, col = "red", lwd = 2)