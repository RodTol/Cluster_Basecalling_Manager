#!/bin/bash
RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

current_time=$(date "+%Y-%m-%d %H:%M:%S")
message="$SLURM_JOB_NODELIST"
# Echo the time and message
echo -e "${RED}[$current_time] $message${RESET}"

cd /u/dssc/tolloi/Cluster_Basecalling_Manager/BC_software/orfeo_executable/
source BC_venv_GPU/bin/activate

cd executable_gpu002
./server.sh &
server_pid=$!

sleep 30
python3 BCProcessors.py

current_time=$(date "+%Y-%m-%d %H:%M:%S")
message="Processors has finished on gpu002"
# Echo the time and message
echo -e "${GREEN}[$current_time] $message${RESET}"
