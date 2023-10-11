#!/bin/bash

spack load /4gzxwe5

guppy_basecaller_supervisor \
--num_clients 25 \
--input_path $1 \
--save_path $2 \
--config dna_r9.4.1_450bps_hac.cfg \
--port 42837 \
# --use_tcp 

spack unload ont-guppy@6.1.7

