#!/usr/bin/env bash
####################################################################################################
### Peak sorter.
### Sorts the 82 4000m peaks of the Alps from highest to lowest.
### Authors: introducton to git course, SIB.
####################################################################################################

# Input arguments. These files must be located in the current working directory.
INPUT_FILE='alpine_peaks_input.txt'
OUTPUT_FILE='sorted_peaks.txt'
DAHU_TABLE='dahu_counts.txt'
echo "### Starting peak sorter script..."

# Retrieve number of the column that contains the peak elevation information.
COL_NB=$(head -n1 $INPUT_FILE | tr '\t' '\n' | grep -n ALTITUDE | cut -f1 -d':')


# Add dahu counts for each peak to output table.
PEAK_COL_NB1=$(head -n1 $INPUT_FILE | tr '\t' '\n' | grep -n PEAK | cut -f1 -d':')
PEAK_COL_NB2=$(head -n1 $DAHU_TABLE | tr '\t' '\n' | grep -n PEAK | cut -f1 -d':')
cat <( paste <(head -n1 $INPUT_FILE) <(head -n1 $DAHU_TABLE | cut -f2) | sed 's@ @\t@g' ) \
    <( join -t$'\t' -1 $PEAK_COL_NB1 -2 $PEAK_COL_NB2 \
       <( tail -n+2 $INPUT_FILE | sort -k1 )  \
       <( tail -n+2 $DAHU_TABLE | sort -k1 )) > "${OUTPUT_FILE}.tmp"


# Sort peak list by summit elevation, from highest to lowest. Save output as a new file.
cat <( head -n1 ${OUTPUT_FILE}.tmp ) \
    <( tail -n+2 ${OUTPUT_FILE}.tmp | sort -nr -k $COL_NB) > $OUTPUT_FILE
rm "${OUTPUT_FILE}.tmp"
echo "### Completed peak sorter script. Output file is: $OUTPUT_FILE"
echo "### The highest peak in the Alps is: $( head -n2 $OUTPUT_FILE | tail -n1 | cut -f1,2 )"
DAHU_COUNT=$(head -n2 $OUTPUT_FILE | tail -n1 | cut -f5)
echo "### The number of Dahus on the Alps' highest peak is: $DAHU_COUNT"

####################################################################################################
