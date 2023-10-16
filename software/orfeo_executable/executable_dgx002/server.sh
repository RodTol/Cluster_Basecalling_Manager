#!/bin/bash

/u/dssc/tolloi/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-9.4.0/ont-guppy-6.1.7-cuda-bpynwfgkzncberhtpficghxem3hvpmy4/bin/guppy_basecall_server \
--config dna_r9.4.1_450bps_hac.cfg \
--log_path /AB_20T_output/nanopore_output/run_dgx001-dgx002_dataset_170/server_logs \
--chunks_per_runner 1200 \
--num_callers 36 \
--gpu_runners_per_device 24 \
--device cuda:0,1,2,3,4,5,6,7 \
--port 42837 \
#--use_tcp

