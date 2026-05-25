#!/bin/bash
module load sra-tools/2.10.9
prefetch DRR608889
fasterq-dump DRR608889/DRR608889.sra -O ./ --split-files --threads 8 --progress
