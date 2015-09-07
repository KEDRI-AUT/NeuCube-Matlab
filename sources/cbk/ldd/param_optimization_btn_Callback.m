function param_optimization_btn_Callback(hObject, eventdata, handles)
global init_neucube best_neucube best_params best_result gui_params dataset cv_number t1 loop_number show_progress_bar xx yy PopulationSize handless

% show_progress_bar=true;
loop_number=0;
neucube=handles.neucube;
dataset=handles.dataset;
gui_params=handles.gui_params;
handless=handles;
if isempty(dataset.data)
    msgbox('Please load data set first');
    return;
end
param_grid=zeros(8,3);
init_state;
[confirmation,param_grid,checkstate, cv_number, optool, toolparams]=ParameterOptimizationPanel(param_grid);
if confirmation==0 || sum(checkstate)==0
    return;
end
pause(0.01);
% set(gcf,'pointer','watch');
drawnow;
fprintf('\nOptimized Parameters are:\n');
parse_state;

t1=clock;
set(handles.visual_type_pop,'value',1);
set(handles.visual_content_pop,'enable','off');
set(handles.update_speed_edit,'enable','off');
set(handles.save_to_movie_check,'enable','off');
set(handles.neuron_legend_check,'enable','off');
set(handles.next_step_btn,'enable','off');
set(handles.show_threshold_edit,'enable','off');

training_time_length=gui_params.encoding.training_time_length;
validation_time_length=gui_params.encoding.validation_time_length;
training_set_ratio=gui_params.encoding.training_set_ratio;
dataset.training_time_length=floor(size(dataset.data,1)*training_time_length);
dataset.validation_time_length=floor(size(dataset.data,1)*validation_time_length);
dataset.training_set_ratio=training_set_ratio;perop;