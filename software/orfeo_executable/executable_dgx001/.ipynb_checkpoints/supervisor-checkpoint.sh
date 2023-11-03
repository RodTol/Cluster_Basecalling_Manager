#!/usr/bin/bash

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
run_name="run_${launch_time}_dgx001"
echo -e "${RED}Name of this run${RESET}"
echo $run_name
mkdir -p  /AB_20T_output/nanopore_output/run_logs/$run_name
log_path=/AB_20T_output/nanopore_output/run_logs/$run_name

echo -e "${RED}log path${RESET}"
echo $log_path

echo "Start run"
dcgmi stats -g 2 -a -v

dcgmi stats -g 2 -e

dcgmi stats -g 2 -s $run_name

spack load ont-guppy@6.1.7-cuda

#start gpu monitoring
nvidia-smi --query-gpu=timestamp,pci.bus_id,utilization.gpu,utilization.memory --format=csv -l 1 -f $log_path/gpu_log_$run_name.csv &
gpu_pid=$!

#start network monitoring
/u/dssc/tolloi/Cluster_Basecalling_Manager/utility/iftop-parser-v2.sh ibp18s0 nfs01.ib $run_name &
net_pid=$!

guppy_basecaller_supervisor --num_clients 25 \
--input_path $1 \
--save_path $save_path \
--config dna_r9.4.1_450bps_hac.cfg \
--port 42837

#end net monitoring
kill $net_pid
#end gpu monitoring
kill $gpu_pid

spack unload ont-guppy@6.1.7-cuda

dcgmi stats -x $run_name

dcgmi stats -j $run_name

dcgmi stats -g 2 -a -v

python3 ~/Cluster_Basecalling_Manager/utility/gpu_average.py $log_path/gpu_log_$run_name.csv
python3 ~/Cluster_Basecalling_Manager/utility/net_average.py $log_path/connection_log_$run_name.csv

#deactivate python venv
deactivate

echo -e "${GREEN}---------------------------------${RESET}"