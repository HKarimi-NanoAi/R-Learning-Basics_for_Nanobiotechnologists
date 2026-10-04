# Description : Visualizes dose-dependent cytotoxicity profiles (cell viability %) of AuNP and AgNP nanoparticles across multiple cancer cell lines (HeLa & MCF7) using multi-panel ggplot2 faceting.
#______________________________________________________________________________

library(tidyverse)

toxicity_data <- data.frame(
  Cell_Line     = c("HeLa", "HeLa", "HeLa", "HeLa", "HeLa", "HeLa",
                    "MCF7", "MCF7", "MCF7", "MCF7", "MCF7", "MCF7"),
  NP_Type       = c("AuNP", "AuNP", "AuNP", "AgNP", "AgNP", "AgNP",
                    "AuNP", "AuNP", "AuNP", "AgNP", "AgNP", "AgNP"),
  Conc_ug       = c(10, 50, 100, 10, 50, 100, 10, 50, 100, 10, 50, 100),
  Viability_Pct = c(95, 88, 80, 85, 60, 35, 92, 82, 75, 78, 50, 20)
)

print(toxicity_data)

plot <- ggplot( toxicity_data, aes(x = Conc_ug, y = Viability_Pct, color = NP_Type )) + geom_point(size = 3) + geom_line(aes(group = NP_Type), size = 1) +
         facet_wrap(~Cell_Line) + labs( title = "Nanoparticle Cytotoxicity across Cell Lines", x = "Concentration (ug/mL)", y = "Cell Viability (%)", color = "Nanoparticle") + theme_minimal()

print(plot)
