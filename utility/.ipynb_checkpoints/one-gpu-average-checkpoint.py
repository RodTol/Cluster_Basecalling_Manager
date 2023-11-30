from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt
import sys
import re
import os
from pathlib import Path

csv_file_name = sys.argv[1]
data = pd.read_csv(csv_file_name)
print(data.info())

data[' utilization.gpu [%]'] = data[' utilization.gpu [%]'].str.strip(" %").astype(float)

gpus_id = data[" pci.bus_id"].unique()

# Choose the pci.bus_id you want to plot (e.g., '00000000:07:00.0')
selected_pci_bus = gpus_id[0]

# Select data for the chosen pci.bus_id
selected_data = data.loc[data[' pci.bus_id'] == selected_pci_bus, ' utilization.gpu [%]']

# Choose the middle 1000 points
range = 200
start_index = int(max(0, len(selected_data) // 2 - range/2.0))
end_index = int(start_index + range)
selected_data = selected_data.iloc[start_index:end_index]

# Plotting
selected_data.plot(title=f"GPU 0 - Middle {range} Points")
plt.ylabel('utilization.gpu [%]')
plt.xticks(rotation=45)

# Extract the part between "gpu_log_" and ".csv" using regular expression
match = re.search(r'gpu_log_(.*?)\.csv', csv_file_name)

if match:
    extracted_part = match.group(1)
    print(extracted_part)
else:
    print("Pattern not found in the input string.")

# Save the plot as a figure (replace 'figure.png' with your desired filename)
plt.savefig(extracted_part + '_middle_' + str(range) + '.png')

# Show the plot
plt.show()
