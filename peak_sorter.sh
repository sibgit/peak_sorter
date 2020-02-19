#!/usr/bin/env bash
####################################################################################################
### Peak sorter.
### Sorts the 82 4000m peaks of the Alps from highest to lowest.
### Authors: SIB git course 2020.
####################################################################################################

# Input arguments for script.
INPUT_FILE='alpine_peaks_input.txt'
OUTPUT_FILE='sorted_peaks.txt'
echo "### Starting peak sorter script..."

# Retrieve number of the column that contains the peak elevation information.
COL_NB=$(head -n1 $INPUT_FILE | tr '\t' '\n' | grep -n ALTITUDE | cut -f1 -d':')

# Sort alpine peak list by summit elevation, from highest to lowest.
cat <( head -n1 $INPUT_FILE ) <( tail -n+2 $INPUT_FILE | sort -nr -k $COL_NB) > $OUTPUT_FILE
echo "### Completed peak sorter script. Output file is: $OUTPUT_FILE"
echo "### The highest peak in the Alps is: $( head -n2 $OUTPUT_FILE | tail -n1 | cut -f1,2 )"
####################################################################################################
