#!/bin/bash
#SBATCH --partition=DGX
#SBATCH --job-name=dgx002_baseline
#SBATCH --nodelist=dgx002
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 128
#SBATCH --gpus=8 
#SBATCH --time=4:30:0

cd /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/dgx002_sh

#8xA100 nfs

#./dorado_hac_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/dorado_dgx002_8A100_hac_nfs.txt 2>&1 #lanciata

#./guppy_hac_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/guppy_dgx002_8A100_hac_nfs.txt 2>&1 #lanciata

#run fast dorado
#./dorado_fast_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/dorado_dgx002_8A100_fast_nfs.txt 2>&1 #lanciata

#run fast guppy
#./guppy_fast_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/guppy_dgx002_8A100_fast_nfs.txt 2>&1 #lanciata

#run sup dorado
#./dorado_sup_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/dorado_dgx002_8A100_sup_nfs.txt 2>&1 #lanciata

#run sup guppy
#./guppy_sup_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/guppy_dgx002_8A100_sup_nfs.txt 2>&1 #lanciata  

#run 5mCG hac dorado
#./dorado_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/dorado_dgx002_8A100_5mCG_nfs.txt 2>&1 #lanciata

#run 5mCG hac guppy
#./guppy_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/guppy_dgx002_8A100_5mCG_nfs.txt 2>&1 #lanciata

#run 5mCG_5hmCG hac dorado
#./dorado_5mCG_5hmCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/dorado_dgx002_8A100_5mCG_5hmCG_nfs.txt 2>&1 #lanciata

#run 5mCG_5hmCG hac guppy
./guppy_5mCG_5hmCG_benchmark.sh /AB_20T_input/dataset/subset_122G_CliveOME_5mc_dataset_POD5 /AB_20T_output/nanopore_output/benchmark_run_output > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dgx002_logs/guppy_dgx002_8A100_5mCG_5hmCG_nfs.txt 2>&1 #lanciata provo con 8 threads

