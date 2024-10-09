#!/bin/bash
#PBS -N multiqc_Char
#PBS -l select=1:ncpus=16
#PBS -l walltime=00:59:00
#PBS -m e
#PBS -M 25405942@sun.ac.za

cd $PBS_O_WORKDIR
module load app/multiqc/1.14

multiqc ~/02_fastqc -o ~/02_multiqc