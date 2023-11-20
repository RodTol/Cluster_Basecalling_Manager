#!/usr/bin/bash

#activate python venv
source ~/python_venv/nv-dashboard/bin/activate

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

echo -e "${RED}Input directory${RESET}"
echo $1

echo "Start run"
dcgmi stats -g 4 -a -v

dcgmi stats -g 4 -e
echo -e "${RED}What is the name of this run?${RESET}"
read run_name

mkdir -p  /AB_20T_output/nanopore_output/$run_name

dcgmi stats -g 4 -s $run_name

spack load ont-guppy@6.1.7-cuda

#start gpu monitoring
nvidia-smi --query-gpu=timestamp,pci.bus_id,utilization.gpu,utilization.memory --format=csv -l 1 -f /AB_20T_output/nanopore_output/$run_name/gpu_log_$run_name.csv &
gpu_pid=$!

#start network monitoring
/u/dssc/tolloi/Cluster_Basecalling_Manager/utility/iftop-parser-v2.sh ibp18s0 nfs01.ib $run_name &
net_pid=$!

#guppy_basecaller -c dna_r9.4.1_450bps_hac.cfg   -i  /AB_20T_input/dataset/dataset_fast5_31G_0 -s /AB_20T_output/nanopore_output/$run_name  -x cuda:all
guppy_basecaller_supervisor --num_clients 25 --input_path $1 --save_path /AB_20T_output/nanopore_output/$run_name --config dna_r9.4.1_450bps_hac.cfg --port 42837

#end net monitoring
kill $net_pid
#end gpu monitoring
kill $gpu_pid

spack unload ont-guppy@6.1.7-cuda

dcgmi stats -x $run_name

dcgmi stats -j $run_name

dcgmi stats -g 4 -a -v

python ~/Cluster_Basecalling_Manager/utility/gpu_average.py /AB_20T_output/nanopore_output/$run_name/gpu_log_$run_name.csv
python ~/Cluster_Basecalling_Manager/utility/net_average.py /AB_20T_output/nanopore_output/$run_name/connection_log_$run_name.csv

#deactivate python venv
deactivate
