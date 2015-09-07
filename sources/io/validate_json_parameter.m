function [is_valid] = validate_json_parameter( parameter )
%VALIDATE_JSON_PARAMETER Summary of this function goes here
%   Detailed explanation goes here
is_valid=0;
if(~isfield(parameter,'encoding')||~isfield(parameter,'init')||~isfield(parameter,'unsup')||~isfield(parameter,'sup'))
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(~isfield(parameter.encoding,'method')||~isfield(parameter.encoding,'spike_threshold')||~isfield(parameter.encoding,'training_set_ratio')||~isfield(parameter.encoding,'training_time_length')||~isfield(parameter.encoding,'validation_time_length')||~isfield(parameter.encoding,'window_size')||~isfield(parameter.encoding,'filter_type'))
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(~isfield(parameter.init,'neuron_number_x')||~isfield(parameter.init,'neuron_number_y')||~isfield(parameter.init,'neuron_number_z')||~isfield(parameter.init,'small_world_radius')||~isfield(parameter.init,'input_mapping')||~isfield(parameter.init,'mapping_coordinate')||~isfield(parameter.init,'neuron_coord_method')||~isfield(parameter.init,'neuron_location')||~isfield(parameter.unsup,'potential_leak_rate')||~isfield(parameter.unsup,'STDP_rate')||~isfield(parameter.unsup,'threshold_of_firing')||~isfield(parameter.unsup,'training_round')||~isfield(parameter.unsup,'refactory_time')||~isfield(parameter.unsup,'LDC_probability'))
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return
elseif(~isfield(parameter.sup,'classifier_flag')||~isfield(parameter.sup,'mod')||~isfield(parameter.sup,'drift')||~isfield(parameter.sup,'K')||~isfield(parameter.sup,'sigma'))
    msgbox('atleast one of the mandatory field is non existent!!Please check the manual for JSON file structure.');
    return    
elseif(parameter.filetype~=1)
    msgbox('filetype is not set to 1.')
    return
else
    is_valid=1;
end


end

