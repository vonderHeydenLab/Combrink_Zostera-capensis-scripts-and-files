install.packages("pcadapt")
library (pcadapt) 

#read bed:
bedfile <- system.file("extdata", "populations.bed", package = "pcadapt")
mat <- bed2matrix("populations.bed")
dim(mat) #96 2401
table(mat)
#     0      1      2
#     11730  35580  158234

read.pcadapt.output <- read.pcadapt(
mat,
type = c("lfmm"),
)

pc.adapt.output.findK <- pcadapt(
read.pcadapt.output,
K = 15,
method = "mahalanobis",
min.maf = 0.05,
ploidy = 2,
LD.clumping = NULL,
pca.only = FALSE,
tol = 1e-04
)

popmap_72 <- read.delim("/Users/Charlotte/Documents/Bioinformatics/Resubmission/popmap_72", header=FALSE, na.strings="")
popmap <- popmap_72
View(popmap)

poplist.int <-popmap [ , "V2"]
View(poplist.int)

plot.manhattan_screeplot <- plot(
pc.adapt.output.findK,
option = "screeplot",
i = 1,
j = 2,
pop = poplist.int,
#col = c("red","green", "blue", "pink", "orange"),
chr.info = NULL,
snp.info = NULL,
plt.pkg = "ggplot",
K = NULL
) #K=4

plot.manhattan <- plot(
pc.adapt.output.findK,
option = "manhattan",
i = 1,
j = 2,
pop = poplist.int,
#col =  c("#21918c","#3b528b","#5ec962","#440154","#fde725"),
chr.info = NULL,
snp.info = NULL,
plt.pkg = "ggplot",
K = NULL
)

library(qvalue)
qval <- qvalue(pc.adapt.output.findK$pvalues)$qvalues
alpha <- 0.05
outliers <- which(qval < alpha)
length(outliers) #252
print(outliers)

snp_list=read.table("/Users/Charlotte/Documents/Bioinformatics/Resubmission/populations.snp.resubmission72.snp.id.txt", header=FALSE)
snps_qvalues <- cbind(snp_list, qval)
View(snps_qvalues)
write.table(snps_qvalues, "All_Pvalues.txt", sep="\t", quote=FALSE)
All_Pvalues<-read.table("All_Pvalues.txt")
View(snps_qvalues)

snps_qvalues_no_na <- na.omit(snps_qvalues)
View(snps_qvalues_no_na)

snps_qvalues_0.5 <- snps_qvalues_no_na[snps_qvalues_no_na$qval <= 0.05, ]
View(snps_qvalues_0.5)
outliers.pca<-snps_qvalues_0.5[ ,1]
View(outliers.pca)
