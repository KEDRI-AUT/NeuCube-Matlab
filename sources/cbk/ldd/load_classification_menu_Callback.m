function load_classification_menu_Callback(hObject, eventdata, handles)

% [FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
% if isempty(FileName) || isa(FileName,'double')==1
%     msgbox('Cannot open the file!');
%     return;
% end
% h=gcf;
% set(h,'Pointer','watch');
% dataset=load_dataset(strcat(PathName,FileName), true);
dataset=load_csv(true);
set(handles.file_text,'string',dataset.file_name);
% folder_name = uigetdir;
% Files=dir(folder_name);
% N=0;
% for k=1:length(Files)
%     if Files(k).name(1)=='.'
%         continue;
%     end
%     if strcmpi(Files(k).name,'class_label')
%         continue;
%     end
%     N=N+1;
% end
if numel(dataset.data)<2
    return
end
handles.dataset=dataset;
guidata(hObject,handles);

ui_state(handles, 1, 0); % change ui state
set(handles.training_classifier_btn,'string','Train Classifier...');
set(handles.verify_classifier_btn,'string','Verifiy Classifier');

str=sprintf('Dataset Information:\n    sample number: %d\n    feature number: %d\n    time length: %d\n    class number: %d\n\nTask Type: Classification',...
    dataset.total_sample_number, dataset.feature_number, dataset.length_per_sample, dataset.number_of_class);
output_information(str, handles);