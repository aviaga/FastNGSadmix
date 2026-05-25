# FastNGSadmix
Implementation of FastNGSAdmix (https://www.popgen.dk/software/index.php/FastNGSadmix) for low coverage WGS data

## Overview
This pipeline determines the breed ancestry of an unknown dog sample using low-depth Next-Generation Sequencing (NGS) data. Unlike traditional admixture tools, this workflow utilizes Genotype Likelihoods (via ANGSD) to account for sequencing uncertainty, providing highly accurate results without requiring called genotypes.

## Prerequisites


## Pipeline Steps
1. **Alignment:** Raw fastq files are aligned to the ROSY German Shepherd reference genome using BWA-MEM.
2. **Genotype Likelihoods:** ANGSD calculates the statistical probability of genotypes at known variant sites, outputting a beagle format file.
3. **Reference Panel Preparation:** PLINK calculates allele frequencies for known purebred populations. A custom Python script (`make_fastngs_ref.py`) reformats this data into the strict wide-format required by fastNGSadmix.
4. **Admixture Estimation:** fastNGSadmix uses the likelihoods and the reference panel to estimate breed proportions.

## Usage
1. Reference Genome: Obtain files for the reference genome or download via NIH. Local files must have all of .bed, .bim, and .fam.
2. Obtain the sample via SRA. Example script in download_data.sh
3. Index the reference genome using bwa. Example below:
  1. module load bwa
  2. bwa index UU_Cfam_GSD_1.0_ROSY.fa

4. Perform alignment, run bwa_align.sh
5. Make ANGSD: https://github.com/ANGSD/angsd
6. Obtain SNP list and then run ANGSD: run_angsd.sh
7. Breed annotations are in dogPop.txt. Run Plink using that: run_plink.sh
8. Reformat the generated reference file and generate a separate .txt file with the number of individuals per breed (run make_fastngs_ref.py)
9. Make FastNGSadmix: https://github.com/e-jorsboe/fastNGSadmix.git
10. Run FastNGSadmix: run_fastngsadmix.sh
