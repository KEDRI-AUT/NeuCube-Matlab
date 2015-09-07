function verify_classifier_btn_Callback(hObject, eventdata, handles)
h=gcf;
global vidObj
dataset=handles.dataset;

if ~isfield(handles, 'neucube')
    msgbox('Please load a neucube first!');
    return
end
neucube=handles.neucube;
if isempty(dataset.data)
    msgbox('Please load a dataset!');
    return;
end
if isempty(neucube.neucube_weight) || neucube.number_of_input<=0
    msgbox('Please load a neucube!');
    return;
end

if dataset.type~=3
    if dataset.feature_number~=neucube.number_of_input || dataset.type ~= neucube.type
        msgbox('The NeuCube cannot process this dataset!');
        return;
    end
else
    dataset.type=neucube.type;
end
if (dataset.spike_state_for_validation)
    msgbox('Please encode the data first!');
    return
end

sample_amount=dataset.sample_amount_for_validation;
target_value=dataset.target_value_for_validation;
[x, y]=plot_output_layer(handles.output_layer, sample_amount, target_value, dataset.type,[], false);
handles.classifier_visual=-1;

set(h,'Pointer','watch');
pause(0.01);

[predict_value_for_validation, neucube]=Neucube_verification(dataset, neucube,handles);

neucube.step=6;
update_cube(neucube, handles);
set(h,'Pointer','arrow');
neucube.classifier.x=x;
neucube.classifier.y=y;
handles.neucube=neucube;
dataset.predict_value_for_validation=predict_value_for_validation;
handles.dataset=dataset;
guidata(hObject, handles);
ui_state(handles, 6, 0);
if ~isempty(dataset.target_value)
    output_result(dataset, handles);
    RegressionAnalysisPanel(dataset);
else % recall
    RecallResultsPanel(dataset);
end

if  isobject(vidObj) && isvalid(vidObj)
    close(vidObj);
    delete(vidObj);
    output_information('Video recording finished!',handles);
end