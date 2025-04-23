install.packages(c("ggplot2","patchwork","plotly"))
                 
library(ggplot2)
library(patchwork)
library(plotly)    

data(mtcars)
data(iris)
data(economics)

my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2")


par(mfrow = c(2, 2)) # Set up 2x2 grid for base plots


plot(mtcars$wt, mtcars$mpg, 
     main = "Base R: MPG vs Weight",
     xlab = "Weight (1000 lbs)", ylab = "MPG",
     pch = 19, col = my_colors[mtcars$cyl-3])

hist(mtcars$mpg, breaks = 10, col = my_colors[3],
     main = "Base R: MPG Distribution", xlab = "Miles per Gallon")

boxplot(mpg ~ cyl, data = mtcars, col = my_colors[1:3],
        main = "Base R: MPG by Cylinders")

plot(AirPassengers, col = my_colors[4], lwd = 2,
     main = "Base R: Air Passengers Time Series")

par(mfrow = c(1, 1)) # Reset plot layout


p1 <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  facet_wrap(~gear) +
  scale_color_manual(values = my_colors) +
  labs(title = "ggplot2: MPG vs Weight by Gear",
       subtitle = "Colored by number of cylinders") +
  theme_minimal()


p2 <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_manual(values = my_colors) +
  labs(title = "ggplot2: Count by Cylinders") +
  theme_classic()


p3 <- ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.7) +
  scale_fill_manual(values = my_colors) +
  labs(title = "ggplot2: Sepal Length Distribution") +
  theme_bw()


p4 <- ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line(color = my_colors[4], size = 1) +
  labs(title = "ggplot2: Unemployment Over Time") +
  theme_light()


combined_plots <- (p1 + p2) / (p3 + p4) +
  plot_annotation(title = "Combined ggplot2 Visualizations",
                  theme = theme(plot.title = element_text(size = 16, hjust = 0.5)))

print(combined_plots)


interactive_plot <- ggplot(mtcars, 
                           aes(x = wt, y = mpg, 
                               color = factor(cyl),
                               text = rownames(mtcars))) +
  geom_point(size = 3) +
  scale_color_manual(values = my_colors) +
  labs(title = "Interactive: Hover to see car models")

ggplotly(interactive_plot, tooltip = "text")


png("base_r_plots.png", width = 800, height = 600)
par(mfrow = c(2, 2))
plot(mtcars$wt, mtcars$mpg, main = "MPG vs Weight")
dev.off()

ggsave("ggplot_combined.png", plot = combined_plots, width = 12, height = 8, dpi = 300)
cat("\nGRAPHICS PROGRAM COMPLETED SUCCESSFULLY!\n")
cat("- Created 4 base R plots (scatter, histogram, boxplot, line)\n")
cat("- Created 4 ggplot2 plots (scatter, bar, density, line)\n")
cat("- Generated interactive plot using plotly\n")
cat("- Saved plots to working directory\n")