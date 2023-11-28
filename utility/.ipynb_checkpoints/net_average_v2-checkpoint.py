import pandas as pd
import matplotlib.pyplot as plt
import os
import sys
from pathlib import Path

csv_file_name = sys.argv[1]
path = os.path.dirname(csv_file_name)
run_name =  Path(csv_file_name).stem
df = pd.read_csv(csv_file_name, sep=';')

# Function to convert to Gb
def convert_to_Gbit(value):
    if type(value) is int:
        return float(value)
    
    value = value.replace(',', '.')
    if 'Kb' in value:
        return float(value.strip('Kb')) / (1000*1000)
    elif 'Mb' in value:
        return float(value.strip('Mb')) / 1000 
    elif 'Gb' in value:
        return float(value.strip('Gb'))
    elif 'b' in value:
        return float(value.strip('b')) / (1000*1000*1000)
    else:
        return 0  # Assume it's already in bytes

# Convert 'send' and 'receive' columns to bytes
df['send'] = df['send'].apply(convert_to_Gbit)
df['receive'] = df['receive'].apply(convert_to_Gbit)

# Calculate the averages
send_average = df['send'].mean()
receive_average = df['receive'].mean()

# Create a DataFrame for averages
averages_df = pd.DataFrame({
    ' ': ['Send', 'Receive'],
    'Average (Gb)': [send_average, receive_average]
})

#Create save path and directory
save_path=os.path.join(path, run_name + "_net_avg")
os.mkdir(save_path)

# Save the averages to a CSV file
averages_df.to_csv(os.path.join(save_path,str(run_name)+"_avg_net_dgx002.csv"), index=False)

# Create a plot
plt.figure(figsize=(10, 6))
plt.plot(df['Timestamp'], df['send'], label='Send', marker='o')
plt.plot(df['Timestamp'], df['receive'], label='Receive', marker='o')

plt.title('Send and Receive Data Over Time. Sup settings')
plt.xlabel('Timestamp')
plt.ylabel('Data (in Gbps)')

plt.legend()

# Display the averages on the plot
#plt.axhline(100, color='purple', linestyle='--', label='Expected connection speed')
plt.axhline(send_average, color='blue', linestyle='--', label=f'Send Avg: {send_average:.2f} Gbps')
plt.axhline(receive_average, color='red', linestyle='--', label=f'Receive Avg: {receive_average:.2f} Gbps')

# Set ticks and labels for only the first and last points
tick_positions = [df['Timestamp'].iloc[0], df['Timestamp'].iloc[-1]]
tick_labels = [df['Timestamp'].iloc[0], df['Timestamp'].iloc[-1]]

plt.xticks(tick_positions, tick_labels, rotation=45)

# Save the plot as an image file (e.g., PNG)
plot_filename = 'send_receive_plot.png'
plt.savefig(os.path.join(save_path, plot_filename))

# Show the plot
plt.show()

# Save the plot as an image file (e.g., PNG)
plot_filename = 'send_receive_plot.png'
plt.savefig(os.path.join(save_path, plot_filename))

