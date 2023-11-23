import os
import re
from collections import defaultdict

def extract_samples_per_second(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Updated pattern to handle both cases
    pattern1 = re.compile(r'Caller time: \d+ ms, Samples called: \d+, samples/s: (\d+\.?\d*)e?(\+?-?\d*)')
    pattern2 = re.compile(r'> Basecalled @ Samples/s: (\d+\.?\d*)e?(\+?-?\d*)')

    match1 = pattern1.search(content)
    match2 = pattern2.search(content)

    if match1:
        samples_per_second = float(match1.group(1) + 'e' + match1.group(2))
        return samples_per_second
    elif match2:
        samples_per_second = float(match2.group(1) + 'e' + match2.group(2))
        return samples_per_second
    else:
        print(f"Pattern not found in the file: {file_path}")
        return None

def process_files(directory_path, file_patterns):
    samples_per_second_dict = defaultdict(list)

    if not os.path.exists(directory_path):
        print(f"Directory not found: {directory_path}")
        return samples_per_second_dict

    # Iterate over files in the specified directory based on the file patterns
    for file_pattern in file_patterns:
        for filename in os.listdir(directory_path):
            if re.match(file_pattern, filename):
                file_path = os.path.join(directory_path, filename)
                result = extract_samples_per_second(file_path)

                if result is not None:
                    samples_per_second_dict[file_pattern].append((filename, result))

    return samples_per_second_dict

dir_name = input("Dir name: \n")
directory_path = os.path.join('/u/dssc/tolloi/Cluster_Basecalling_Manager/baseline_benchmarks/logs', dir_name)
file_patterns = [
    r'dorado_dgx002_8A100_fast_nfs\.txt',
    r'dorado_dgx002_8A100_hac_nfs\.txt',
    r'dorado_dgx002_8A100_sup_nfs\.txt',
    r'dorado_dgx002_8A100_5mCG_nfs\.txt',
    r'dorado_dgx002_8A100_5mCG_5hmCG_nfs\.txt',
    r'guppy_dgx002_8A100_fast_nfs\.txt',
    r'guppy_dgx002_8A100_hac_nfs\.txt',
    r'guppy_dgx002_8A100_sup_nfs\.txt',
    r'guppy_dgx002_8A100_5mCG_nfs\.txt',
    r'guppy_dgx002_8A100_5mCG_5hmCG_nfs\.txt',
    r'dorado_1V100_fast_nfs.txt',
    r'dorado_1V100_hac_nfs.txt',
    r'dorado_1V100_sup_nfs.txt',
    r'dorado_1V100_5mCG_nfs.txt',
    r'dorado_1V100_5mCG_5hmCG_nfs.txt',
    r'guppy_1V100_fast_nfs.txt',
    r'guppy_1V100_hac_nfs.txt',
    r'guppy_1V100_sup_nfs.txt',
    r'guppy_1V100_5mCG_nfs.txt',
    r'guppy_1V100_5mCG_5hmCG_nfs.txt'
]
results = process_files(directory_path, file_patterns)

if results:
    print("Samples per second for each file pattern:")
    for file_pattern, file_results in results.items():
        for i, (filename, result) in enumerate(file_results, start=1):
            print(f"  File : {filename}, Samples per second: {result}")
