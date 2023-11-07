#!/bin/bash

base_url="https://42basepairs.com/download/s3/ont-open-data/cliveome_kit14_2022.05/gdna/flowcells/ONLA29134/20220510_1127_5H_PAM63974_a5e7a202/fast5_pass/PAM63974_pass_58881fec_"

# Specify the number of files you want to download
total_files=584

# Destination directory where you want to save the downloaded files
destination_dir="."

# Loop through and download the files
for ((i=0; i<total_files; i++)); do
    filename="PAM63974_pass_58881fec_${i}.fast5"
    url="${base_url}${i}.fast5"

    # Use curl to download the file
    curl -O "$url" -C -
#    echo $url
done
