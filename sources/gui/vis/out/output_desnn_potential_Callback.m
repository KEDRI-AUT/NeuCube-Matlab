function output_desnn_potential_Callback(hObject, eventdata, handles)
handles.classifier_visual=0;
dataset=handles.dataset;
neucube=handles.neucube;
if neucube.step==5
    sample_amount=dataset.sample_amount_for_training;
elseif neucube.step==6
    sample_amount=dataset.sample_amount_for_validation;
end
target_value=handles.neucube.classifier.output_neurals_PSP;
if isempty(target_value)
    return
end
plot_output_layer(handles.output_layer, sample_amount, target_value, 2, [], true);
guidata(hObject, handles);