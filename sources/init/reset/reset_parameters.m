function gui_params=reset_parameters()
gui_params.encoding.method=1;
gui_params.encoding.spike_threshold=0.5;
gui_params.encoding.training_set_ratio=0.5;
gui_params.encoding.training_time_length=1; 
 gui_params.encoding.validation_time_length=1;
gui_params.encoding.window_size=5;
gui_params.encoding.filter_type=1;
                   
gui_params.init.neuron_number_x=10;
gui_params.init.neuron_number_y=10;
gui_params.init.neuron_number_z=10;
gui_params.init.small_world_radius=2.5;
gui_params.init.input_mapping=1;
gui_params.init.mapping_coordinate=[];
gui_params.init.neuron_coord_method=1;
gui_params.init.neuron_location=[];

gui_params.unsup.potential_leak_rate=0.002;
gui_params.unsup.STDP_rate=0.01;
gui_params.unsup.threshold_of_firing=0.5;
gui_params.unsup.training_round=1;
gui_params.unsup.refactory_time=6;
gui_params.unsup.LDC_probability=0;

gui_params.sup.classifier_flag=1;
gui_params.sup.mod=0.8;
gui_params.sup.drift=0.005;
gui_params.sup.K=3;
gui_params.sup.sigma=1;
gui_params.sup.C=1;
