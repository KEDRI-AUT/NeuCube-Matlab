function load_regression_menu_Callback(hObject, eventdata, handles)
% h=gcf;
% [FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
% if isempty(FileName) || isa(FileName,'double')==1
%     msgbox('Cannot open the file!');
%     return;
% end
% set(h,'Pointer','watch');
% dataset=load_dataset(strcat(PathName,FileName), false);

dataset=load_csv(false);
if numel(dataset.data)<2
    return
end
handles.dataset=dataset;
guidata(hObject,handles);

ui_state(handles, 1, 0);
set(handles.training_classifier_btn,'string','Train Regressor...');
set(handles.verify_classifier_btn,'string','Verifiy Regressor');
% set(h,'Pointer','arrow');

str=sprintf('Dataset Information:\n    sample number: %d\n    feature number: %d\n    time length: %d\n    class number: %d\n\nTask Type: Regression',...
    dataset.total_sample_number, dataset.feature_number, dataset.length_per_sample, dataset.number_of_class);
output_information(str, handles);