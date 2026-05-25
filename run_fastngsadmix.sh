#!/bin/bash
#$ -N run_admix
#$ -cwd
#$ -l h_data=4G,h_rt=02:00:00
#$ -pe shared 1
#$ -m bea
#$ -o admix.log
#$ -e admix.err

source /u/local/Modules/default/init/bash

mkdir -p ../results

../fastNGSadmix/fastNGSadmix \
  -likes ../ANGSD_results/DRR608889_final.beagle.gz \
  -fname ../snp_panel/fastNGSadmix_ref.txt \
  -Nname ../snp_panel/nInd.txt \
  -out ../results/admixResults \
  -whichPops all
