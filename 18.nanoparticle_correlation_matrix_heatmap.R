#Description : Computes a Pearson correlation matrix across nanoparticle physicochemical parameters (Size, Zeta Potential, EE%, Uptake). Reshapes matrix using pivot_longer() and visualizes an annotated correlation heatmap using ggplot2 (geom_tile).
#______________________________________________________________________________________________________

library(tidyverse)

nano_data <- data.frame(
  Size_nm      = c(15, 30, 60, 90, 120),
  Zeta_mV      = c(-10, -20, -35, -42, -50),
  EE_Percent   = c(20, 45, 70, 85, 92),    # Encapsulation Efficiency (%)
  Uptake_uM    = c(85, 70, 50, 30, 15)     # Cellular Uptake
)

print(nano_data)

cor_mat <- cor(nano_data)
cor_long <- as.data.frame(cor_mat) %>% rownames_to_column(var = "VAR1") %>% pivot_longer(cols = -VAR1, names_to = "VAR2", values_to = 'Correlation')

plot <- ggplot(cor_long, aes(x = VAR1, y = VAR2, fill = Correlation)) +geom_tile(color = "white") +
        geom_text(aes(label = round(Correlation, 2)), color = "black") +
        scale_fill_gradient2(low = "blue", high ="red", mid = "green", midpoint = 0, limit =c(-1,1)) +
        labs(title = "Nanoparticle Property Correlation Matrix", x = "", y = "") +theme_minimal()

print(plot)
