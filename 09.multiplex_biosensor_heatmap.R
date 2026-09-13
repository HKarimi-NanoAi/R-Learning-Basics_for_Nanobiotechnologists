#Description : Simulates a 5-plex biosensor assay dataset (Troponin, NT-proBNP, Myoglobin, CK-MB, CRP) across concentrations with 3 replicates. Calculates mean signals and plots a annotated heatmap using ggplot2 and the viridis color palette, saving high-res PNG.
#_________________________________________________________________________________

library(tidyverse)

multi_biosensor <- data.frame(Biomarkers = rep(c("Troponin", "NT-proBNP", "Myoglobin", "CK-MB", "CRP"), each = 12), Concentration = rep(rep(c(0.1, 1.0, 10.0, 50.0), each =3), times = 5), Repeat = rep(c("Rep1","Rep2","Rep3"), times = 20))

multi_biosensor$Fluorescence <- round(runif(60, 1, 100),2)

mean_signal <- multi_biosensor %>% group_by(Biomarkers, Concentration) %>% summarise(Mean_signal = mean(Fluorescence), .groups = "drop")

plot1 <- ggplot(mean_signal, aes(x = factor(Concentration), y = Biomarkers, fill = Mean_signal)) +geom_tile(color = "white") + geom_text(aes(label = round(Mean_signal, 1))) + scale_fill_viridis_c(option = "viridis")

print(plot1)
ggsave("Multiplex_Biosensor_Heatmap.png", plot = plot1, width = 8, height = 6, dpi = 300)
