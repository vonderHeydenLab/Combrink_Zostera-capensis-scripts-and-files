Scripts and files for Combrink et al. 2024. 

populations.snp.resubmission96.vcf - vcf file for our n = 96 dataset outputs from the populations program (STACKS, Catchen et al. 2011). 

populations.snp.resubmission72.vcf - vcf file for our n = 72 dataset outputs from the populations program (STACKS, Catchen et al. 2011). 

populations.snp.resubmission72.snp.id.txt - list of SNPs for our n = 72 dataset.

populations.snp.resubmission72_outlier.vcf - vcf file for our neutral n = 72 dataset (STACKS, Catchen et al. 2011). 

populations.snp.resubmission72_neutral.vcf - vcf file for our outlier n = 72 dataset (STACKS, Catchen et al. 2011). 

01_process_radtags.sh - bash script for process_radtags (STACKS, Catchen et al. 2011). 

02_fastqc.sh - bash script for fastqc (Andrews 2010).

03_multiqc.sh - bash script for multiqc (Ewels  2016)

04_ustacks_96.sh - bash script for ustacks on our n = 96 dataset (STACKS, Catchen et al. 2011). 

04_pipeline_96.sh - bash script for the remaining STACKS pipeline on our n = 96 dataset (STACKS, Catchen et al. 2011).

05_missing_data_indv.sh - Z shell script for generating proportions of missing data using vcftools (Danecek et al. 2011).

06_duplicate_indv.sh - Z shell script for generating —relatedness2 outputs using vcftools (Danecek et al. 2011).

07_clone_detect_relatedness2.sh - Z shell script for clone detections analysis using -relatedness2 in VCFtools v3.0 (Danecek et al. 2011).

07_clone_detect_jaccard.sh - Z shell script for clone detections analysis using Jaccard Index based on shared heterozygosity (Yu et al. 2022).

08_ustacks_72.sh - bash script for ustacks on our n = 72 dataset (STACKS, Catchen et al. 2011). 

08_pipeline_72.sh - bash script for the remaining STACKS pipeline on our n = 72 dataset (STACKS, Catchen et al. 2011).

09_investig_missing.sh - R script for investigating missing data (multiple packages).

10_bayescan_01.sh - bash script for running BayeScan (Foll & Gaggiotti 2008). 

10_bayescan_02.sh - R script for analysing BayeScan (Foll & Gaggiotti 2008). 

10_snmf_01.sh - bash script for creating an sNMF project for our full dataset (Frichot et al. 2014). 

10_snmf_02.sh - R script for running sNMF (Frichot et al. 2014). 

10_snmf_03.sh - R script for analysing sNMF (Frichot et al. 2014).

10_pcadapt.sh - R script for running PCadapt outlier analysis (Luu 2017). 

11_snmf_neut_01.sh - bash script for creating an sNMF project for our neutral dataset (Frichot et al. 2014). 

11_snmf_neut_02.sh - R script for running an sNMF project for our neutral dataset (Frichot et al. 2014). 

11_snmf_outl_01.sh - bash script for creating an sNMF project for our outlier dataset (Frichot et al. 2014). 

11_snmf_outl_02.sh - R script for running an sNMF project for our outlier dataset (Frichot et al. 2014). 

12_lea_full_k2.sh - R script for plotting our full sNMF admixture plot at K = 2 (Frichot et al. 2014). 

12_lea_full_k.sh - R script for plotting our full sNMF admixture plot (Frichot et al. 2014). 

12_lea_neut_k.sh - R script for plotting our neutral sNMF admixture plot (Frichot et al. 2014). 

12_lea_out_k.sh - R script for plotting our outlier sNMF admixture plot (Frichot et al. 2014). 

13_pca.sh - R script for plotting PCAs in adegenet (Luu et al. 2017).

13_popstats.sh - R script for population statistics (multiple packages).