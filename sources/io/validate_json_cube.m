function [ is_valid ] = validate_json_cube( neucube )
%VALIDATE_JSON_CUBE Summary of this function goes here
%   Detailed explanation goes here
is_valid=0;
if(~isfield(neucube.structure,'neuron_count')||~isfield(neucube.structure,'input_neuron_count')||~isfield(neucube.structure,'spike_state_count')||~isfield(neucube.structure,'connection_matrix')||~isfield(neucube.structure,'weight_matrix')||~isfield(neucube.structure,'input_names')||~isfield(neucube.structure,'spike_states')||~isfield(neucube.structure,'STDP_rate')||~isfield(neucube.structure,'threshold_of_firing')||~isfield(neucube.structure,'potential_leak_rate')||~isfield(neucube.structure,'refactory_time')||~isfield(neucube.structure,'spike_transmission_amount')||~isfield(neucube.structure,'input_indices'))
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(~isfield(neucube,'is_extended')||~isfield(neucube,'input_neighbors')||~isfield(neucube,'small_world_radius')||~isfield(neucube,'LDC_probability')||~isfield(neucube,'LDC_initial_weight')||~isfield(neucube,'training_round')||~isfield(neucube,'step')||~isfield(neucube,'type')||~isfield(neucube,'filetype'))   
    disp('hi')
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(~isfield(neucube,'classifier')||~isfield(neucube.classifier,'classifier_flag')||~isfield(neucube.classifier,'output_neurals_weight_dim1')||~isfield(neucube.classifier,'output_neurals_weight_dim2')||~isfield(neucube.classifier,'mod')||~isfield(neucube.classifier,'drift')||~isfield(neucube.classifier,'K')||~isfield(neucube.classifier,'sigma'))   
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(~isfield(neucube.classifier,'C')||~isfield(neucube.classifier,'output_neurals_weight')||~isfield(neucube.classifier,'training_target_value')||~isfield(neucube.classifier,'output_neurals_PSP')||~isfield(neucube.classifier,'firing_order')||~isfield(neucube.classifier,'x')||~isfield(neucube.classifier,'y'))
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(neucube.filetype~=3)
    msgbox('filetype is not set to 3.')
    return
else
    is_valid=1;
end

end

