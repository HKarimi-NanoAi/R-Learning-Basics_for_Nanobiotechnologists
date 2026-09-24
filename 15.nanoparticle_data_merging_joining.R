#Description : Demonstrates tidy data integration workflows for metallic nanoparticles (AuNP & AgNP). Combines row-wise experimental data batches via bind_rows() and performs relational metadata joining using left_join() based on Sample_ID.

#____________________________________________________________________________
library(tidyverse)


data_np1 <- data.frame(
  Sample_ID = c("S1", "S2"),
  Concentration = c(10, 20),
  Absorbance = c(0.25, 0.48)
)


data_np2 <- data.frame(
  Sample_ID = c("S3", "S4"),
  Concentration = c(10, 20),
  Absorbance = c(0.35, 0.70)
)


np_metadata <- data.frame(
  Sample_ID = c("S1", "S2", "S3", "S4"),
  NP_Type = c("AuNP", "AuNP", "AgNP", "AgNP"),
  Size_nm = c(15, 15, 30, 30)
)

all_experiments <- bind_rows(data_np1, data_np2)
print(all_experiments)

final_dataset <- left_join(np_metadata, all_experiments, by = "Sample_ID")

print(final_dataset)
