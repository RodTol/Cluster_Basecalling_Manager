from datetime import datetime
import pandas as pd
import matplotlib as plt
import sys
from pathlib import Path

csv_file_name = sys.argv[1]
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

for i in range(0,8):
    tmp_1 =  df.loc[df[' pci.bus_id'] == gpus_id[i], ' utilization.gpu [%]']
    ax = tmp_1.plot(title="GPU " + str(i))
    fig = ax.get_figure()
    fig.savefig('GPU_'+str(i)+'_plot.jpg')
    fig.clf()
    
    df_average.loc[[i],['Average_utilization']] = tmp_1.mean()
    #print(tmp_1)
    tmp_2 =  df.loc[df[' pci.bus_id']==gpus_id[i], ' utilization.memory [%]']
    df_average.loc[[i],['Average_mem_utilization']] = tmp_2.mean()
    
df_average.to_csv(str(run_name)+"_avg_dgx002.csv", index=False)

