#Description : Processes biosensor replicate data in a data frame. Calculates row-wise mean, standard deviation and Coefficient of Variation (%CV) for Quality Control (QC). Categorizes samples into Pass/Fail and exports structured multi-tab Excel reports using writexl.
#_____________________________________________________________________________________

biosensor_data <- data.frame(
    Sample_ID = paste0("Sample_", 1:10), concentration = c(0.5, 1.5, 3.5, 7.5, 15, 45,75,100,115,125), Rep1 = c(0.245, 0.451, 0.511, 0.674, 0.792, 0.867, 0.925, 1.11, 2.12, 3.13), Rep2 = c(0.257, 0.567, 0.798, 0.988, 1.72, 5.36, 7.77, 8.67, 9.30, 12.21), Rep3 = c(0.408, 0.541, 0.976, 2.98, 5.98, 10.32, 14.12, 18.55, 22.87, 27.90)
)


biosensor_data$Mean_Signal <- rowMeans(biosensor_data[, c("Rep1", "Rep2", "Rep3")])

biosensor_data$Sd_Signal <- apply(biosensor_data[,c("Rep1", "Rep2", "Rep3")], 1, sd)

biosensor_data$CV_Percent <- (biosensor_data$Sd_Signal/biosensor_data$Mean_Signal)*100

biosensor_data$Quality_Flag <- ifelse(biosensor_data$CV_Percent < 10, "Pass", "Fail (High Noise)")

pass_table <- biosensor_data[biosensor_data$Quality_Flag == "Pass",]

fail_table <- biosensor_data[biosensor_data$Quality_Flag == "Fail (High Noise)",]

sheets_list <- list ("Passed Samples" = pass_table, "Failed Samples" = fail_table)
write_xlsx(sheets_list, path = "Biosensor_QC_Report.xlsx")


head_data <- head(biosensor_data, 2)
tail_data <- tail(biosensor_data, 2)

print(head_data)
print(tail_data)

str(biosensor_data)
