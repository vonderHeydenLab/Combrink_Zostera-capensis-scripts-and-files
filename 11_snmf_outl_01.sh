#!/bin/bash
#PBS -N CHAR_snmf_outlier
#PBS -l select=1:ncpus=16:mem=32GB
#PBS -l walltime=96:00:00
#PBS -m be
#PBS -M 25405942@sun.ac.za

cd $PBS_O_WORKDIR

module load app/R/4.3.2
R --file=11_snmf_outl_02