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
