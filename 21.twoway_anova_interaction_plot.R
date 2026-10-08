#Description : Evaluates the synergistic effects of Nanocarrier type and Temperature on drug release efficiency. Performs Two-Way ANOVA with interaction terms (aov) and constructs an interaction plot using ggplot2's stat_summary layers.

#_________________________________________________

library(tidyverse)


twoway_df <- data.frame(
  Nanocarrier = rep(c("Liposome", "Liposome", "Polymeric_NP", "Polymeric_NP"), each = 3),
  Temp        = rep(c("25C", "37C", "25C", "37C"), each = 3),
  Release     = c(
    20, 22, 21,   # Liposome at 25C
    40, 42, 41,   # Liposome at 37C
    30, 32, 31,   # Polymeric_NP at 25C
    80, 85, 83    # Polymeric_NP at 37C
  )
)

print(twoway_df)



two_way_anova <- aov(Release ~ Nanocarrier * Temp, data = twoway_df)
summary(two_way_anova)


plot <- ggplot(twoway_df, aes(x = Temp, y = Release, color = Nanocarrier, group = Nanocarrier)) +
         stat_summary(fun = mean , geom ="line", size = 1.2 )+ stat_summary(fun = mean , geom ="point", size = 3 )+
         labs(title ="Two-Way ANOVA: Interaction of Temperature and Nanocarrier", x = 'Temperature condistions', y = 'Release') +
         theme_classic()

print(plot)
