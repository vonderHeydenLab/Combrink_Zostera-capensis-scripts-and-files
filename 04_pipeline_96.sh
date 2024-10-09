#!/bin/bash 
#PBS -N CHAR_cstacksonward_resubmission_72
#PBS -l select=1:ncpus=16
#PBS -l walltime=48:00:00 
#PBS -m e
#PBS -M 25405942@sun.ac.za

cd $PBS_O_WORKDIR 
module load app/stacks/2.59 

#remainder of pipeline (renamed files, code not included)
cstacks -P ~/honours_resubmission/populations_outputs/ -M ~/honours/info/char_popmap_original -n 1 -p 16
sstacks -P ~/honours_resubmission/populations_outputs/ -M ~/honours/info/char_popmap_original -p 16
tsv2bam -P ~/honours_resubmission/populations_outputs/ -M ~/honours/info/char_popmap_original -R ~/honours/01_processradtags/renamed/ -t 16
gstacks -P ~/honours_resubmission/populations_outputs/ -M ~/honours/info/char_popmap_original -t 16
populations \
-P ~/honours/03_pipeline/ \
-M ~/honours/info/char_popmap_original \
-O ~/honours_resubmission/no_r_resubmission \
-t 16 --min-samples-per-pop 0.7 --min-samples-overall 0.7 --min-mac 3 \
--write-random-snp --fstats --structure --plink --genepop --hwe --fstat --vcf