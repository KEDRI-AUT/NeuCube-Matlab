function file_load_dataset_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end

data=load(strcat(PathName,FileName));

if ~isfield(data,'dataset')
    msgbox('Please select a dataset file!');
    return;
end
dataset=data.dataset;
handles.dataset=dataset;
guidata(hObject,handles);

ui_state(handles, 1, 0); % change ui state
if dataset.type==1
    set(handles.training_classifier_btn,'string','Train Classifier...');
    set(handles.verify_classifier_btn,'string','Verifiy Classifier');
elseif dataset.type==2
    set(handles.training_classifier_btn,'string','Train Regressor...');
    set(handles.verify_classifier_btn,'string','Verifiy Regressor');
end

str=sprintf('Dataset Information:\n    sample number: %d\n    feature number: %d\n    time length: %d\n    class number: %d\n\nTask Type: Classification',...
    dataset.total_sample_number, dataset.feature_number, dataset.length_per_sample, dataset.number_of_class);
output_information(str, handles);