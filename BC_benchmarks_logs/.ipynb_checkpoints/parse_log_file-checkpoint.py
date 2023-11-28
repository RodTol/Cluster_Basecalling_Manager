import re
import os
import sys
from datetime import datetime

# Specify the path to the log file
#dir_file_log = input("Dir with log file:\n")
dir_file_log = sys.argv[1]
log_file_path = os.path.join(dir_file_log,"BC_manager_log.txt")

# Define regular expressions to match job IDs, engine IDs, and timestamps
assignwork_pattern = re.compile(r'GET \/assignwork\?engineid=(\w+)&batchsize=\d+')
keepalive_pattern = re.compile(r'GET \/keepalive\?job_id=(\d+)&job_state=\w+')
timestamp_pattern = re.compile(r'\[(\d{2}\/\w+\/\d{4} \d{2}:\d{2}:\d{2})\]')
completed_pattern = re.compile(r'GET \/completed\?job_id=(\d+)&job_state=\w+')

# Extract job IDs, engine IDs, and timestamps
job_engine_mapping = {}
current_ip = None

with open(log_file_path, 'r') as log_file:
    for line in log_file:
        if line.strip() == '':
            continue
        
        # Extract IP address
        ip_match = re.match(r'^([\d\.]+) - -', line)
        if ip_match:
            current_ip = ip_match.group(1)

        # Extract timestamp
        timestamp_match = timestamp_pattern.search(line)
        if timestamp_match:
            timestamp_str = timestamp_match.group(1)
            timestamp = datetime.strptime(timestamp_str, '%d/%b/%Y %H:%M:%S')

        # Extract job ID and engine ID from assignwork
        assignwork_match = assignwork_pattern.search(line)
        if assignwork_match:
            engine_id = assignwork_match.group(1)
            job_id_line = next(log_file, None)  # Get the next line

            if job_id_line:
                job_id_match = re.search(r'job_id=(\d+)&job_state=\w+', job_id_line)
                if job_id_match:
                    job_id = job_id_match.group(1)
                    if current_ip not in job_engine_mapping:
                        job_engine_mapping[current_ip] = {'assignwork': {'engine_id': engine_id, 'job_info': {}, 'done_time': {}}, 'total_time': {}}
                    job_engine_mapping[current_ip]['assignwork']['job_info'][job_id] = {'timestamp': timestamp}

        # Extract job ID from completed lines
        completed_match = completed_pattern.search(line)
        if completed_match:
            job_id = completed_match.group(1)
            if job_id in job_engine_mapping[current_ip]['assignwork']['job_info']:
                job_engine_mapping[current_ip]['assignwork']['done_time'][job_id] = {'timestamp_done': timestamp}

# Print the results
for ip, job_info in job_engine_mapping.items():
    engine_id = job_info['assignwork']['engine_id']
    print(f"IP: {ip}, Engine ID: {engine_id}")
    total_time_difference = 0  # Initialize total_time_difference variable
    print("Job IDs and Time Differences (in seconds):")
    for job_id, info in job_info['assignwork']['job_info'].items():
        timestamp_assigned = info['timestamp']
        timestamp_done = job_info['assignwork']['done_time'].get(job_id, {}).get('timestamp_done')

        if timestamp_done:
            # Calculate the time difference
            time_difference = (timestamp_done - timestamp_assigned).total_seconds()
            total_time_difference += time_difference

            print(f"Job ID: {job_id}, Time Assigned: {timestamp_assigned}, Time Done: {timestamp_done}, Time Difference: {time_difference} seconds")
        else:
            print(f"Job ID: {job_id}, Time Assigned: {timestamp_assigned}, Time Done: Not available")

    print(f"Total Time Difference for all Job IDs: {total_time_difference} seconds")
    print()
