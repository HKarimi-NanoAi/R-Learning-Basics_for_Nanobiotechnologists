#Description : Constructs a biosensor calibration curve for target protein quantification. Generates a publication-ready ggplot2 visualization with confidence intervals.
#_____________________________________________________________________________________________

library(tidyverse)

sensor_calib <- data.frame(
  Protein_nM = c(0, 2, 4, 6, 8, 10),
  Signal_uA  = c(1.2, 5.5, 9.8, 14.1, 18.0, 22.3)
)

print(sensor_calib)

protein_model <- lm(Signal_uA ~ Protein_nM, data = sensor_calib)

unknown_data <- data.frame(Protein_nM = c(3, 7)) 
unknown_data$Predicted_Signal <- predict(protein_model,  newdata = unknown_data)


plot1 <- ggplot()+ geom_point(data = sensor_calib, aes(x = Protein_nM, y = Signal_uA) , color = "blue", size = 3) + geom_smooth(data = sensor_calib, aes(x = Protein_nM, y = Signal_uA), method ='lm', se= FALSE, color = "darkgray") + 
geom_point(data = unknown_data, aes(x = Protein_nM, y = Predicted_Signal), color = 'red', size = 4, shape = 15) + labs (title = "Protein Biosensor Calibration Curve" , x = "Protein Concentration (nM)" , y = "Signal (uA)") +theme_minimal()

print(plot1)
