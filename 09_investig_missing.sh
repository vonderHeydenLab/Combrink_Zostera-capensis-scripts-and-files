if (!require("poppr", quietly = TRUE))
  install.packages("poppr")
library(poppr)

#renamed populations.snps.genepop from Stacks outputs to populations.snps.genepop72.gen"
poppr_genind<-import2genind("/Users/Charlotte/Documents/Bioinformatics/Resubmission/Populations_outputs/populations.snps.genepop.gen")
levels(poppr_genind$pop) <- c("KA", "BU", "SW", "KO", "NA")
View(poppr_genind)

neutral_genind <- vcfR2genind(vcf)

#plot missing data
poppr_geneclone<-as.genclone(poppr_genind)
info_table(poppr_geneclone, plot = TRUE) #plot heat map

#OPTIONAL write table of missing data  
info_table<-info_table(poppr_geneclone, plot = FALSE)
write.table(info_table, "missing_data", quote=FALSE, sep="\t", row.names=TRUE)

#Lets get missing data by individuals
genind_obj <- poppr_genind

# Calculate missing data for each individual
missing_individuals <- apply(genind_obj@tab, 1, function(x) sum(is.na(x)) / length(x))

# Convert to percentages
missing_individuals_percent <- missing_individuals * 100

# Create a data frame with the results
missing_individuals_df <- data.frame(
  Individual = rownames(genind_obj@tab),
  PercentMissing = missing_individuals_percent
)

# View the results
print(missing_individuals_df)

#Now missing data per population 
# Calculate missing data for each locus across all individuals within each population
missing_per_population <- apply(genind_obj@tab, 2, function(x) tapply(is.na(x), genind_obj@pop, mean))
View(genind_obj)
View(missing_per_population)

# Convert to percentages
missing_per_population_percent <- missing_per_population * 100

# Calculate average missing data per population
average_missing_population <- colMeans(missing_per_population_percent, na.rm = TRUE)

# Create a data frame with the results
missing_population_df <- data.frame(
  Population = names(average_missing_population),
  PercentMissing = average_missing_population
)

# Calculate the average missing data per population
average_missing_data <- rowMeans(missing_per_population, na.rm = TRUE)

# Convert to a data frame for easier inspection
average_missing_data_df <- data.frame(
  Population = rownames(missing_per_population),
  AverageMissingData = average_missing_data
)

# View the results
print(average_missing_data_df)
