#8xA100 nfs
#./dorado_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/dorado_8A100_no_meth_nfs.txt 2>&1 #done e anche 4A100

#./dorado_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/dorado_8A100_5mCG_nfs.txt 2>&1 #done 

#./guppy_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/guppy_8A100_no_meth_nfs.txt 2>&1 #done

./guppy_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/guppy_8A100_5mCG_nfs.txt 2>&1 #done

run fast dorado
run sup dorado

#1v100 nfs
./dorado_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/dorado_1V100_no_meth_nfs.txt 2>&1

./dorado_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/dorado_1V100_5mCG_nfs.txt 2>&1

./guppy_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/guppy_1V100_no_meth_nfs.txt 2>&1

./guppy_5mCG_benchmark.sh /AB_20T_input/dataset/CliveOME_5mc_dataset_POD5/ /AB_20T_output/nanopore_output/benchmark_run_output/ > logs/guppy_1V100_5mCG_nfs.txt 2>&1

#-----------------------------------------------------------------------------

#8xA100 ceph

./dorado_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/dorado_8A100_no_meth_ceph.txt 2>&1 #done e anche 4A100

./dorado_5mCG_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/dorado_8A100_5mCG_meth_ceph.txt 2>&1

./guppy_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/guppy_8A100_no_meth_ceph.txt 2>&1

./guppy_5mCG_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/guppy_8A100_5mCG_meth_ceph.txt 2>&1

#1xV100 ceph

./dorado_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/dorado_1V100_no_meth_ceph.txt 2>&1

./dorado_5mCG_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/dorado_1V100_5mCG_meth_ceph.txt 2>&1

./guppy_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/guppy_1V100_no_meth_ceph.txt 2>&1

./guppy_5mCG_benchmark.sh ~/scratch/CliveOME_5mc_dataset_POD5/ ~/scratch/benchmark_run_output/ > logs/guppy_1V100_5mCG_meth_ceph.txt 2>&1