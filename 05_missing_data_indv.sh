#Generate proportions of missing data in vcftools (Danecek et al. 2011)
vcftools \
--vcf /Users/Charlotte/Documents/Bioinformatics/Resubmission/Populations_outputs/populations.snp.resubmission96.vcf \
--missing-indv --out populations.snp.resubmission96.vcf

#quit vcf 
q 

#print vcftools missing data outputs
less populations.snp.resubmission96.vcf.imiss

#filter individuals missing >=40% data 
awk '$5 > 0.4' populations.snp.resubmission96.vcf.imiss | cut -f1 > lowDP.indv
vcftools \
--vcf /Users/Charlotte/Documents/Bioinformatics/Resubmission/Populations_outputs/populations.snp.resubmission96.vcf \
--remove lowDP.indv --recode --recode-INFO-all --out populations.snp.resubmission96.lowremoved.vcf