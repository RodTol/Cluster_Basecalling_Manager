#!/usr/bin/bash
echo "Start run"
dcgmi stats -g 4 -a -v

dcgmi stats -g 4 -e
echo "What is the name of this run?"

read run_name

mkdir -p  /raid/tolloi-tests/results/guppy-results/$run_name

dcgmi stats -g 4 -s $run_name

spack load ont-guppy@6.1.7-cuda

nvidia-smi --query-gpu=timestamp,pci.bus_id,utilization.gpu,utilization.memory --format=csv -l 1 -f /raid/tolloi-tests/results/guppy-results/$run_name/gpu_log_$run_name.csv &
bg_pid=$!

guppy_basecaller -c dna_r9.4.1_450bps_hac.cfg   -i  /raid/tolloi-tests/dataset_fast5_31G_0/ -s results/guppy-results/$run_name  -x cuda:all

kill $bg_pid

spack unload ont-guppy@6.1.7-cuda

dcgmi stats -x $run_name

dcgmi stats -j $run_name

dcgmi stats -g 4 -a -v

