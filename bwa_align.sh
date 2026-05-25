#!/bin/bash
#$ -N bwa_align_dog
#$ -cwd
#$ -l h_data=32G,h_rt=24:00:00
#$ -pe shared 4
#$ -m bea
#$ -o bwa_align.log
#$ -e bwa_align.err

source /u/local/Modules/default/init/bash
module load bwa
module load samtools

bwa mem -t 4 \
  ../reference/UU_Cfam_GSD_1.0_ROSY.fa \
  ../raw_fastq/DRR608889_1.fastq \
  ../raw_fastq/DRR608889_2.fastq | \
  samtools view -@ 2 -bS - > DRR608889.bam

samtools sort -@ 2 -o DRR608889.sorted.bam DRR608889.bam
samtools index DRR608889.sorted.bam
