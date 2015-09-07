function output_predicted_label_Callback(hObject, eventdata, handles)
handles.classifier_visual=0;
dataset=handles.dataset;
sample_amount=dataset.sample_amount_for_validation;
target_value=dataset.predict_value_for_validation;
if isempty(target_value)
    return
end
plot_output_layer(handles.output_layer, sample_amount, target_value, dataset.type, [], true);
guidata(hObject, handles);