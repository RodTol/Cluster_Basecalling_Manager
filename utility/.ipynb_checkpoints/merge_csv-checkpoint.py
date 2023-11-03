import csv
import os
import glob
import sys

def list_subdirectories(directory_path):
    directory_names = []

    if os.path.exists(directory_path) and os.path.isdir(directory_path):
        for item in os.listdir(directory_path):
            item_path = os.path.join(directory_path, item)

            if os.path.isdir(item_path) and item.startswith("run_"):
                directory_names.append(item)

    return directory_names

# Function to merge CSV files
def merge_csv_files(input_files, output_file):
    with open(output_file, 'w', newline='') as output_csvfile:
        csv_writer = csv.writer(output_csvfile)

        for input_file in input_files:
            with open(input_file, 'r') as input_csvfile:
                csv_reader = csv.reader(input_csvfile)
                for row in csv_reader:
                    csv_writer.writerow(row)

# Function to find the connection_log CSV file in a directory
def find_connection_log_csv(directory):
    csv_files = glob.glob(os.path.join(directory, f"connection_log_{directory}.csv"))
    return csv_files

# Function to find the gpu_log CSV file in a directory
def find_gpu_log_csv(directory):
    csv_files = glob.glob(os.path.join(directory, f"gpu_log_{directory}.csv"))
    return csv_files

# List of directories to search for CSV files
master_dir_path = input("Enter the dir name with all the logs dir: ")
directories = list_subdirectories(master_dir_path)
print(directories)

# Output CSV file
net_output_file = "merged_connection_logs.csv"

gpu_output_file = "merged_gpu_logs.csv"

# Merge CSV files with the first file's header preserved
with open(net_output_file, 'w', newline='') as output_csvfile:
    csv_writer = csv.writer(output_csvfile)
    first_file = True

    for directory in directories:
        csv_files = find_connection_log_csv(directory)

        for i, csv_file in enumerate(csv_files):
            with open(csv_file, 'r') as input_csvfile:
                csv_reader = csv.reader(input_csvfile)
                for j, row in enumerate(csv_reader):
                    if first_file or j > 0:
                        csv_writer.writerow(row)

            first_file = False
                        
print(f"net CSV files merged into '{net_output_file}'")

# Merge CSV files with the first file's header preserved
with open(gpu_output_file, 'w', newline='') as output_csvfile:
    csv_writer = csv.writer(output_csvfile)
    first_file = True

    for directory in directories:
        csv_files = find_gpu_log_csv(directory)

        for i, csv_file in enumerate(csv_files):
            with open(csv_file, 'r') as input_csvfile:
                csv_reader = csv.reader(input_csvfile)
                for j, row in enumerate(csv_reader):
                    if first_file or j > 0:
                        csv_writer.writerow(row)

            first_file = False
                        
print(f"gpu CSV files merged into '{gpu_output_file}'")