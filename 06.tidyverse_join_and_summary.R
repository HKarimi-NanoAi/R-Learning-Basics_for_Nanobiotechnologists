#Description : Merges metadata and raw replicate measurements using left_join() and pivot_longer(). Normalizes fluorescence signal by concentration and generates grouped summary statistics (Mean, SD, %CV).
#__________________________________________________________________

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
