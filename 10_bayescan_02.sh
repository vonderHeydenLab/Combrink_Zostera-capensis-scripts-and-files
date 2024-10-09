#Import the SNPs information
snp=read.table("/Users/Charlotte/Documents/Bioinformatics/Resubmission/populations.snp.resubmission72.snp.id.txt",header=FALSE) #2401 SNPs

#Export the R _fst2.txt file to workspace and load below for analysis
bayescan=read.table("/Users/Charlotte/Documents/Bioinformatics/Resubmission/BayeScan2.1/BayeScan_outputs/_fst.txt")

#Merge the names of the outliers with the results from the bayescan dataframe.
snp_bayescan=cbind(snp, bayescan)

#Rename columns.
colnames(snp_bayescan)=c("SNP","PROB","LOG_PO","Q_VALUE","ALPHA","FST")

#Write the results.
write.table(snp_bayescan, "zostera-bayescan-results.txt", quote=FALSE, sep="\t", row.names=FALSE)

View(snp_bayescan)

#Change the value of the Q_VALUE column: 0 == 0.0001.
class(snp_bayescan$Q_VALUE) 

snp_bayescan$Q_VALUE <- as.numeric(snp_bayescan$Q_VALUE)
snp_bayescan[snp_bayescan$Q_VALUE<=0.0001,"Q_VALUE"]=0.0001
View(snp_bayescan)

#Round the values.
snp_bayescan$LOG_PO <- (round(snp_bayescan$LOG_PO, 4))
snp_bayescan$Q_VALUE <- (round(snp_bayescan$Q_VALUE, 4))
snp_bayescan$ALPHA <- (round(snp_bayescan$ALPHA, 4))
snp_bayescan$FST <- (round(snp_bayescan$FST, 6))

#Add a column for the type of selection grouping based on a Q-VALUE < 0.05.
snp_bayescan$SELECTION <- ifelse(snp_bayescan$ALPHA>=0&snp_bayescan$Q_VALUE<=0.05,"diversifying",
ifelse(snp_bayescan$ALPHA>=0&snp_bayescan$Q_VALUE>0.05,"neutral","balancing"))

snp_bayescan$SELECTION<- factor(snp_bayescan$SELECTION)
levels(snp_bayescan$SELECTION)
View(snp_bayescan)

#Save the results of the SNPs potentially under positive (divergent)
#and balancing selection (qvalue < 0.05).
positive <- snp_bayescan[snp_bayescan$SELECTION=="diversifying",]
neutral <- snp_bayescan[snp_bayescan$SELECTION=="neutral",]
balancing <- snp_bayescan[snp_bayescan$SELECTION=="balancing",]

#Check the number of SNPs belonging to each category.
xtabs(data=snp_bayescan, ~SELECTION)

#Write the results of the SNPs potentially under selection (qvalue < 0.05).
write.table(neutral, "neutral.txt", row.names=F, quote=F)
write.table(balancing, "balancing.txt", row.names=F, quote=F)
write.table(positive, "positive.txt", row.names=F, quote=F)

#Transformation Log of the Q value in order to create the ggplot graph.
range(snp_bayescan$Q_VALUE)

snp_bayescan$LOG10_Q <- -log10(snp_bayescan$Q_VALUE)

#Create a title for the ggplot graph.
x_title="Log(q-value)"
y_title="Fst"

#Make the ggplot graph.
ggplot(snp_bayescan,aes(x=LOG10_Q,y=FST)) +
geom_point(aes(fill=SELECTION), pch=21, size=2)+
scale_fill_manual(name="Selection",values=c("white","red","orange"))+
labs(x=x_title)+
labs(y=y_title)+
theme_classic()

bayescan_outliers <- positive$SNP
length(bayescan_outliers) 