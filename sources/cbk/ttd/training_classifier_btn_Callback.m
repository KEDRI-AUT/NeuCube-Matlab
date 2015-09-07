function training_classifier_btn_Callback(hObject, eventdata, handles)
h=gcf;
global vidObj

dataset=handles.dataset;
neucube=handles.neucube;
if isempty(dataset.data)
    msgbox('Please load a dataset!');
    return;
end
if dataset.feature_number~=neucube.number_of_input || dataset.type ~= neucube.type
    msgbox('The NeuCube cannot process this dataset!');
    return;
end

sup_params=handles.gui_params.sup;
sup_params=TrainingClassifierPanel(sup_params);
if ~isstruct(sup_params)
    return;
end

I=imread('arrow.png');
imshowh(handles.axes4,I);
imshowh(handles.axes5,I);
sample_amount=dataset.sample_amount_for_training;
target_value=dataset.target_value_for_training;
[x, y]=plot_output_layer(handles.output_layer, sample_amount, target_value, dataset.type, [],false);
handles.classifier_visual=-1;

set(h,'Pointer','watch');
drawnow
pause(0.01);

classifier_flag=sup_params.classifier_flag;
mod=sup_params.mod;
drift=sup_params.drift;
K=sup_params.K;
sigma=sup_params.sigma;

neucube.classifier=reset_classifier(sup_params); % empty classifier
neucube.classifier_flag=classifier_flag;
neucube.classifier.mod=mod;
neucube.classifier.drift=drift;
neucube.classifier.K=K;
neucube.classifier.sigma=sigma;
neucube.classifier.x=x;
neucube.classifier.y=y;

neucube=Neucube_supervised(dataset, neucube,handles);

%do the job
neucube.step=5;
update_cube(neucube, handles);
set(h,'Pointer','arrow');
handles.neucube=neucube;
handles.gui_params.sup=sup_params;
guidata(hObject, handles);
ui_state(handles, 5, 0);
str=sprintf('Training Classifier Parameters:\n  Mod:%.02f\n  Drift:%.02f\n  KNN:%d\n  Sigma:%.02f\n\n Training Classifier Finished!',...
    neucube.classifier.mod,neucube.classifier.drift,neucube.classifier.K, neucube.classifier.sigma);
output_information(str, handles);

if  isobject(vidObj) && isvalid(vidObj)
    close(vidObj);
    delete(vidObj);
    output_information('Video recording finished!',handles);
end