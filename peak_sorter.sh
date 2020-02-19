#!/usr/bin/env bash
####################################################################################################
### Peak sorter.
### Sorts the 82 4000m peaks of the Alps from highest to lowest.
####################################################################################################

# Input arguments.
INPUT_FILE='alpine_peaks_input.txt'
OUTPUT_FILE='sorted_peaks.txt'
echo "### Starting peak sorter script..."


# Verify the data contains a column named "ALTITUDE", and a column named "PEAK"
echo -n "### Running data integrity check..."
if [[ $(head -n1 $INPUT_FILE | grep -c "ALTITUDE") -ne 1 ]]; then
    echo "ALTITUDE column is missing in input data" && exit 1
fi
if [[ $(head -n1 $INPUT_FILE | grep -c "PEAK") -ne 1 ]]; then
    echo "PEAK column is missing in input data" && exit 1
fi
echo "OK"


# Retrieve number of the column that contains the peak elevation information.
COL_NB=$(head -n1 $INPUT_FILE | tr '\t' '\n' | grep -n ALTITUDE | cut -f1 -d':')

# Sort peak list by summit elevation, from highest to lowest.
cat <( head -n1 $INPUT_FILE ) <( tail -n+2 $INPUT_FILE | sort -nr -k $COL_NB) > $OUTPUT_FILE
echo "### Completed peak sorter script. Output file is: $OUTPUT_FILE"

####################################################################################################
