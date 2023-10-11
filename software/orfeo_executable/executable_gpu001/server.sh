#!/bin/bash

spack load ont-guppy@6.1.7-cuda%gcc@12.2.1 

guppy_basecall_server \
--config dna_r9.4.1_450bps_hac.cfg \
--log_path /TEST_onp_run/dssc/human_dataset_extended/server_logs \
--chunks_per_runner 1200 \
--num_callers 36 \
--gpu_runners_per_device 24 \
--device cuda:0,1 \
--port 42837 

spack unload

