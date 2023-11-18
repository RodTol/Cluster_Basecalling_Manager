#!/bin/bash
#SBATCH --partition=GPU
#SBATCH --job-name=baseline_V100
#SBATCH --nodelist=gpu004
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 48
#SBATCH --time=4:0:0

cd /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/gpu004_sh/

#1v100 nfs

#./dorado_hac_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dorado_1V100_hac_nfs.txt 2>&1 #lanciata 17 07 e fatta

#./guppy_hac_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/guppy_1V100_hac_nfs.txt 2>&1 #lanciata 17 50 e fatta

#run fast dorado
#./dorado_fast_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dorado_1V100_fast_nfs.txt 2>&1 #lanciata  20 44 e fatta FORSE ALLARGARE DATASET A 35G (MEMORIA V100=32)

#run fast guppy
#./guppy_fast_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/guppy_1V100_fast_nfs.txt 2>&1 #lanciata 20 48 e fatta FORSE ALLARGARE DATASET A 35G (MEMORIA V100=32)

#run sup dorado
#./dorado_sup_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dorado_1V100_sup_nfs.txt 2>&1 #lanciata 20 59 e fatta

#run sup guppy
#./guppy_sup_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/guppy_1V100_sup_nfs.txt 2>&1 #lanciata 23 07 e fatta PARAMETRI CAMBIATI ERRORE CUDA MEMORIA

#run 5_mCG dorado
#./dorado_5mCG_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dorado_1V100_5mCG_nfs.txt 2>&1 #lanciata 01 26 e fatta

#run 5_mCG guppy
#./guppy_5mCG_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/guppy_1V100_5mCG_nfs.txt 2>&1 #lanciata 12 10 e fatta

#run 5mCG_5hmCG hac dorado
./dorado_5mCG_5hmCG_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/dorado_1V100_5mCG_5hmCG_nfs.txt 2>&1 #lanciata  HO DOVUTO USARE hac@4.1.0 PERCHÈ 3.5.2 NON HA 5mCG_5hmCG https://github.com/nanoporetech/dorado/issues/278

#run 5mCG_5hmCG hac guppy
#./guppy_5mCG_5hmCG_benchmark_GPU.sh /AB_20T_input/dataset/subset_23G_CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > /u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs/guppy_1V100_5mCG_5hmCG_nfs.txt 2>&1 #lanciata 12 41 e fatta
