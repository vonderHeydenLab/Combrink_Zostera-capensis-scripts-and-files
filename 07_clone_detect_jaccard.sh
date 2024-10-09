#Clone analysis: Jaccard Index based on shared heterozygosity (Yu et al. 2022)

#Requirements:
	#A vcf file containing bi-allelic SNPs for diploid species
	#SH_pair.py (provided: https://github.com/leiyu37/Detecting-clonemates?tab=readme-ov-file) 
	#generateAllPairs.py (povided: https://github.com/leiyu37/Detecting-clonemates?tab=readme-ov-file)
	#plot.R -- I remanmed this file to plotR_clonedetection2 (provided: https://github.com/leiyu37/Detecting-clonemates?tab=readme-ov-file)

#Generating a bash script for all combinations of two samples
./generateAllPairs.py ./SH_pair.py ./populations.snp.resubmission84copy.vcf

#Calculating pairwise SH indices
./SH_pair.py ./populations.snp.resubmission84copy.vcf P01-A01-na-KA2 P01-A02-na-KA17 P01-A01-na-KA2_P01-A02-na-KA17_SH.txt
./SH_pair.py ./populations.snp.resubmission84copy.vcf P01-A01-na-KA2 P01-A03-na-BU4 P01-A01-na-KA2_P01-A03-na-BU4_SH.txt
./SH_pair.py ./populations.snp.resubmission84copy.vcf P01-A01-na-KA2 P01-A04-na-SW9 P01-A01-na-KA2_P01-A04-na-SW9_SH.txt
./SH_pair.py ./populations.snp.resubmission84copy.vcf	P01-A01-na-KA2 P01-A05-na-BU14 P01-A01-na-KA2_P01-A05-na-BU14_SH.txt
... 

#Too many possible pairs to do this manually:
#Opened the allPairs.sh output generated above in excel using wizard and deleted the first column. 
#Pasted the data in sublime text and replaced tabs with spaces using the find & replace function.  
./Jaccard_code_formulation_cont

#Combining the results of all sample pairs
cat P01-A01-na-KA2_P01-A02-na-KA17_SH.txt | awk 'NR==1' >header.txt
cat *_SH.txt | awk '!/^X1/' >contents.txt
cat header.txt contents.txt >combine.txt

#NB add a technical replicate column (see github example) because R code calls on it.
Rscript plotR_clonedetection2.r