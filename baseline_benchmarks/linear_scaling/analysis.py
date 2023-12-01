import re
import csv
import matplotlib.pyplot as plt

def extract_samples_per_second(log_text):
    # Define a regex pattern to match the Samples/s line
    pattern = r'\[.*\] \[info\] > Basecalled @ Samples/s: (\S+)'

    # Use re.search to find the match in the log text
    match = re.search(pattern, log_text)

    # Extract the value if a match is found
    if match:
        samples_per_second = float(match.group(1))
        return samples_per_second
    else:
        return None

# List of log files for each run
log_files = [
    'run_1_gpus.txt',
    'run_2_gpus.txt',
    'run_3_gpus.txt',
    'run_4_gpus.txt',
    'run_5_gpus.txt',
    'run_6_gpus.txt',
    'run_7_gpus.txt',
    'run_8_gpus.txt'
]

# Create a CSV file for the results
csv_filename = 'samples_per_second_results.csv'

with open(csv_filename, 'w', newline='') as csvfile:
    fieldnames = ['Run', 'Number of GPUs', 'Samples/s']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # Write the header to the CSV file
    writer.writeheader()

    # Lists to store data for plotting
    num_gpus_list = []
    samples_per_second_list = []

    # Iterate through each log file
    for i, log_file in enumerate(log_files, start=1):
        with open(log_file, 'r') as file:
            log_text = file.read()

        # Call the function to extract Samples/s
        samples_per_second = extract_samples_per_second(log_text)

        # Check if the value was extracted successfully
        if samples_per_second is not None:
            # Write the results to the CSV file
            writer.writerow({'Run': f'Run {i}', 'Number of GPUs': f'{i}', 'Samples/s': samples_per_second})

            # Store data for plotting
            num_gpus_list.append(i)
            samples_per_second_list.append(samples_per_second)
        else:
            print(f"Samples/s not found in {log_file}.")

# Calculate linear speed and delta
linear_speed = [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]
for i in range(len(samples_per_second_list)):
    linear_speed[i] = (samples_per_second_list[3]*linear_speed[i])
print(linear_speed)
delta = [(l - s) / l * 100 for s, l in zip(samples_per_second_list, linear_speed)]

# Plot samples_per_second_list and linear_speed together
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(num_gpus_list, samples_per_second_list, marker='o', linestyle='-', color='b', label='Samples/s')
plt.plot(num_gpus_list, linear_speed, marker='o', linestyle='-', color='r', label='Linear Speed')
plt.title('Samples/s')
plt.xlabel('Number of GPUs')
plt.ylabel('Metrics')
plt.legend()  # Show legend
plt.grid(True)

# Plot delta separately
plt.subplot(1, 2, 2)
plt.plot(num_gpus_list, delta, marker='o', linestyle='-', color='g', label='Delta (%)')
plt.title('Percentage Difference')
plt.xlabel('Number of GPUs')
plt.ylabel('Percentage Difference (%)')
plt.legend()  # Show legend
plt.grid(True)

# Adjust layout
plt.tight_layout()

# Save the plots
plot_filename = 'num_gpus_vs_metrics_plot.png'
plt.savefig(plot_filename)
print(f"Plots saved to {plot_filename}")

# Show the plots (optional)
plt.show()
