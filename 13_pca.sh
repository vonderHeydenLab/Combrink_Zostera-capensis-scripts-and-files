if (!require("LEA", quietly = TRUE))
  install.packages("LEA")
library(LEA)

#NB need to manually at ".stru" to your structure file from Stacks output and delete line 1 (header)
populations.structure<-read.structure("/Users/Charlotte/Documents/Bioinformatics/Resubmission/Populations_outputs/populations.structure.stru") 
View(populations.structure)

#Change : to _ using find and replace 
removeloc_underscore<-c("958_121",
                        "1607_15",
                        "2087_66",
                        "2934_70",
                        "3148_66",
                        "3193_114",
                        "3762_234",
                        "4967_51",
                        "5099_301",
                        "5230_196",
                        "5925_77",
                        "6029_46",
                        "6169_54",
                        "6453_22",
                        "6546_74",
                        "7166_206",
                        "7522_265",
                        "7997_81",
                        "8016_119",
                        "8273_156",
                        "8275_119",
                        "8445_148",
                        "8519_202",
                        "8612_191",
                        "8922_160",
                        "9419_10",
                        "9590_67",
                        "9992_167",
                        "11255_77",
                        "11735_276",
                        "12261_197",
                        "101989_147")

loc_to_keep <- setdiff(locNames(populations.structure), removeloc_underscore)

View(loc_to_keep)
write.table(loc_to_keep, "inliers2.txt", row.names=F, quote=F)

neutral.structure<-populations.structure[loc = loc_to_keep]
outlier.structure<-populations.structure[loc = removeloc_underscore]

View(neutral.structure)
View(outlier.structure) 

#full
x.zostera <- tab(populations.structure, freq=TRUE, NA.method="mean")
pca.zostera <- dudi.pca(x.zostera, center=TRUE, scale=FALSE, nf=4, scannf = FALSE)

#neutral
x.zostera.neutral <- tab(neutral.structure, freq=TRUE, NA.method="mean")
pca.zostera.neutral <- dudi.pca(x.zostera.neutral, center=TRUE, scale=FALSE, nf=4, scannf = FALSE)

#outlier
x.zostera.outlier <- tab(outlier.structure, freq=TRUE, NA.method="mean")
pca.zostera.outlier <- dudi.pca(x.zostera.outlier, center=TRUE, scale=FALSE, nf=4, scannf = FALSE)

#axes 1 and 2
#full
s.class(pca.zostera$li, 
        fac=pop(populations.structure),
        col=transp((values=c("#addc30","#21918c","#CC7722","#3b528b","#440154")),.8),
        #scale_fill_manual(values=c("#21918c","#3b528b","#5ec962","#440154","#fde725"),
        #title = "Title",
        axesel=FALSE, cstar=0, cpoint=5, clabel=2.5) 

#netural
s.class(pca.zostera.neutral$li, 
        fac=pop(neutral.structure),
        col=transp((values=c("#addc30","#21918c","#CC7722","#3b528b","#440154")),0.8),
        #scale_fill_manual(values=c("#21918c","#3b528b","#5ec962","#440154","#fde725"),
        axesel=FALSE, cstar=0, cpoint=5, clabel=2.5)

#outlier 
s.class(pca.zostera.outlier$li, 
        fac=pop(outlier.structure),
        col=transp((values=c("#addc30","#21918c","#CC7722","#3b528b","#440154")),0.8),
        #scale_fill_manual(values=c("#21918c","#3b528b","#5ec962","#440154","#fde725"),
        axesel=FALSE, cstar=0, cpoint=5, clabel=2.5)
