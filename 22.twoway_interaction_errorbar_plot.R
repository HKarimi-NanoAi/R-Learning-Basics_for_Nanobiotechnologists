#Description : Enhances the Two-Way ANOVA interaction plot by computing and overlaying Mean ± SD error bars (stat_summary with mean_sdl) across thermal conditions and nanocarrier formulations.

#_______________________________________________________________________________

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

plot <- ggplot(twoway_df, aes(x = Temp, y = Release, group = Nanocarrier, color = Nanocarrier))+
stat_summary(fun = mean, geom = "line", linewidth = 1.1)+
stat_summary(fun = mean, geom ="point", size = 3)+
stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.08, linewidth = 0.8)+
labs(title = "Drug Release Profile (Mean ± SD)", x = "Temperature", y = "Release (%)") + theme_classic()


print(plot)
