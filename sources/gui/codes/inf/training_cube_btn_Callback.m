function training_cube_btn_Callback(hObject, eventdata, handles)
h=gcf;
global neucube_weight_befor_training vidObj

dataset=handles.dataset;
neucube=handles.neucube;
if isempty(dataset.data)
    msgbox('Please load a dataset!');
    return
end
if dataset.feature_number~=neucube.number_of_input || dataset.type ~= neucube.type
    msgbox('The NeuCube cannot process this dataset!');
    return
end
% if neucube.number_of_neucube_neural>=2000
%     msgbox('Limited version must have less than 2000 neurons');
%     return;
% end
unsup_params=handles.gui_params.unsup;
unsup_params=TrainingCubePanel(unsup_params);
if ~isstruct(unsup_params)
    return
end
set(h,'Pointer','watch');
drawnow
pause(0.01);

neucube.STDP_rate=unsup_params.STDP_rate;
neucube.threshold_of_firing=unsup_params.threshold_of_firing;
neucube.potential_leak_rate=unsup_params.potential_leak_rate;
neucube.refactory_time=unsup_params.refactory_time;
neucube.LDC_probability=unsup_params.LDC_probability;
neucube.LDC_initial_weight=0.05;
neucube.training_round=unsup_params.training_round;
neucube_weight_befor_training=neucube.neucube_weight;
neucube=Neucube_unsupervised(dataset, neucube, handles);

%do the job
neucube.step=4;
update_cube(neucube, handles);
set(h,'Pointer','arrow');
handles.neucube=neucube;
handles.gui_params.unsup=unsup_params;
guidata(hObject, handles);
ui_state(handles, 4, 0);
str=sprintf('Training Parameters:\n  STDP Rate: %.02f\n  Firing Threshold: %.02f\n  Potential Leak Rate: %.04f\n  Refractory Time:%d\n  LDC Probability: %.03f\n  Training Round: %d\n\n Training Cube Finished!',...
    neucube.STDP_rate, neucube.threshold_of_firing, neucube.potential_leak_rate, neucube.refactory_time, neucube.LDC_probability,neucube.training_round);
output_information(str, handles);

if  isobject(vidObj) && isvalid(vidObj)
    close(vidObj);
    delete(vidObj);
    output_information('Video recording finished!',handles);
end