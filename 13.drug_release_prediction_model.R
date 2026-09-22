#Description : Fits a linear regression model (lm) on standard drug concentration vs. release percent data. Demonstrates predictive analytics using predict() to estimate release percentages for unseen samples, accompanied by a ggplot2 fitted regression plot.
#_________________________________________________________________


library(tidyverse)

std_data <- data.frame(
  Concentration_ug = c(5, 10, 20, 40, 80),
  Release_Percent  = c(12.5, 24.0, 48.2, 82.1, 155.0)
)

print(std_data)

release_model <- lm(Release_Percent ~ Concentration_ug, data = std_data)
print(release_model)

new_samples <- data_frame(Concentration_ug = c(15, 50))

predicted_release_per <- predict(release_model, newdata = new_samples)
cat("Predicted Release % is", predicted_release_per,"\n")

plot1 <- ggplot(std_data, aes(x = Concentration_ug, y = Release_Percent))+ geom_point(size = 5.75, color = 'yellow') + geom_smooth(method = 'lm', se = FALSE, color ='green')
print(plot1)
