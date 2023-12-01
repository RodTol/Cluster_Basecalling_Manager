#!/bin/bash

for i in {1..8}; do
    echo "Run with ${i} gpus"
    ./run.sh /AB_20T_input/dataset/subset_122G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/linear_scaling_output $i > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/linear_scaling/run_${i}_gpus.txt 2>&1
done


