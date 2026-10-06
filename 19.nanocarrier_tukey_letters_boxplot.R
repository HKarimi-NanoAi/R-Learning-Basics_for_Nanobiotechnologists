#Description : Visualizes drug release efficiency across four nanocarrier types. Combines ggplot2 boxplots with Compact Letter Display (a, b, bc, c) derived from Tukey's HSD post-hoc analysis to annotate statistically significant differences (p < 0.05).

#____________________________________________________________________________

library(tidyverse)


delivery_raw <- data.frame(
  Nanocarrier = rep(c("Liposome", "Niosome", "Polymeric_NP", "Solid_Lipid_NP"), each = 4),
  Release_Percent = c(
    45.2, 46.8, 44.1, 45.9,  # Liposome
    48.1, 49.5, 47.9, 48.8,  # Niosome
    82.1, 85.3, 83.0, 84.6,  # Polymeric_NP
    50.1, 51.2, 49.8, 50.9   # Solid_Lipid_NP
  )
)


labels_df <- data.frame(
  Nanocarrier = c("Polymeric_NP", "Solid_Lipid_NP", "Niosome", "Liposome"),
  Max_Release = c(88, 54, 52, 49),
  Group_Letter = c("a", "b", "bc", "c")
)


plot <- ggplot(delivery_raw, aes(x = Nanocarrier, y = Release_Percent, fill = Nanocarrier))+
        geom_boxplot (alpha = 0.7) + geom_text( data = labels_df, aes(x = Nanocarrier, y = Max_Release, label = Group_Letter), size = 5, color = "darkred")+
        labs(title = "Drug Release Efficiency across Nanocarriers", subtitle = "ANOVA with Tukey's HSD Test (p < 0.05)", x= "Nanocarrier type", y= "Release_Percent") + 
        theme_classic()

print(plot)
