#!/bin/bash
#PBS -N Process_radtags_Char
#PBS -l select=1:ncpus=16
#PBS -l walltime=48:00:00
#PBS -m e
#PBS -M 25405942@sun.ac.za

cd $PBS_O_WORKDIR

module load app/stacks/2.59

for i in $(cat ~/samplelist.txt)
do
process_radtags --paired -1 ~/Data/RAW/$i"_R1.fastq" -2 ~/Data/RAW/$i"_R2.fastq" -o ~/01_processradtags/ --renz_1 'PstI' --renz_2 'MseI' -c -q -r -s 20 &> process_radtags.oe
done