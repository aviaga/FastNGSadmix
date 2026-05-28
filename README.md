# FastNGSadmix
Implementation of FastNGSAdmix (https://www.popgen.dk/software/index.php/FastNGSadmix) for low coverage WGS data

## Overview
This pipeline determines the breed ancestry of an unknown dog sample using low-depth Next-Generation Sequencing (NGS) data. 


## Pipeline Steps
1. **Alignment:** Raw fastq files are aligned to the ROSY reference genome using BWA-MEM.
2. **Genotype Likelihoods:** ANGSD calculates the statistical probability of genotypes at known SNP sites, outputting a beagle format file.
3. **Reference Panel Preparation:** PLINK calculates allele frequencies for known populations.
4. **Admixture Estimation:** fastNGSadmix uses the likelihoods and the reference panel to estimate breed proportions.

## Usage

1.  **File structure/organization:**
   Run: mkdir -p dog_admixture/{reference,raw_fastq,sra,bam,ANGSD_results,snp_panel,scripts,fastngsadmix}
2.  **Software Installation:**
   * Go to the dog_admixture root directory. Then clone, compile, and make ANGSD [https://github.com/ANGSD/angsd.git](https://github.com/ANGSD/angsd.git).
     * git clone https://github.com/ANGSD/angsd.git angsd
     * cd angsd
     * make 
   *  Go to the dog_admixture/fastngsadmix directory. Then clone, compile, and make FastNGSAdmix via git clone [https://github.com/e-jorsboe/fastNGSadmix.git](https://github.com/e-jorsboe/fastNGSadmix.git).
     * git clone https://github.com/e-jorsboe/fastNGSadmix.git fastNGSadmix
     * cd fastNGSadmix
     * make 
3. **Data:**
   * Obtain files for the reference genome or download via NIH. Local files must have all of .fa, .bed, .bim, and .fam. The .fa file should be placed in /reference and all other files should be in snp_panel. 
   * Obtain the sample via SRA. Example script in download_data.sh. Place this script in the scripts directory and can be run from root as: bash scripts/download_data.sh <sample_name> (qsub can also be used) 
   * Obtain SNP list and place it under the snp_panel directory 
   * Obtain population info and place it under snp_panel directory
4. **Index and alignment of the reference genome:**
     * Index the .fa reference using bwa by loading the module (module load bwa), followed by bwa index <reference_name>.fa
     * Place bwa_align.sh in scripts, then perform alignment by running from root: bash scripts/bwa_align.sh <sample_name> (qsub can be used) 
5. **Generate genotype likelihoods:** Calculate genotype probabilities for the sample. Place run_angsd.sh in scripts, from root run: bash scripts/run_angsd.sh <sample_name> (qsub can be used)
6. **Calculate allele frequencies:** Use PLINK to calculate the baseline allele frequencies for the  population in the reference panel. Place run_plink.sh in scripts, from root run: bash scripts/run_plink.sh (qsub can be used) 
7. **Reformatting the reference panel:** Reformat the generated file from plink to convert to wide format, generate a separate .txt file with the number of individuals per breed. Place make_fastngs_ref.py in scripts, from root run: python3 scripts/make_fastngs_ref.py
8. **Estimate admixture:** Run: Place run_fastngsadmix.sh in scripts, and run from root: bash scripts/run_fastngsadmix.sh (qsub can be used) 
