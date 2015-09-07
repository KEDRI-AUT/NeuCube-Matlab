function param_grid=getparam(handles)
param_grid=zeros(8,3);
 param_grid(1,1)=str2num(get(handles.aer_threshold_minimum_edit,'string'));
    param_grid(1,2)=str2num(get(handles.aer_threshold_step_edit,'string'));
    param_grid(1,3)=str2num(get(handles.aer_threshold_maximum_edit,'string'));
    
    param_grid(2,1)=str2num(get(handles.connection_distance_minimum_edit,'string'));
    param_grid(2,2)=str2num(get(handles.connection_distance_step_edit,'string'));
    param_grid(2,3)=str2num(get(handles.connection_distance_maximum_edit,'string'));
    
    param_grid(3,1)=str2num(get(handles.stdp_rate_minimum_edit,'string'));
    param_grid(3,2)=str2num(get(handles.stdp_rate_step_edit,'string'));
    param_grid(3,3)=str2num(get(handles.stdp_rate_maximum_edit,'string'));
    
    param_grid(4,1)=str2num(get(handles.threshold_of_firing_minimum_edit,'string'));
    param_grid(4,2)=str2num(get(handles.threshold_of_firing_step_edit,'string'));
    param_grid(4,3)=str2num(get(handles.threshold_of_firing_maximum_edit,'string'));
    
    param_grid(5,1)=str2num(get(handles.refactory_time_minimum_edit,'string'));
    param_grid(5,2)=str2num(get(handles.refactory_time_step_edit,'string'));
    param_grid(5,3)=str2num(get(handles.refactory_time_maximum_edit,'string'));
    
    param_grid(6,1)=str2num(get(handles.training_time_minimum_edit,'string'));
    param_grid(6,2)=str2num(get(handles.training_time_step_edit,'string'));
    param_grid(6,3)=str2num(get(handles.training_time_maximum_edit,'string'));
    
    param_grid(7,1)=str2num(get(handles.mod_minimum_edit,'string'));
    param_grid(7,2)=str2num(get(handles.mod_step_edit,'string'));
    param_grid(7,3)=str2num(get(handles.mod_maximum_edit,'string'));
    
    param_grid(8,1)=str2num(get(handles.drift_minimum_edit,'string'));
    param_grid(8,2)=str2num(get(handles.drift_step_edit,'string'));
    param_grid(8,3)=str2num(get(handles.drift_maximum_edit,'string'));