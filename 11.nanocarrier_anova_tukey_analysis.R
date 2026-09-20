#Description : Evaluates drug release efficiency across four nanocarriers (Liposome, Niosome, Polymeric NP, and Solid Lipid NP). Performs One-Way ANOVA (aov), Tukey HSD post-hoc test for pairwise comparisons and builds a colorful ggplot2 boxplot.

#______________________________________________

library(tidyverse)

delivery_raw <- data.frame(
  Nanocarrier = rep(c("Liposome", "Niosome", "Polymeric_NP", "Solid_Lipid_NP"), each = 4),
  Release_Percent = c(
    45.2, 46.8, 44.1, 45.9,  # Liposome
    48.1, 49.5, 47.9, 48.8,  # Niosome
    82.1, 85.3, 83.0, 84.6,  # Polymeric_NP (high_efficiency)
    50.1, 51.2, 49.8, 50.9   # Solid_Lipid_NP
  )
)

print(delivery_raw)


anova_model <- aov(Release_Percent ~ Nanocarrier, data = delivery_raw)
summary(anova_model)

tukey_result <- TukeyHSD(anova_model)
print(tukey_result)

plot1 <- ggplot(data = delivery_raw, mapping= aes( x = Nanocarrier, y = Release_Percent, fill = Nanocarrier))+ geom_boxplot()
print(plot1)
