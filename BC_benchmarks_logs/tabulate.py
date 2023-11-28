import os
import subprocess
import re
import csv

# Function to extract the average samples per second from the output
def extract_samples_per_sec(output):
    pattern = re.compile(r"Sum of averages for both patterns: (\d+\.\d+)")
    match = pattern.search(output)
    if match:
        return float(match.group(1))
    else:
        return None
    
# Function to extract the average samples per second from the output
def extract_total_time(output):
    pattern = re.compile(r"Script ran for: (\d+\.\d+) seconds")
    match = pattern.search(output)
    if match:
        return float(match.group(1))
    else:
        return None
    
# Function to calculate Gb/s-sum from samples per second
def calculate_gb_per_sec(samples_per_sec):
    gb_per_sec = samples_per_sec / (10 * 1000 * 1000 * 1000)
    return gb_per_sec

# List of directory names
dir_names = [
    "run_sup_1_dgx",
    "run_sup_1_dgx-1_gpu",
    "run_sup_2_dgx",
    "run_sup_2_dgx-1_gpu",
    "run_sup_2_dgx-2_gpu",
    "run_sup_2_dgx-3_gpu",
    "run_sup_2_dgx-4_gpu",
]

# Path to the Python scripts
calculate_sample_speed_script = "calculate_sample_speed.py"
calculate_total_time_script = "calculate_total_time.py"

# CSV file path
csv_file_path = "runs_sup.csv"

# Write header to CSV file
with open(csv_file_path, mode='w', newline='') as csv_file:
    fieldnames = ['setups', 'samples/s-sum', 'Gb/s-sum', 'total-time']
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
    writer.writeheader()

    # Iterate through the directory names
    for dir_name in dir_names:
        # Construct the full path to the directory
        full_path = os.path.join("/u/dssc/tolloi/Cluster_Basecalling_Manager/BC_benchmarks_logs/", dir_name)

        # Check if the directory exists
        if os.path.exists(full_path) and os.path.isdir(full_path):
            # Call the calculate_sample_speed script
            calculate_speed_process = subprocess.run(["python", calculate_sample_speed_script, full_path], capture_output=True, text=True)

            # Extract relevant information from the output of the calculate_sample_speed script
            samples_per_sec = extract_samples_per_sec(calculate_speed_process.stdout)

            total_time_process = subprocess.run(["python", calculate_total_time_script, full_path], capture_output=True, text=True)

            # Extract relevant information from the output of the parse_log_file script
            # (replace the following lines with your actual logic to extract Gb/s-sum and total time)
            gb_per_sec = calculate_gb_per_sec(samples_per_sec)
            total_time = extract_total_time(total_time_process.stdout)

            # Write information to CSV file with scientific notation and 4 digits
            writer.writerow({'setups': dir_name, 'samples/s-sum': f"{samples_per_sec:.4e}", 'Gb/s-sum': f"{gb_per_sec:.4e}", 'total-time': total_time})
        else:
            print(f"Directory not found: {full_path}")

print(f"CSV file created: {csv_file_path}")
