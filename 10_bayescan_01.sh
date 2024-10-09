#!/bin/bash
#PBS -N CHAR_bayescan_01
#PBS -l select=1:ncpus=8
#PBS -l walltime=96:00:00
#PBS -m e
#PBS -M 25405942@sun.ac.za

cd ${PBS_O_WORKDIR}
module load app/BayeScan/2.1

BayeScan2.1_linux64bits \
~/honours_resubmission/bayescan_input_resubmission_72 \
-snp -o ~/honours_resubmission/04_bayescan/ \
-threads 16 -n 5000 -thin 10 -nbp 20 -pilot 5000 \
-burn 50000 -pr_odds 10