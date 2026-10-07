# Description : Automates statistical post-hoc annotation using multcompView. Fits One-Way ANOVA, calculates Tukey's HSD, automatically generates Compact Letter Displays (CLD) and overlays letters on ggplot2 boxplots for nanocarrier release comparisons.
#________________________________________________________________________

library(tidyverse)
library(multcompView)

delivery_raw <- data.frame(
  Nanocarrier = rep(c("Liposome", "Niosome", "Polymeric_NP", "Solid_Lipid_NP"), each = 4),
  Release_Percent = c(
    45.2, 46.8, 44.1, 45.9,
    48.1, 49.5, 47.9, 48.8,
    82.1, 85.3, 83.0, 84.6,
    50.1, 51.2, 49.8, 50.9
  )
)

anova_mod <- aov(Release_Percent ~ Nanocarrier, data = delivery_raw)
tukey_mod <- TukeyHSD(anova_mod)

cld_res <- multcompLetters4(anova_mod, tukey_mod)


letters_df <- data.frame(
  Nanocarrier = names(cld_res$Nanocarrier$Letters),
  Group_Letter = cld_res$Nanocarrier$Letters
)

max_y <- delivery_raw %>%
  group_by(Nanocarrier) %>%
  summarise(Max_Val = max(Release_Percent) + 3)

final_labels <- left_join(letters_df, max_y, by = "Nanocarrier")

plot <- ggplot(delivery_raw, aes(x = Nanocarrier, y = Release_Percent, fill = Nanocarrier )) + geom_boxplot(alpha = 0.3) + geom_text(data = final_labels, aes(x = Nanocarrier, y = Max_Val, label = Group_Letter), size = 4, color ='purple') +
    theme_classic()

print(plot)
