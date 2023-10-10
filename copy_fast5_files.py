import h5py as h5
from ont_fast5_api.fast5_interface import get_fast5_file
from ont_fast5_api.fast5_interface import MultiFast5File
from ont_fast5_api.conversion_tools.conversion_utils import yield_fast5_reads
import uuid
def print_read_id(file_name, n_of_read):
    with get_fast5_file(file_name, mode="r") as f5:
        n = 0
        for read in f5.get_reads():
            if (n<n_of_read):
                print(read.read_id)
            n+=1
        print("# of reads = " + str(n))
def print_read_info(file_name, read_name):
    with get_fast5_file(file_name, mode='r') as f5:
        read = f5.get_read(read_name)
        print(read.get_raw_data())
def copy_with_new_id(input_dir, input_file, output_dir, num_of_dup, start_num_of_dup=0):
    for i in range(start_num_of_dup, num_of_dup+start_num_of_dup):
        debug = True
        output_file = str(input_file).replace('.fast5','') + '_' + str(i+1) + '.fast5'
        print('Generating ' + output_file)
        output_file = output_dir +'/'+output_file
        with MultiFast5File(str(output_file), 'w') as output_f5:
            for read_id, read in yield_fast5_reads(input_dir + '/' + input_file, recursive=False):
                    dup_read_id = str(uuid.uuid4())
                    read.read_id = dup_read_id
                    output_f5.add_existing_read(read)
                    if(debug):
                         print(read_id, dup_read_id)
                         debug=False
copy_with_new_id('/AB_20T_input/dataset/original_dataset', 'nanopore2_20170303_FNFAF09968_MN17024_sequencing_run_170303_NA12878_PC_RAD002_5.fast5','/AB_20T_input/dataset/grand_challenge_input',1800)
