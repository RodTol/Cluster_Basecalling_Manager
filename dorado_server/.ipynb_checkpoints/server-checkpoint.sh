#!/bin/bash
echo "Log files path"
read log_path

dorado_server_path=/u/dssc/tolloi/ont-dorado-server/bin/

$dorado_server_path/dorado_basecall_server \
--config /u/dssc/tolloi/dorado_0.4.0_pre_built/bin/models/dna_r10.4.1_e8.2_400bps_hac@v3.5.2  \
--log_path $log_path \
--device cuda:0,1 \
--port 42837 \
#--use_tcp
