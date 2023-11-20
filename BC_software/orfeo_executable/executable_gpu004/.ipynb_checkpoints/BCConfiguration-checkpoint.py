

class Conf:
    """
    Class that collects all configurable parameters.
    """

    mngt_batch_size = 3
    mngt_outputdir = ''
    mngt_inputdir = ''

    #dgx001 hosting
    #request_work_url =  "http://10.128.2.161:5000/assignwork"
    #dgx002 hosting
    request_work_url =  "http://10.128.2.162:5000/assignwork"
    
    engine_external_script = "/u/dssc/tolloi/Cluster_Basecalling_Manager/BC_software/orfeo_executable/executable_gpu004/launch_supervisor.sh"
    engine_outputdir = ""
    engine_inputdir = ""
    engine_polling_interval = 1
    engine_id = "gpu004_engine"
    engine_optimal_request_size = 5
    
    #dgx001 hosting
    #keep_alive_terminate_url =  "http://10.128.2.161:5000/completed"
    #dgx002 hosting
    keep_alive_terminate_url = "http://10.128.2.162:5000/completed"
    
    #dgx001 hosting
    #keep_alive_url =  "http://10.128.2.161:5000/keepalive"
    #dgx002 hosting
    keep_alive_url = "http://10.128.2.162:5000/keepalive"
