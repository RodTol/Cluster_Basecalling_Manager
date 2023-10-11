

class Conf:
    """
    Class that collects all configurable parameters.
    """

    mngt_batch_size = 3
    mngt_outputdir = '/AB_20T_input/dataset/basecall_result_script'
    mngt_inputdir = '/AB_20T_input/dataset/ultra_extended'



    request_work_url = "http://127.0.0.1:5000/assignwork"
    engine_external_script = '/u/dssc/tolloi/local_executable/executable_dgx001/supervisor.sh'
    engine_outputdir = "/AB_20T_input/dataset/basecall_result_script"
    engine_inputdir = "/AB_20T_input/dataset/ultra_extended"
    engine_polling_interval = 1
    engine_id = "dgx001_engine"
    engine_optimal_request_size = 50
    keep_alive_terminate_url = "http://127.0.0.1:5000/completed"
    keep_alive_url = "http://127.0.0.1:5000/keepalive"

