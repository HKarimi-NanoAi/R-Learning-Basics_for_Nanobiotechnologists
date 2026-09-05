#Description : Interactive biosensor data entry script.
#________________________________________________________________

sensor_id <- readline("Enter the Sensor ID:")
analyte <- readline("Enter the name of the Analyte:")
lod_nm <- as.numeric(readline("Enter LOD:"))
is_validated <- as.logical(readline("Is sensor validated:"))
measured_signals <- readline("Enter the measured signal:")
is_clinical_grade <- (lod_nm < 1.0) & (is_validated == TRUE)

cat("sensor ID is :",sensor_id, "\n ", "Analyte is:", analyte, "\n", "Sensor LOD is (nm):", lod_nm, "\n", "Measured Signal is:", measured_signals, "\n ", "Clinical Grade", is_clinical_grade)
