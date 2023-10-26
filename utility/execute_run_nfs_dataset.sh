#!/usr/bin/bash
echo "Start run"
dcgmi stats -g 4 -a -v

dcgmi stats -g 4 -e
echo "What is the name of this run?"

read run_name

mkdir -p  /AB_20T_output/nanopore_output/$run_name

dcgmi stats -g 4 -s $run_name

spack load ont-guppy@6.1.7-cuda

nvidia-smi --query-gpu=timestamp,pci.bus_id,utilization.gpu,utilization.memory --format=csv -l 1 -f /AB_20T_output/nanopore_output/$run_name/gpu_log_$run_name.csv &
bg_pid=$!

#guppy_basecaller -c dna_r9.4.1_450bps_hac.cfg   -i  /AB_20T_input/dataset/dataset_fast5_31G_0 -s /AB_20T_output/nanopore_output/$run_name  -x cuda:all
guppy_basecaller_supervisor --num_clients 25 --input_path $1 --save_path /AB_20T_output/nanopore_output/$run_name --config dna_r9.4.1_450bps_hac.cfg --port 42837

kill $bg_pid

spack unload ont-guppy@6.1.7-cuda

dcgmi stats -x $run_name

dcgmi stats -j $run_name

dcgmi stats -g 4 -a -v

python ~/Cluster_Basecalling_Manager/utility/gpu_average.py /AB_20T_output/nanopore_output/$run_name/gpu_log_$run_name.csv
