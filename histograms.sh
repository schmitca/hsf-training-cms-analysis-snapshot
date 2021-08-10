#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$INPUT_DIR

# Throw an error message and exit if no arguments are supplied, or if more than two are supplied
if [ $# -eq 0 ]; then
    echo "ERROR: No arguments supplied. Please supply either one or two arguments."
    echo "Argument 1: Path to input root files. Will also output histograms to this path if no second argument provided."
    echo "Argument 2 (optional): Path to which output histograms should be written. Defaults to input path if argument 2 not provided."
    exit 1
fi

if [ $# -gt 2 ]; then
    echo "ERROR: Too many arguments supplied. Please supply either one or two arguments."
    echo "Argument 1: Path to input root files. Will also output histograms to this path if no second argument provided."
    echo "Argument 2 (optional): Path to which output histograms should be written. Defaults to input path if argument 2 not provided."
    exit 1
fi

# If two arguments are supplied, set the output dir to the second argument
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
