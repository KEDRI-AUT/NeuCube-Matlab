function initialize_cube_btn_Callback(hObject, eventdata, handles)
h=gcf;
dataset=handles.dataset;
feature_number=dataset.feature_number;
feature_name=dataset.feature_name;
if isempty(dataset.data)
    msgbox('Please load a dataset!');
    return;
end

init_params=handles.gui_params.init;
init_params=InitializationPanel(init_params,feature_number, feature_name);
if ~isstruct(init_params)
    return;
end

set(h,'Pointer','watch');
drawnow
pause(0.01);
neucube=reset_neucube(dataset, handles.gui_params);
neucube.small_world_radius=init_params.small_world_radius;
neucube.input_mapping{1}=init_params.mapping_coordinate;
if  init_params.input_mapping==1 || isempty(neucube.input_mapping{1})%auto mapping
    neucube=graph_matching_mapping(dataset, neucube, init_params.neuron_number_x, init_params.neuron_number_y, init_params.neuron_number_z);
end

if init_params.neuron_coord_method==1
    
    neucube.neuron_location=compute_neuron_coordinate(init_params.neuron_number_x,init_params.neuron_number_y, init_params.neuron_number_z);
    neucube.number_of_neucube_neural=init_params.neuron_number_x*init_params.neuron_number_y*init_params.neuron_number_z;
    neucube.is_extended=false;
    str=sprintf('Initialization Parameters:\n  Neuron Number: X=%d, Y=%d, Z=%d\n  Total Neuron Number: %d\n  Small World Radius: %.02f\n\nInitialization finished!',init_params.neuron_number_x, init_params.neuron_number_y, init_params.neuron_number_z,...
    neucube.number_of_neucube_neural, neucube.small_world_radius);
else
   
    
    neucube.neuron_location=init_params.neuron_location;
     neucube.number_of_neucube_neural=size(neucube.neuron_location,1);
    neucube.is_extended=false;
    str=sprintf('Initialization Parameters:\n  Total Neuron Number: %d\n  Small World Radius: %.02f\n\nInitialization finished!',...
    neucube.number_of_neucube_neural, neucube.small_world_radius);
end
neucube=Neucube_initialization(neucube);
neucube.step=3;

if ishandle(handles.Axes_signal)
    cla(handles.Axes_signal, 'reset');
    set(handles.Axes_signal,'visible','off');
end
cube_pos=handles.cube_pos;
set(handles.cube,'Position',cube_pos);
update_cube(neucube, handles);
set(h,'Pointer','arrow');
ui_state(handles, 3, 0);
handles.neucube=neucube;
handles.gui_params.init=init_params;
guidata(hObject, handles);

output_information(str, handles);