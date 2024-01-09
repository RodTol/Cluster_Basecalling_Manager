

class Conf:
    """
    Class that collects all configurable parameters.
    """

    mngt_batch_size = 3
    mngt_outputdir = '/AB_20T_output/nanopore_output/run_files_test/outputs/run_1_splits'#CARTELLA DA INPUT
    mngt_inputdir = '/AB_20T_input/dataset/CliveOME_5mc_dataset_POD5'

    #dgx001 hosting
    #request_work_url =  "http://10.128.2.161:5000/assignwork"
    #dgx002 hosting
    request_work_url =  "http://127.0.0.1:40765/assignwork"
    
    engine_external_script = "/u/dssc/tolloi/Cluster_Basecalling_Manager/BC_software/orfeo_executable/file_performance_test/executables/launch_supervisor.sh"
    engine_outputdir = '/AB_20T_output/nanopore_output/run_files_test/outputs/run_1_splits'#CARTELLA DA INPUT
    engine_inputdir = "/AB_20T_input/dataset/CliveOME_5mc_dataset_POD5"
    engine_polling_interval = 1
    engine_id = "dgx002_engine"
    engine_optimal_request_size = 58 #INPUT
    
    #dgx001 hosting
    #keep_alive_terminate_url =  "http://10.128.2.161:5000/completed"
    #dgx002 hosting
    keep_alive_terminate_url = "http://127.0.0.1:40765/completed"
    
    #dgx001 hosting
    #keep_alive_url =  "http://10.128.2.161:5000/keepalive"
    #dgx002 hosting
    keep_alive_url = "http://127.0.0.1:40765/keepalive"
