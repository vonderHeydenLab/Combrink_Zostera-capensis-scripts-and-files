#Generate —relatedness2 outputs using vcftools (Danecek et al. 2011).
vcftools \
--vcf /Users/Charlotte/Documents/Bioinformatics/Resubmission/populations.snp.resubmission90.vcf \
--relatedness2 --out /Users/Charlotte/Documents/Bioinformatics/Resubmission/Clone_detection1/nucleotide_diversity_resubmission90

#Removing highly related individuals
vcftools \
--vcf /Users/Charlotte/Documents/Bioinformatics/Resubmission/populations.snp.resubmission90.vcf \
--remove-indv P01-E01-na-KA15 --remove-indv P01-E02-na-BU12 --remove-indv P01-B10-na-NA7 \
--remove-indv P01-B09-na-NA8 --remove-indv P01-E07-na-NA5 --remove-indv P01-F07-na-NA19 \
--recode --recode-INFO-all \
--out /Users/Charlotte/Documents/Bioinformatics/Resubmission/populations.snp.resubmission84.vcf \
--stdout | gzip -c > /Users/Charlotte/Documents/Bioinformatics/Resubmission/populations.snp.resubmission84.vcf.gz