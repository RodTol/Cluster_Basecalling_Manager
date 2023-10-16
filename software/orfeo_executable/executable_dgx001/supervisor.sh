#!/bin/bash

/u/dssc/tolloi/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-9.4.0/ont-guppy-6.1.7-cuda-bpynwfgkzncberhtpficghxem3hvpmy4/bin/guppy_basecaller_supervisor \
--num_clients 25 \
--input_path $1 \
--save_path $2 \
--config dna_r9.4.1_450bps_hac.cfg \
--port 42837 \
# --use_tcp 

