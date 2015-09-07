function initparam(handles, param_grid)
set(handles.aer_threshold_minimum_edit,'string',num2str(param_grid(1,1)));
set(handles.aer_threshold_step_edit,'string',num2str(param_grid(1,2)));
set(handles.aer_threshold_maximum_edit,'string',num2str(param_grid(1,3)));

set(handles.connection_distance_minimum_edit,'string',num2str(param_grid(2,1)));
set(handles.connection_distance_step_edit,'string',num2str(param_grid(2,2)));
set(handles.connection_distance_maximum_edit,'string',num2str(param_grid(2,3)));

set(handles.stdp_rate_minimum_edit,'string',num2str(param_grid(3,1)));
set(handles.stdp_rate_step_edit,'string',num2str(param_grid(3,2)));
set(handles.stdp_rate_maximum_edit,'string',num2str(param_grid(3,3)));

set(handles.threshold_of_firing_minimum_edit,'string',num2str(param_grid(4,1)));
set(handles.threshold_of_firing_step_edit,'string',num2str(param_grid(4,2)));
set(handles.threshold_of_firing_maximum_edit,'string',num2str(param_grid(4,3)));

set(handles.refactory_time_minimum_edit,'string',num2str(param_grid(5,1)));
set(handles.refactory_time_step_edit,'string',num2str(param_grid(5,2)));
set(handles.refactory_time_maximum_edit,'string',num2str(param_grid(5,3)));

set(handles.training_time_minimum_edit,'string',num2str(param_grid(6,1)));
set(handles.training_time_step_edit,'string',num2str(param_grid(6,2)));
set(handles.training_time_maximum_edit,'string',num2str(param_grid(6,3)));

set(handles.mod_minimum_edit,'string',num2str(param_grid(7,1)));
set(handles.mod_step_edit,'string',num2str(param_grid(7,2)));
set(handles.mod_maximum_edit,'string',num2str(param_grid(7,3)));

set(handles.drift_minimum_edit,'string',num2str(param_grid(8,1)));
set(handles.drift_step_edit,'string',num2str(param_grid(8,2)));
set(handles.drift_maximum_edit,'string',num2str(param_grid(8,3)));