#Description : Defines a custom R function to evaluate biosensor performance. Calculates mean signal, standard deviation, and Signal-to-Noise  Ratio (SNR), then applies conditional control logic to assess signal quality and flag high variability (CV > 15%).
#________________________________________________________________________________________________

analyze_biosensor <- function(signals = c(7,4,2,9,12,5,8,11), blank_mean = 0.05, cutoff_ratio = 3.0){
  mean_signal <- mean(signals)
  sd_signals <- sd(signals)
  SNR <- mean_signal / blank_mean

  if (SNR >= cutoff_ratio){
    status <- "Acceptable Signal"
  
  } else {
    status <- "Low Signal-to-Noise Ratio"

  }
  warning_msg <- "None"
  if (sd_signals > (0.15 * mean_signal)) {
    warning_msg <- "High Variability Detected"
  }

  return(list(mean = mean_signal, sd = sd_signals, SNR = SNR, status = status, warning = warning_msg ))
}
strong_data <- analyze_biosensor(signals = c(67,54,32,19,81), blank_mean = 0.7)
cat("New result for strong signals:")
print(strong_data)

noisy_data <- analyze_biosensor(signals = c(0.67,0.54,0.32,0.19,0.81), blank_mean = 1.4)
print("New result for noisy signals:")
print(noisy_data)
