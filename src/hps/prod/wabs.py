
import hps

def produce_wabs(energy : float, run : int): 
    command = '/software/hps-mg/mg4/wabs/wab_template/bin/ ' \
            './generate_events; cp ../Events/* /current'
    
    hps.execute(command)
