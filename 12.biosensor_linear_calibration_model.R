#Description : Evaluates biosensor analytical linearity and sensitivity. Computes Pearson correlation coefficient (cor.test) and fits a simple linear regression model (lm) to construct a calibration curve with ggplot2 point and smooth layers.

#_____________________________________________________

library(tidyverse)

calib_data <- data.frame(
  Concentration_nM = c(0, 1, 2.5, 5, 7.5, 10),
  Fluorescence    = c(5.2, 16.8, 31.0, 58.4, 82.1, 107.5)
)

print(calib_data)

calib_corr <- cor.test(calib_data$Concentration_nM, calib_data$Fluorescence)
print(calib_corr)


calib_model <- lm(Fluorescence ~ Concentration_nM, data = calib_data)
print(calib_model)
summary(calib_model)

plot1 <- ggplot(calib_data, aes(x = Concentration_nM, y = Fluorescence)) +geom_point(size = 3, color = "blue") + geom_smooth(method = "lm", se = FALSE, color = "red")
print(plot1)
