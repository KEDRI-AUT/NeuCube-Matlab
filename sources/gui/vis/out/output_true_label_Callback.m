function output_true_label_Callback(hObject, eventdata, handles)
handles.classifier_visual=0;
dataset=handles.dataset;
neucube=handles.neucube;
if neucube.step==5
    sample_amount=dataset.sample_amount_for_training;
    target_value=dataset.target_value_for_training;
elseif neucube.step==6
    sample_amount=dataset.sample_amount_for_validation;
    target_value=dataset.target_value_for_validation;  
end
plot_output_layer(handles.output_layer, sample_amount, target_value, dataset.type, [], true);
guidata(hObject, handles);