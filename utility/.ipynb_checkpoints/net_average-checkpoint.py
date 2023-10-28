import pandas as pd
import matplotlib.pyplot as plt
import os
import sys
from pathlib import Path

csv_file_name = sys.argv[1]
run_name =  Path(csv_file_name).stem
df = pd.read_csv(csv_file_name)

# Function to convert to Gb
def convert_to_Gbytes(value):
    if 'Kb' in value:
        return float(value.strip('Kb')) / (1000*1000)
    elif 'Mb' in value:
        return float(value.strip('Mb')) / 1000 
    elif 'Gb' in value:
        return float(value.strip('Gb'))
    else:
        return 0  # Assume it's already in bytes

# Convert 'send' and 'receive' columns to bytes
df['send'] = df['send'].apply(convert_to_Gbytes)
df['receive'] = df['receive'].apply(convert_to_Gbytes)

# Calculate the averages
send_average = df['send'].mean()
receive_average = df['receive'].mean()

# Create a DataFrame for averages
averages_df = pd.DataFrame({
    ' ': ['Send', 'Receive'],
    'Average (Bytes)': [send_average, receive_average]
})

#Create save path and directory
save_path=str(run_name)+"_net_avg"
os.mkdir(save_path)

# Save the averages to a CSV file
averages_df.to_csv(os.path.join(save_path,str(run_name)+"_avg_net_dgx002.csv"), index=False)

# Create a plot
plt.figure(figsize=(10, 6))
plt.plot(df['Timestamp'], df['send'], label='Send', marker='o')
plt.plot(df['Timestamp'], df['receive'], label='Receive', marker='o')

plt.title('Send and Receive Data Over Time')
plt.xlabel('Timestamp')
plt.ylabel('Data (in Bytes)')

plt.legend()

# Display the averages on the plot
plt.axhline(100, color='purple', linestyle='--', label='Expected connection speed')
plt.axhline(send_average, color='red', linestyle='--', label=f'Send Avg: {send_average:.2f} B')
plt.axhline(receive_average, color='blue', linestyle='--', label=f'Receive Avg: {receive_average:.2f} B')

plt.legend()

# Save the plot as an image file (e.g., PNG)
plot_filename = 'send_receive_plot.png'
plt.xticks(rotation=45)
plt.savefig(os.path.join(save_path,plot_filename))
