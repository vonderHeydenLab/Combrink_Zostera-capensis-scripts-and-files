#!/bin/bash
#PBS -N fastqc_Char
#PBS -l select=1:ncpus=16
#PBS -l walltime=2:00:00
#PBS -m e
#PBS -M 25405942@sun.ac.za

cd $PBS_O_WORKDIR
module load app/fastqc/0.11.5

for i in $(cat ~/samplelist.txt)
do
fastqc ~/01_processradtags/*.fq -o ~/02_fastqc
done