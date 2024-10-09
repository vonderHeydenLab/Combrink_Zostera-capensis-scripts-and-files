library(LEA)
library(ggplot2)

new_outlier <- lfmm("~/honours_resubmission/populations.snp.resubmission72_new_outlier.lfmm",
K = 1:10, entropy = TRUE,
repetitions = 1000,
project = "new",
alpha = 100)