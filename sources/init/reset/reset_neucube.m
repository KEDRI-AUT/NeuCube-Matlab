function neucube=reset_neucube(dataset, gui_params, classifier)
neucube.neuron_location=[]; 
neucube.neucube_connection=[]; 
neucube.neucube_weight=[]; 

neucube.neumid=[];  
neucube.input_mapping{1}=[]; 
neucube.input_mapping{2}=dataset.feature_name;
neucube.indices_of_input_neuron=[]; 

neucube.is_extended=false; 
neucube.small_world_radius=gui_params.init.small_world_radius; 
neucube.number_of_neucube_neural=gui_params.init.neuron_number_x*gui_params.init.neuron_number_y*gui_params.init.neuron_number_z;


neucube.number_of_input=dataset.feature_number; 
neucube.STDP_rate=gui_params.unsup.STDP_rate;
neucube.threshold_of_firing=gui_params.unsup.threshold_of_firing;
neucube.potential_leak_rate=gui_params.unsup.potential_leak_rate;
neucube.refactory_time=gui_params.unsup.refactory_time;
neucube.LDC_probability=gui_params.unsup.LDC_probability;
neucube.LDC_initial_weight=0.05;
neucube.training_round=gui_params.unsup.training_round;


neucube.neucube_output=[]; 
neucube.spike_transmission_amount=[]; 

neucube.step=3;
neucube.type=dataset.type;
if nargin>2
    neucube.classifier=classifier;
else
    neucube.classifier_flag=1;
    neucube.classifier.mod=gui_params.sup.mod;
    neucube.classifier.drift=gui_params.sup.drift;
    neucube.classifier.K=gui_params.sup.K;
    neucube.classifier.sigma=gui_params.sup.sigma;
    neucube.classifier.output_neurals_weight=[];
end