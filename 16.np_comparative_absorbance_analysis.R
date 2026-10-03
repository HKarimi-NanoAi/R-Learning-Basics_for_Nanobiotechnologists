#Description : Merges spectroscopic datasets for Gold (AuNP) and Silver (AgNP) nanoparticles, joins metadata, calculates summary statistics (mean & SD of absorbance), and generates a comparative line plot using ggplot2.

#_______________________________________________________
library(tidyverse)


au_data <- data.frame(
  Sample_ID = c("Au_1", "Au_2", "Au_3"),
  Concentration = c(10, 20, 30),
  Absorbance = c(0.18, 0.35, 0.52)
)


ag_data <- data.frame(
  Sample_ID = c("Ag_1", "Ag_2", "Ag_3"),
  Concentration = c(10, 20, 30),
  Absorbance = c(0.29, 0.58, 0.85)
)


np_info <- data.frame(
  Sample_ID = c("Au_1", "Au_2", "Au_3", "Ag_1", "Ag_2", "Ag_3"),
  NP_Type = c("AuNP", "AuNP", "AuNP", "AgNP", "AgNP", "AgNP")
)

all_data <- bind_rows(au_data, ag_data)
full_df <- left_join(np_info, all_data, by = "Sample_ID")

summary_table <- full_df %>% group_by(NP_Type) %>% summarise(mean_absorb = mean(Absorbance), sd_absorb = sd(Absorbance))

print(summary_table)

plot <- ggplot(full_df, aes(x = Concentration, y = Absorbance, color = NP_Type)) + geom_point(size = 3)+ geom_line(aes(group =NP_Type), size =1)+
labs( title = "Comparative Absorbance: AuNP vs AgNP", x = "Concentration (ug/mL)", y ="Absorbance (a.u.)") +
theme_minimal()
print(plot)
