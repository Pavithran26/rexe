install.packages(c("tidyverse","tsibble","feasts","fable","lubridate","forecast","ggplot2","tseries"))
library(tidyverse)  
library(tsibble)      
library(feasts)      
library(fable)        
library(lubridate)    
library(forecast)     
library(ggplot2)      


set.seed(123)
dates <- seq.Date(from = as.Date("2010-01-01"), 
                 to = as.Date("2020-12-01"), 
                 by = "month")
values <- 100 + cumsum(rnorm(length(dates), mean = 0.5, sd = 5)) + 
          sin(seq(0, 4*pi, length.out = length(dates))) * 10

ts_data <- tibble(
  date = dates,
  value = values,
  category = rep(c("A", "B"), length.out = length(dates))
)


data("AirPassengers")
ap_ts <- as_tsibble(AirPassengers)


tsibble_data <- ts_data %>% 
  as_tsibble(index = date, key = category)


ts_object <- ts(ts_data$value, 
                start = c(2010, 1), 
                frequency = 12)


basic_plot <- autoplot(tsibble_data) +
  labs(title = "Time Series Plot", 
       y = "Value", 
       x = "Date") +
  theme_minimal()


seasonal_plot <- tsibble_data %>% 
  gg_season() +
  labs(title = "Seasonal Plot") +
  theme_minimal()


decomp <- tsibble_data %>% 
  model(STL(value ~ trend(window = 7) + season(window = "periodic"))) %>% 
  components()

decomp_plot <- autoplot(decomp) + 
  labs(title = "STL Decomposition") +
  theme_minimal()


library(tseries)
adf_test <- adf.test(ts_object)
cat("ADF p-value:", adf_test$p.value, "\n")


kpss_test <- kpss.test(ts_object)
cat("KPSS p-value:", kpss_test$p.value, "\n")


train <- tsibble_data %>% filter(date < as.Date("2019-01-01"))
test <- tsibble_data %>% filter(date >= as.Date("2019-01-01"))


fits <- train %>% 
  model(
    ets = ETS(value),
    arima = ARIMA(value),
    naive = NAIVE(value),
    snaive = SNAIVE(value ~ lag("year")),
    lm = TSLM(value ~ trend() + season())
  )


forecasts <- fits %>% 
  forecast(h = "2 years")


forecast_plot <- forecasts %>% 
  autoplot(train, level = 95) +
  autolayer(test, color = "black") +
  labs(title = "Forecast Comparison") +
  theme_minimal()


accuracy_table <- fits %>% 
  forecast(h = "2 years") %>% 
  accuracy(test)


resid_plot <- fits %>% 
  select(arima) %>% 
  gg_tsresiduals() +
  labs(title = "ARIMA Model Residuals")


if(FALSE){  
  library(msts)
  multi_season_ts <- msts(ts_data$value, seasonal.periods = c(12, 36))
  tbats_model <- tbats(multi_season_ts)
  tbats_forecast <- forecast(tbats_model, h = 24)
  plot(tbats_forecast)
}


print(basic_plot)
print(seasonal_plot)
print(decomp_plot)
print(forecast_plot)
print(resid_plot)


print(accuracy_table)


print(fits)