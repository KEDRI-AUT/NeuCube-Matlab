function output_connection_strength_Callback(hObject, eventdata, handles)
handles.classifier_visual=1;
output_layer_ButtonDownFcn(hObject, eventdata, handles);
guidata(hObject, handles);
output_information('Brighter neuron means larger connection weight.', handles);