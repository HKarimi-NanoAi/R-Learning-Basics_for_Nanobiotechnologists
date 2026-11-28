# Description : Models and visualizes in vitro MTT cell viability dose-response curves comparing Free Drug vs. Targeted Nanoparticles across logarithmic concentrations (0.1 to 1000 µg/mL). Includes Mean ± SD 
#error bars, LOESS smoothing, a 50% viability reference line (IC50 threshold), and the Nature Publishing Group (NPG) palette.
#____________________________________________________________________________________

library(tidyverse)
library(ggsci)


mtt_df <- data.frame(
  Treatment = rep(c("Free_Drug", "Targeted_NP"), each = 15),
  Concentration = rep(rep(c(0.1, 1, 10, 100, 1000), each = 3), 2),
  Viability = c(
#Free_Drug
    98, 96, 97,
    92, 90, 91,
    78, 75, 76,
    52, 48, 50,
    25, 22, 24,
#Targeted_NP
    95, 93, 94,
    80, 77, 79,
    46, 42, 44,
    18, 15, 17,
    8,  6,  7
  )
)


plot <- ggplot(mtt_df, aes(x = Concentration, y = Viability, color = Treatment))+ stat_summary(fun = mean, geom = "point", size = 3)+
stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = 'errorbar', width = 0.08)+
geom_smooth(method = "loess", se = FALSE, linewidth = 1) + scale_x_log10() + geom_hline(yintercept = 50, linetype = "dashed", color = "gray40")+
labs (title = "Cell Viability Dose-Response Curve", x = "Concentration (µg/mL)", y = "Cell Viability (%)") +
theme_classic(base_size =  12) + scale_color_npg()

print(plot)
