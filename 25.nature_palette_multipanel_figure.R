# Description : Enhances multi-panel scientific visualization by applying the Nature Publishing Group (NPG) color palette via ggsci (scale_color_npg & scale_fill_npg) to a patchwork composite figure of drug release kinetics and encapsulation efficiency, exported at 300 DPI.
#__________________________________________________________________________

library(tidyverse)
library(patchwork)
library(ggsci)

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

ee_df <- data.frame(
  Nanocarrier = rep(c("Liposome", "Niosome", "Polymeric_NP", "SLN"), each = 4),
  EE_Percent  = c(
    65, 68, 66, 67,
    70, 72, 69, 71,
    88, 91, 89, 90,
    75, 77, 74, 76
  )
)


plot1 <- ggplot(twoway_df, aes(x = Temp, y = Release, group = Nanocarrier, color = Nanocarrier))+
stat_summary(fun = mean, geom = "line", linewidth = 0.8)+
stat_summary(fun = mean, geom = "point", size = 3)+
stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.08, linewidth = 0.8 )+
theme_classic(base_size = 12) + scale_color_npg()



plot2 <- ggplot(ee_df, aes(x =  Nanocarrier, y = EE_Percent, fill = Nanocarrier)) + geom_boxplot(alpha = 0.5)+
theme_classic(base_size = 12) + theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold")) + scale_fill_npg()

combined_fig <- (plot1 + plot2) + plot_annotation(tag_levels = "A")
print(combined_fig)

save <- ggsave(filename = "combined_fig.png", plot = combined_fig, width = 24, height = 10, units = "cm", dpi = 300)
