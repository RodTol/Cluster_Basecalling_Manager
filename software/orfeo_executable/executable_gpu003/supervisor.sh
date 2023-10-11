#!/bin/bash

spack load ont-guppy@6.1.7-cuda%gcc@12.2.1 

guppy_basecaller_supervisor \
--num_clients 10 \
--input_path $1 \
--save_path $2 \
--config dna_r9.4.1_450bps_hac.cfg \
--port 42837 \
# --use_tcp 

spack unload ont-guppy@6.1.7

