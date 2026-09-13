#Description : Processes biosensor assay measurements to fit linear regression models (geom_smooth) and builds a heatmap (geom_tile) to visual signal intensity across replicates (Rep1-Rep3) per biomarker.

#_________________________________________________________________________

library(tidyverse)


samples_df <- data.frame(

  Sample_ID = paste0("S", 1:6),

  Target_Biomarker = c("Troponin", "Troponin", "Troponin", "NT-proBNP", "NT-proBNP", "NT-proBNP"),

  Concentration_nM = c(0.1, 0.5, 1.0, 0.1, 0.5, 1.0)

)


readings_df <- data.frame(

  Sample_ID = paste0("S", 1:6),

  Rep1 = c(12.1, 25.4, 52.1, 8.2, 18.1, 35.6),

  Rep2 = c(11.8, 26.1, 50.8, 8.5, 17.9, 36.2),

  Rep3 = c(12.5, 24.8, 51.5, 8.0, 18.5, 35.1)

)



readings_long <- readings_df %>% pivot_longer(cols = c(Rep1 , Rep2, Rep3), names_to = "Replicate_Num", values_to = "Fluorescence")


combined_df <- samples_df %>% left_join(readings_long, by = "Sample_ID")


combined_df<- combined_df %>% mutate( Normalized_Signal = Fluorescence/Concentration_nM)


data_summary <- combined_df %>% group_by(Target_Biomarker, Concentration_nM) %>% summarise(Mean_Signal = mean(Fluorescence), SD_signal = sd (Fluorescence), Mean_Normalized = mean(Normalized_Signal), CV_Percent = (SD_signal/Mean_Signal)*100, .groups = "drop")

print(data_summary)

plot1 <- ggplot(combined_df, aes(x = Concentration_nM, y = Fluorescence, color = Target_Biomarker)) + geom_smooth(method = 'lm', se = TRUE) + theme_classic()
print(plot1)


plot2 <- ggplot(data = combined_df, aes(x = factor(Concentration_nM), y = Replicate_Num, fill = Fluorescence)) + geom_tile(color = "white", linewidth = 0.5) + facet_wrap(~ Target_Biomarker)+ scale_fill_gradient(low = "lightyellow", high = "darkred")
print(plot2)
