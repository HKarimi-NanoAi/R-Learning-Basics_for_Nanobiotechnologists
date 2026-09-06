#Description : Manages complex biosensor experiment data using R nested lists and matrices. Calculates average signal intensities across replicates using rowMeans() and dynamically updates the list.

#________________

biosensor_experiment <- list(list(device_id = "DEV-101", operator = "Nanotechnologist1", date = "2026-09-06"), calibration_matrix = matrix(c(912,768,253,167,245,875,908,126,432,395,621,143), nrow = 4, ncol = 3), analyte_info = c("Troponin", "NT-proBNP", "Myoglobin"))

mean_signals <- rowMeans(biosensor_experiment$calibration_matrix)
biosensor_experiment$mean_signals <- mean_signals
print(biosensor_experiment)
