#!/bin/bash
echo $SLURM_JOB_NODELIST
cd /u/dssc/tolloi/Cluster_Basecalling_Manager/BC_software/orfeo_executable/
source BC_venv/bin/activate

cd executable_dgx002

python3 BCManagement.py 2>&1 | tee ../BC_manager_log.txt