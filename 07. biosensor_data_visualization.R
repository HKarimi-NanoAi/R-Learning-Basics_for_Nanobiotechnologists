# Description : Reshapes and merges biosensor metadata with raw fluorescence data. Computes summary statistics (%CV, Mean, SD) and generates publication-ready plots (Scatter plot, Violin plot, and Faceted  Bar chart with error bars) using ggplot2, exporting to high-res PNG.
#_____________________________________

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

plot1 <- ggplot(data = combined_df, aes(x = Concentration_nM, y = Fluorescence, color = Target_Biomarker)) +  geom_point ( size = 4) + labs(title = "Scatter plot", x = "Concentration(nM)", y = "Fluorescence Signal")
print (plot1)

plot2 <- ggplot(data = combined_df, aes(x = Target_Biomarker, y = Fluorescence, fill = Target_Biomarker)) + geom_violin(alpha = 0.6) + geom_jitter(width = 0.3)
print(plot2)

plot3 <- ggplot(data = data_summary, aes(x = factor(Concentration_nM), y = Mean_Signal, color = Target_Biomarker, fill = Target_Biomarker)) + geom_col(position = "dodge", width = 0.7) + geom_errorbar(aes(ymin = Mean_Signal - SD_signal, ymax = Mean_Signal + SD_signal), position = position_dodge(width = 0.7), width = 0.2)+
facet_wrap(~ Target_Biomarker) + labs(title = "Biomarkers' Signals Comparison", x = "Concentration(nM)", y = "Mean signal ± SD")+ theme_minimal() + theme(legend.position = "none")
print(plot3)

ggsave("Biosensor_performance_plot.png", width = 8, height = 6, dpi = 300)
