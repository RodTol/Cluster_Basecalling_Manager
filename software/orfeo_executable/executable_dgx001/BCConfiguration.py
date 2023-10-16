

class Conf:
    """
    Class that collects all configurable parameters.
    """

    mngt_batch_size = 3
    mngt_outputdir = '/AB_20T_output/nanopore_output/run_dgx001-dgx002_dataset_170/results'
    mngt_inputdir = '/AB_20T_input/dataset/dataset_170'



    request_work_url = "http://127.0.0.1:5000/assignwork"
    engine_external_script = '/u/dssc/tolloi/Cluster_Basecalling_Manager/software/orfeo_executable/executable_dgx001/supervisor.sh'
    engine_outputdir = "/AB_20T_output/nanopore_output/run_dgx001-dgx002_dataset_170/results"
    engine_inputdir = "/AB_20T_input/dataset/dataset_170"
    engine_polling_interval = 1
    engine_id = "dgx001_engine"
    engine_optimal_request_size = 50
    keep_alive_terminate_url = "http://127.0.0.1:5000/completed"
    keep_alive_url = "http://127.0.0.1:5000/keepalive"

