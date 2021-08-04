#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$INPUT_DIR

if [ $# -eq 2 ]; then
OUTPUT_DIR=$2
fi

# Produce histograms from skimmed samples
while IFS=, read -r SAMPLE PROCESS
do
    INPUT=${INPUT_DIR}/${SAMPLE}Skim.root
    OUTPUT=${OUTPUT_DIR}/histograms_${PROCESS}.root
    python histograms.py $INPUT $PROCESS $OUTPUT
done < histograms.csv

# Merge histograms in a single file
hadd -f ${OUTPUT_DIR}/histograms.root ${OUTPUT_DIR}/histograms_*.root
