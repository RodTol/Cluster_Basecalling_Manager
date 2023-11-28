import os
import re
import sys
from collections import defaultdict

def extract_samples_per_second(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    pattern = re.compile(r'Caller time: \d+ ms, Samples called: \d+, samples/s: (\d+\.?\d*)e?(\+?-?\d*)')
    match = pattern.search(content)

    if match:
        samples_per_second = float(match.group(1) + 'e' + match.group(2))
        return samples_per_second
    else:
        print(f"Pattern not found in the file: {file_path}")
        return None

def process_files(directory_path, file_patterns):
    samples_per_second_dict = defaultdict(list)

    # Iterate over files in the specified directory based on the file patterns
    for file_pattern in file_patterns:
        for filename in os.listdir(directory_path):
            if re.match(file_pattern, filename):
                file_path = os.path.join(directory_path, filename)
                result = extract_samples_per_second(file_path)

                if result is not None:
                    samples_per_second_dict[file_pattern].append((filename, result))

    return samples_per_second_dict

def calculate_average(samples_per_second_dict):
    averages = {}

    for file_pattern, results in samples_per_second_dict.items():
        if results:
            average_value = sum(value for _, value in results) / len(results)
            averages[file_pattern] = average_value
        else:
            averages[file_pattern] = None

    return averages

#dir_name = input("Dir name: \n")
dir_name = sys.argv[1]
directory_path = os.path.join('/u/dssc/tolloi/Cluster_Basecalling_Manager/BC_benchmarks_logs/', dir_name)
file_patterns = [r'dgx001_\d+_hac\.txt',r'dgx002_\d+_hac\.txt', r'gpu001_\d+_hac\.txt', r'gpu002_\d+_hac\.txt', r'gpu003_\d+_hac\.txt', r'gpu004_\d+_hac\.txt',
                r'dgx001_\d+_sup\.txt',r'dgx002_\d+_sup\.txt', r'gpu001_\d+_sup\.txt', r'gpu002_\d+_sup\.txt', r'gpu003_\d+_sup\.txt', r'gpu004_\d+_sup\.txt']
results = process_files(directory_path, file_patterns)

if results:
    print("Samples per second for each file pattern:")
    for file_pattern, file_results in results.items():
        print(f"\nFile pattern: {file_pattern}")
        for i, (filename, result) in enumerate(file_results, start=1):
            print(f"  File {i}: {filename}, Samples per second: {result}")

        average_values = calculate_average(results)
        if average_values[file_pattern] is not None:
            print(f"  Average samples per second: {average_values[file_pattern]}")
        else:
            print("  Unable to calculate the average.")

    print(average_values)
    # Print the sum of averages for both file patterns
    sum_of_averages = sum(average_value for average_value in average_values.values() if average_value is not None)
    print(f"\nSum of averages for both patterns: {sum_of_averages}")
