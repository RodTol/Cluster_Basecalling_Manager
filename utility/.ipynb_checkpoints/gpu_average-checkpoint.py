from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt
import sys
import os
from pathlib import Path

csv_file_name = sys.argv[1]
path = os.path.dirname(csv_file_name)
run_name =  Path(csv_file_name).stem
df = pd.read_csv(csv_file_name)

print(df.info())

#print(df[' utilization.gpu [%]'].str.strip(" %").astype(float))
df[' utilization.gpu [%]'] = df[' utilization.gpu [%]'].str.strip(" %").astype(float)
df[' utilization.memory [%]'] = df[' utilization.memory [%]'].str.strip(" %").astype(float)


#print(df)
#timestamps = df["timestamp"]
#timestamps = [datetime.strptime(i,"%Y/%m/%d %H:%M:%S.%f") for i in timestamps]
#timestamps = sorted(set([datetime.strftime(i,"%Y/%m/%d %H:%M:%S") for i in timestamps]))
#print(timestamps)

gpus_id = df[" pci.bus_id"].unique()
#print(gpus_id)

averages_data = {'gpu' : ['0','1','2','3','4','5','6','7'],
                'Average_utilization': [0,0,0,0,0,0,0,0],
                'Average_mem_utilization': [0,0,0,0,0,0,0,0] }

df_average = pd.DataFrame(averages_data, columns = ['gpu','Average_utilization', 'Average_mem_utilization'])

save_path=os.path.join(path, run_name + "_avg_dgx002")
os.mkdir(save_path)

# Initialize two figures, one for each image
fig1, ax1 = plt.subplots(2, 2, figsize=(12, 8))
fig2, ax2 = plt.subplots(2, 2, figsize=(12, 8))

for i in range(0, 8):
    tmp_1 = df.loc[df[' pci.bus_id'] == gpus_id[i], ' utilization.gpu [%]']
    tmp_2 = df.loc[df[' pci.bus_id'] == gpus_id[i], ' utilization.memory [%]']

    df_average.loc[[i], ['Average_utilization']] = tmp_1.mean()
    df_average.loc[[i], ['Average_mem_utilization']] = tmp_2.mean()

    # Plot on the appropriate subplots
    if i < 4:
        ax = ax1[i//2, i % 2]
        fig = fig1
    else:
        ax = ax2[(i-4)//2, i % 2]
        fig = fig2

    tmp_1.plot(ax=ax, title="GPU " + str(i))

# Save the two figures
fig1.savefig(os.path.join(save_path, 'GPU_plots_1.jpg'))
fig2.savefig(os.path.join(save_path, 'GPU_plots_2.jpg'))

# Clear the figures
fig1.clf()
fig2.clf()

# Save the DataFrame to CSV
df_average.to_csv(os.path.join(save_path, str(run_name) + "_avg_dgx002.csv"), index=False)

