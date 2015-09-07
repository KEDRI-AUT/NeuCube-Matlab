function options_set_parameters_Callback(hObject, eventdata, handles)
dataset=handles.dataset;
if isempty(dataset.data)
    msgbox('Please load you dataset first!');
    return;
end
gui_params=SetParameterPanel(handles.gui_params, dataset.feature_number, dataset.feature_name);
if isstruct(gui_params)
    handles.gui_params=gui_params;
    guidata(hObject, handles);
end