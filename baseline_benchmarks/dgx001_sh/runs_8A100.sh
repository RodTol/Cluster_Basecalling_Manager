#!/bin/bash
#SBATCH --partition=DGX
#SBATCH --job-name=baseline_A100
#SBATCH --nodelist=dgx001
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 128
#SBATCH --gpus=8 
#SBATCH --time=4:30:0

#RUN FATTE CON nfs01 in TCP e ring buffer piccoli

cd /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/dgx001_sh

#8xA100 nfs

#./dorado_hac_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/dorado_8A100_hac_nfs.txt 2>&1  #lanciata 19 33 e fatta

#./guppy_hac_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/guppy_8A100_hac_nfs.txt 2>&1 #lanciata 20 00 e fatta

#run fast dorado
#./dorado_fast_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/dorado_8A100_fast_nfs.txt 2>&1 #lanciata 21 46 e fatta 

#run fast guppy
#./guppy_fast_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/guppy_8A100_fast_nfs.txt 2>&1 #lanciata 22 00 e fatta

#run sup dorado
#./dorado_sup_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/dorado_8A100_sup_nfs.txt 2>&1  #lanciata 22 46 e fatta 

#run sup guppy
#./guppy_sup_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/guppy_8A100_sup_nfs.txt 2>&1 #lanciata   PARAMETRI CAMBIATI ERRORE CUDA MEMORIA (vedi troubleshooting pagina guppy ont) 

#run 5mCG hac dorado
#./dorado_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/dorado_8A100_5mCG_nfs.txt 2>&1 #lanciata

#run 5mCG hac guppy
#./guppy_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/guppy_8A100_5mCG_nfs.txt 2>&1 #lanciata

#run 5mCG_5hmCG hac dorado
#./dorado_5mCG_5hmCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/dorado_8A100_5mCG_5hmCG_nfs.txt 2>&1 #lanciata  HO DOVUTO USARE hac@4.1.0 PERCHÈ 3.5.2 NON HA 5mCG_5hmCG https://github.com/nanoporetech/dorado/issues/278

#run 5mCG_5hmCG hac guppy
./guppy_5mCG_5hmCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx001_logs/guppy_8A100_5mCG_5hmCG_nfs.txt 2>&1 #lanciata con 50 threads

#-----------------------------------------------------------------------------
#WORK IN PROGRESS
#8xA100 ceph

#./dorado_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/dorado_8A100_no_meth_ceph.txt 2>&1 #done e anche 4A100

#./dorado_5mCG_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/dorado_8A100_5mCG_meth_ceph.txt 2>&1

#./guppy_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/guppy_8A100_no_meth_ceph.txt 2>&1

#./guppy_5mCG_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/guppy_8A100_5mCG_meth_ceph.txt 2>&1
