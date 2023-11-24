#!/bin/bash
RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

echo -e "${RED}$SLURM_JOB_NODELIST${RESET}"
date

cd /u/dssc/tolloi/Cluster_Basecalling_Manager/BC_software/orfeo_executable/
source BC_venv_GPU/bin/activate

cd executable_gpu004
./server.sh &
server_pid=$!

sleep 10
python3 BCProcessors.py

current_time=$(date "+%Y-%m-%d %H:%M:%S")
message="Processors has finished on gpu004"
# Echo the time and message
echo -e "${GREEN}[$current_time] $message${RESET}"
