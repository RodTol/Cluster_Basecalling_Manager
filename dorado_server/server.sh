#!/bin/bash
echo "Log files path"
read log_path

dorado_server_path=/u/dssc/tolloi/ont-dorado-server/bin/

$dorado_server_path/dorado_basecall_server \
--config dna_r10.4.1_e8.2_400bps_hac.cfg \
--log_path $log_path \
--device cuda:0,1 \
--port 42837 \
#--use_tcp
