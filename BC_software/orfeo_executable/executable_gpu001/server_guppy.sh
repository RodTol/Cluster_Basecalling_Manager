#!/bin/bash
echo "Log files path"
read log_path

spack load ont-guppy@6.1.7-cuda

guppy_basecall_server \
--config dna_r9.4.1_450bps_hac.cfg \
--log_path $log_path \
--chunks_per_runner 1200 \
--num_callers 36 \
--gpu_runners_per_device 24 \
--device cuda:0,1 \
--port 42837 \
#--use_tcp

spack unload ont-guppy@6.1.7-cuda
