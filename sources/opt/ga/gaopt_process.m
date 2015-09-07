function err=gaopt_process(params)
global loop_number gui_params best_params best_result best_neucube  t1  PopulationSize handless
loop_number=loop_number+1;
gui_params2=gui_params;
handles=[];
gui_params2.encoding.spike_threshold=params(1);
gui_params2.init.small_world_radius=params(2);
gui_params2.unsup.STDP_rate=params(3);
gui_params2.unsup.threshold_of_firing=params(4);
gui_params2.unsup.refactory_time=round(params(5));
gui_params2.unsup.training_round=round(params(6));
gui_params2.sup.mod=params(7);
gui_params2.sup.drift=params(8);

fprintf('    AER  threshold:%.03f, Small world radius:%.03f,  STDP rate:%.03f,  Firing threshold:%.03f\n',gui_params2.encoding.spike_threshold, gui_params2.init.small_world_radius, gui_params2.unsup.STDP_rate, gui_params2.unsup.threshold_of_firing);
fprintf('    Refractory time:%d,      Train     round:%d,      deSNN mod:%.03f,   deSNN      drift:%.03f\n',gui_params2.unsup.refactory_time,gui_params2.unsup.training_round, gui_params2.sup.mod,gui_params2.sup.drift);

global dataset
neucube=reset_neucube(dataset,gui_params2);
neucube.small_world_radius=gui_params2.init.small_world_radius;
neucube.input_mapping{1}=gui_params2.init.mapping_coordinate;
if  isempty(neucube.input_mapping{1})
    neucube=graph_matching_mapping(dataset, neucube, gui_params2.init.neuron_number_x, gui_params2.init.neuron_number_y, gui_params2.init.neuron_number_z);
end

if gui_params2.init.neuron_coord_method==1
    neucube.neuron_location=compute_neuron_coordinate(gui_params2.init.neuron_number_x, gui_params2.init.neuron_number_y, gui_params2.init.neuron_number_z);
    neucube.number_of_neucube_neural=gui_params2.init.neuron_number_x*gui_params2.init.neuron_number_y*gui_params2.init.neuron_number_z;
    neucube.is_extended=false;
else
    neucube.neuron_location=gui_params2.init.neuron_location;
    neucube.neuron_number_x=0;
    neucube.neuron_number_y=0;
    neucube.neuron_number_z=0;
    neucube.number_of_neucube_neural=size(neucube.neuron_location,1);
    neucube.is_extended=false;
end
global cv_number
[ground_truth_label, predicted_label]=set_cube(neucube, handles, dataset, gui_params2,cv_number);
if dataset.number_of_class==1
    err=sum(abs(ground_truth_label-predicted_label));
else
    err=sum(ground_truth_label~=predicted_label)/numel(ground_truth_label);
end
if  err<best_result
    best_result=err;
    best_params=gui_params2;
    best_neucube=neucube;
end

if mod(loop_number,PopulationSize)==0
    t2=clock;
    time_cost=etime(t2,t1);
    str=fprintf('Generation %d finished. Total time elapsed: %.02fmin\n',round(loop_number/PopulationSize-1), time_cost/60);
    output_information(str,handless);
    fprintf('Generation %d finished. Total time elapsed: %.02fmin\n',round(loop_number/PopulationSize-1), time_cost/60);
    fprintf('====================================================================\n');
end
