# FastNGSadmix
Implementation of FastNGSAdmix (https://www.popgen.dk/software/index.php/FastNGSadmix) for low coverage WGS data

## Overview
This pipeline determines the breed ancestry of an unknown dog sample using low-depth Next-Generation Sequencing (NGS) data. Unlike traditional admixture tools, this workflow utilizes Genotype Likelihoods (via ANGSD) to account for sequencing uncertainty, providing highly accurate results without requiring called genotypes.

## Prerequisites


## Pipeline Steps
1. **Alignment:** Raw fastq files are aligned to the ROSY German Shepherd reference genome using BWA-MEM.
2. **Genotype Likelihoods:** ANGSD calculates the statistical probability of genotypes at known variant sites, outputting a beagle format file.
3. **Reference Panel Preparation:** PLINK calculates allele frequencies for known purebred populations.
4. **Admixture Estimation:** fastNGSadmix uses the likelihoods and the reference panel to estimate breed proportions.

## Usage

1. **Software Installation:**
 * Clone and compile ANGSD via git clone [https://github.com/ANGSD/angsd.git](https://github.com/ANGSD/angsd.git) and make.
 * Clone and compile FastNGSAdmix via git clone [https://github.com/e-jorsboe/fastNGSadmix.git](https://github.com/e-jorsboe/fastNGSadmix.git) and make.
2. **Data:**
   * Obtain files for the reference genome or download via NIH. Local files must have all of .bed, .bim, and .fam.
   * Obtain the sample via SRA. Example script in download_data.sh
   * Obtain SNP list (in /data/SNPs.txt)
   * Obtain population info (/data/dogPop.txt)
3. **Index and alignment of the reference genome:** Index the .fa reference using bwa, then perform alignment by running bwa_align.sh (qsub can be used) 
4. **Generate genotype likelihoods:** Calculate genotype probabilities for the sample. Run_angsd.sh (qsub can be used)
5. **Calculate allele frequencies:** Use PLINK to calculate the baseline allele frequencies for the  population in the reference panel. Run run_plink.sh (qsub can be used) 
6. **Reformatting the reference panel:** Reformat the generated file from plink to convert to wide format, generate a separate .txt file with the number of individuals per breed. Run make_fastngs_ref.py)
7. **Estimate admixture:** Run: run_fastngsadmix.sh (qsub can be used) 
