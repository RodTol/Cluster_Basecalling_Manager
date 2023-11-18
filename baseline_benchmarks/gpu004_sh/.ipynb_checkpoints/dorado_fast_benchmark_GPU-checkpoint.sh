#!/usr/bin/bash

iftop_path="/u/dssc/tolloi/.local/sbin"
export PATH="$iftop_path:$PATH" 

#activate python venv
source ~/python_venv/nv-dashboard/bin/activate

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

echo -e "${RED}Input directory${RESET}"
echo $1

save_path=$2
echo -e "${RED}Save path${RESET}"
echo $save_path

launch_time=$(date +'%H-%M')
run_name="dorado_fast_${launch_time}_benchmark_gpu004"
echo -e "${RED}Name of this run${RESET}"
echo $run_name

#ceph
#mkdir -p  /u/dssc/tolloi/scratch/benchmark_run_logs/$run_name
#log_path=/u/dssc/tolloi/scratch/benchmark_run_logs/$run_name

#nfs01
mkdir -p  /AB_20T_output/nanopore_output/benchmark_run_logs/$run_name
log_path=/AB_20T_output/nanopore_output/benchmark_run_logs/$run_name

echo -e "${RED}log path${RESET}"
echo $log_path

echo "Start run"

#start gpu monitoring
nvidia-smi --query-gpu=timestamp,pci.bus_id,utilization.gpu,utilization.memory --format=csv -l 1 -f $log_path/gpu_log_$run_name.csv &
gpu_pid=$!

#start network monitoring
/u/dssc/tolloi/Cluster_Basecalling_Manager/utility/iftop-parser-v2.sh ibp216s0 nfs01.ib $run_name $log_path/connection_log_$run_name.csv &
net_pid=$!

dorado basecaller \
    /u/dssc/tolloi/dorado_0.4.0_pre_built/bin/models/dna_r10.4.1_e8.2_400bps_fast@v3.5.2 \
    $1/   \
    -x cuda:0  \
    --emit-fastq \
    > $2/output_$run_name.fastq
    
    
#end net monitoring
kill $net_pid
#end gpu monitoring
kill $gpu_pid

python3 ~/Cluster_Basecalling_Manager/utility/gpu_average.py $log_path/gpu_log_$run_name.csv
python3 ~/Cluster_Basecalling_Manager/utility/net_average.py $log_path/connection_log_$run_name.csv

#deactivate python venv
deactivate

echo -e "${GREEN}---------------------------------${RESET}"