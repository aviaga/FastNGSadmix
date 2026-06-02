#!/bin/bash
#$ -N run_angsd
#$ -cwd
#$ -l h_data=8G,h_rt=12:00:00
#$ -pe shared 4
#$ -m bea
#$ -o angsd.log
#$ -e angsd.err

cd "${SGE_O_WORKDIR:-.}"
SAMPLE=$1

# File Paths (Relative to project root)
RAW_SNPS="snp_panel/SNPs.txt"
SITES_FILE="snp_panel/SNPs.sites4ANGSD.txt"
BAM_FILE="bam/${SAMPLE}.sorted.bam"
OUT_DIR="ANGSD_results"
ANGSD_EXEC="angsd/angsd"

mkdir -p $OUT_DIR

awk -F':' '{ print $1, $2, $3, $4 }' $RAW_SNPS > $SITES_FILE

$ANGSD_EXEC sites index $SITES_FILE

# Run ANGSD using the dynamic sample name
$ANGSD_EXEC \
  -i $BAM_FILE \
  -GL 2 \
  -doGlf 2 \
  -doMajorMinor 3 \
  -doMaf 1 \
  -minMapQ 0 \
  -minQ 0 \
  -sites $SITES_FILE \
  -out $OUT_DIR/${SAMPLE}_final
