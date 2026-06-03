#!/bin/bash
#$ -N run_plink
#$ -cwd
#$ -l h_data=8G,h_rt=04:00:00
#$ -pe shared 4
#$ -m bea
#$ -o plink.log
#$ -e plink.err

source /u/local/Modules/default/init/bash
module load plink

cd "${SGE_O_WORKDIR:-.}"

plink \
  --bfile snp_panel/snps_final_26_04_06_6\
  --freq \
  --keep-allele-order \
  --within snp_panel/dogPop.txt \
  --chr-set 38 \
  --out snp_panel/dogBreedFreqs_clean
