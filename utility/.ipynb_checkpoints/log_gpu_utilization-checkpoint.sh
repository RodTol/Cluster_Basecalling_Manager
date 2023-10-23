#!/usr/bin/env bash
run_name=$1
path=$2
echo "Start recording on .csv"
date
nvidia-smi --query-gpu=timestamp,pci.bus_id,utilization.gpu,utilization.memory --format=csv -l 1 -f $path/gpu_log_$run_name.csv
echo "End recording on .csv"
date