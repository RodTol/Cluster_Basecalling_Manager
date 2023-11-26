#!/bin/bash
RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

current_time=$(date "+%Y-%m-%d %H:%M:%S")
message="I am $SLURM_JOB_NODELIST"
# Echo the time and message
echo -e "${RED}[$current_time] $message${RESET}"

sleep 10