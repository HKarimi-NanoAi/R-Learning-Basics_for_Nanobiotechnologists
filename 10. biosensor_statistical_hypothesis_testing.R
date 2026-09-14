#Description : Implements automated statistical decision-making for biosensor data. Tests normality via Shapiro-Wilk test, then dynamically selects between Student's t-test (parametric) and Mann-Whitney Wilcoxon test (non-parametric) to evaluate nanoparticle performance.
#_____________________________________________________________--
library(tidyverse)


set.seed(123)

nano_data <- data.frame(
  NP_Type = rep(c("AuNPs", "Graphene_Oxf"), each = 10),
  Signal_Response = c(rnorm(10, mean = 25, sd = 2), rnorm(10, mean = 40, sd = 5)))

shap_test <- shapiro.test(nano_data$Signal_Response)
resp <- shap_test$p.value
resp <- ifelse(resp <= 0.05, "Non-Normal", "Normal")
print(resp)

t_test <- t.test(Signal_Response~ NP_Type, data = nano_data)
resp_t <- t_test$p.value
resp_t <- ifelse(resp_t < 0.05, "Significant Difference", "No Significant Difference")
mean_diff <- diff(t_test$estimate)

cat("  p-value is", resp_t,"\n")
cat("  Mean difference is", mean_diff,"\n")


set.seed(123)
run_biosensor_stats <- function(data, val_col, group_col) {
  values <- data[[val_col]]
  groups <- factor(data[[group_col]])

shapiro_p <- shapiro.test(values)$p.value


if(shapiro_p > 0.05){
    test_t <- t.test(values ~ groups)
    Test_Used <- "Two-Sample t-test"
    stat_p <- test_t$p.value
}else{
    wilco_test <- wilcox.test(values ~ groups)
    Test_Used <- "Mann-Whitney / Wilcoxon Test"
    stat_p <- wilco_test$p.value
}

return(list(Normality_p_value = shapiro_p, Test_Used = Test_Used, Statistical_p_value = stat_p, Is_significant = (stat_p < 0.05)  ))}

final_analysis  <- run_biosensor_stats(data = nano_data, val_col = "Signal_Response", group_col = "NP_Type")
print(final_analysis)
