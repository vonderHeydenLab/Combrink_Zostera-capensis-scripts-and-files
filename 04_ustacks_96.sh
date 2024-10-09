#!/bin/bash
#PBS -N pipeline_resubmission_try2
#PBS -l select=1:ncpus=16
#PBS -l walltime=48:00:00
#PBS -m e
#PBS -M 25405942@sun.ac.za

cd $PBS_O_WORKDIR
module load app/stacks/2.59

#ustacks
id=1
for i in $(cat ~/honours_resubmission/samplelist96.txt)
do
 ustacks -f ~/honours/01_processradtags/$i"_R1.1.fq" -o ~/honours_resubmission/populations_outputs/ -m 3 -M 2 -i $id -p 16
 let "id+=1"
done