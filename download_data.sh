#!/bin/bash
#$ -N download_sra
#$ -cwd
#$ -l h_data=16G,h_rt=24:00:00
#$ -pe shared 8
#$ -m bea
#$ -o download.log
#$ -e download.err

source /u/local/Modules/default/init/bash

cd $SGE_O_WORKDIR/raw_fastq

module load sra-tools/2.10.9
prefetch $1
fasterq-dump $1/$1.sra -O ./ --split-files --threads 8 --progress
