

class Conf:
    """
    Class that collects all configurable parameters.
    """

    mngt_batch_size = 3
    mngt_outputdir = '/TEST_onp_run/dssc/human_dataset_extended/basecall_result_script'
    mngt_inputdir = '/TEST_onp_run/dssc/human_dataset_extended/ultra_extended'


    request_work_url =  "http://10.128.2.161:5000/assignwork"
    engine_external_script = '/u/dssc/tolloi/local_executable/executable_gpu002/supervisor.sh'
    engine_outputdir = "/TEST_onp_run/dssc/human_dataset_extended/basecall_result_script"
    engine_inputdir = "/TEST_onp_run/dssc/human_dataset_extended/ultra_extended"
    engine_polling_interval = 1
    engine_id = "gpu002_engine"
    engine_optimal_request_size = 30
    keep_alive_terminate_url =  "http://10.128.2.161:5000/completed"
    keep_alive_url =  "http://10.128.2.161:5000/keepalive"

