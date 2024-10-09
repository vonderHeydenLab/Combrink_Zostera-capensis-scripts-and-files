#Outlier detection
module load app/R/4.3.2

R

library(LEA)
library(ggplot2)
library(readxl)
library(tidyr)

#load project
project_snmf_full = load.snmfProject("~/honours_resubmission/populations.snp.resubmission72.snmfProject")

pdf("plot.full.K.pdf")
plot(project_snmf_full, cex = 1.2, col = "lightblue", pch = 19)
dev.off()

#detect outliers
p = snmf.pvalues(
	project_snmf_full,
	entropy = TRUE, 
	ploidy = 2, 
	K = 5)

pvaluessnmf = p$pvalues

#Plot outliers 
pdf("snmf.outliers.pdf")
plot(-log10(pvaluessnmf), 
	pch = 19, 
	col = "blue", cex = .5)
dev.off()

#subset outliers 
SNPsnmf=read.table("~/honours_resubmission/populations.snp.resubmission72.snp.id.txt", header=FALSE)

snmf_pvalues=cbind(SNPsnmf, pvaluessnmf)

snmf_pvalues_no_na <- na.omit(snmf_pvalues)

write.table(snmf_pvalues, "All_Pvalues.txt", sep="\t", quote=FALSE)

quantile(snmf_pvalues_no_na$pvaluessnmf, probs = c(0.05, 0.95))      
#         5%         95% 
#0.008229459 0.951375485 

top_1percent_snmf <- subset(
	snmf_pvalues_no_na, 
	snmf_pvalues_no_na$pvaluessnmf <= 0.008229459)

colnames(top_1percent_snmf) <- c("LOCUS","PVALUE")

write.table(top_1percent_snmf,
 "outliers_snmf.txt", sep="\t",
 quote=FALSE, row.names = FALSE)

top_1percent_snmfsnmf_outliers <- top_1percent_snmf$LOCUS

snmf_outliers <- top_1percent_snmf$LOCUS

write.table("snmf_outliers_loci.txt",
 sep="\t", quote=FALSE, row.names = FALSE)

snmf_outliers

length(snmf_outliers)