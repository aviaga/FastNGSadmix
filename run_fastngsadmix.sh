#!/bin/bash
#$ -N run_admix
#$ -cwd
#$ -l h_data=4G,h_rt=02:00:00
#$ -pe shared 4
#$ -m bea
#$ -o admix.log
#$ -e admix.err

source /u/local/Modules/default/init/bash

cd "${SGE_O_WORKDIR:-.}"

SAMPLE=$1

mkdir -p results

fastngsadmix/fastNGSadmix/fastNGSadmix \
  -likes ANGSD_results/${SAMPLE}_final.beagle.gz \
  -fname fastngsadmix/fastNGSadmix_ref.txt \
  -Nname fastngsadmix/nInd.txt \
  -out results/${SAMPLE}_admix \
  -whichPops all
