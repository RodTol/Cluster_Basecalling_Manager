from datetime import datetime
import os
import sys

def parse_log_time(log_time_str):
    # Convert log time string to datetime object
    return datetime.strptime(log_time_str, '%d/%b/%Y %H:%M:%S')

def calculate_execution_time(log_file_path):
    with open(log_file_path, 'r') as file:
        lines = file.readlines()

    start_time = None
    end_time = None

    for line in lines:
        # Extract the timestamp from the log entry
        parts = line.split('[')
        if len(parts) > 1:
            timestamp_str = parts[1].split(']')[0]
            timestamp = parse_log_time(timestamp_str)

            # Use the first log entry as the start time
            if start_time is None:
                start_time = timestamp
            # Use the last log entry as the end time
            end_time = timestamp

    if start_time is not None and end_time is not None:
        # Calculate the execution time
        execution_time = end_time - start_time
        return start_time, end_time, execution_time.total_seconds()
    else:
        return None

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python calculate_total_time.py /path/to/log/directory")
        sys.exit(1)

    dir_file_log = sys.argv[1]
    log_file_path = os.path.join(dir_file_log, "BC_manager_log.txt")
    result = calculate_execution_time(log_file_path)

    if result is not None:
        start_time, end_time, execution_time = result
        print(f"Script started at: {start_time}")
        print(f"Script ended at: {end_time}")
        print(f"Script ran for: {execution_time} seconds")
    else:
        print("Unable to calculate execution time.")
