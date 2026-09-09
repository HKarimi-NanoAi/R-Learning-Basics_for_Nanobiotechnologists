#Description : Demonstrates modern R data wrangling using the dplyr package. Generates a simulated biosensor dataset and processes it through a pipeline (%>%) utilizing filter, mutate, select, and arrange.
#__________________________________________________________________________

library(tidyverse)
biosensor_df <- data.frame(Bio_sample_ID = paste0("Sample_", 1:15),
Batch_ID = rep(c("A", "B", "C"), each = 5), Nanoparticle_Type = rep(c("AuNP", "GO", "AuNP", "GO", "AuNP"), times = 3), Raw_Signal = c(round(runif(5, min = 0.5, max = 2.5),3),round(runif(5, min = 1.0, max = 3.5),3),round(runif(5, min = 0.8, max = 3.0),3)), Background_noise = c(round(runif(5, min = 0.05, max = 0.25),3),round(runif(5, min = 0.08, max = 0.30),3), round(runif(5, min = 0.03, max = 0.20),3)))


tidy_biosensor_summary <- biosensor_df %>% filter(Background_noise < 0.5) %>% mutate(Net_signal = Raw_Signal - Background_noise) %>% mutate(Quality = ifelse(Net_signal > 2.0, "High Sensitivity", "Standard")) %>% select(Batch_ID, Bio_sample_ID, Nanoparticle_Type, Net_signal, Quality ) %>% arrange(desc(Net_signal))

str(tidy_biosensor_summary)
print(tidy_biosensor_summary)
