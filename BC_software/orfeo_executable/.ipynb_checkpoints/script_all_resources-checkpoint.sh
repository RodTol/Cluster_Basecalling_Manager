#!/bin/bash
#SBATCH --job-name=het-dorado
#SBATCH --time=00:01:00
#SBATCH -p DGX --ntasks-per-node=1 --nodes=1 --cpus-per-task=8 --gpus=0 --nodelist=dgx002
#SBATCH hetjob
#SBATCH -p DGX --ntasks-per-node=1 --nodes=1 --cpus-per-task=8 --nodelist=dgx001
#SBATCH hetjob
#SBATCH -p GPU --nodes=1 --ntasks-per-node=1 --cpus-per-task=1 --nodelist=gpu004

# Firstly setup the BCManager
srun --het-group=0 BCM_start.sh

#Then launch each server and BCProcess
srun --het-group=0 script_dgx2.sh

srun --het-group=1 script_dgx1.sh

srun --het-group=2 script_gpu4.sh