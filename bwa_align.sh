#!/bin/bash
#$ -N bwa_align
#$ -cwd
#$ -l h_data=32G,h_rt=24:00:00
#$ -pe shared 4
#$ -m bea
#$ -o align.log
#$ -e align.err

source /u/local/Modules/default/init/bash
module load bwa
module load samtools

cd "${SGE_O_WORKDIR:-.}/bam"

bwa mem -t 4 \
  ../reference/UU_Cfam_GSD_1.0_ROSY.fa \
  ../raw_fastq/$1_1.fastq \
  ../raw_fastq/$1_2.fastq | \
  samtools view -@ 2 -bS - > $1.bam

samtools sort -@ 2 -o $1.sorted.bam $1.bam
samtools index $1.sorted.bam
