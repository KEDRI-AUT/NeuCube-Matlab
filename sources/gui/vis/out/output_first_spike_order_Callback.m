function output_first_spike_order_Callback(hObject, eventdata, handles)
handles.classifier_visual=2;
output_layer_ButtonDownFcn(hObject, eventdata, handles);
guidata(hObject, handles);
output_information('Brighter neuron means firing earlier.',handles);