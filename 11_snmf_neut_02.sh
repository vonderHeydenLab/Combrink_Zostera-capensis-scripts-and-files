library(LEA)
library(ggplot2)

anole_snmf_neutral <- snmf("~/honours_resubmission/populations.snp.resubmission72_neutral.geno",
K = 1:10, entropy = TRUE,
repetitions = 1000,
project = "new",
alpha = 100)