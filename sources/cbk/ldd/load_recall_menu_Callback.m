function load_recall_menu_Callback(hObject, eventdata, handles)
% h=gcf;
% [FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
% if isempty(FileName) || isa(FileName,'double')==1
%     msgbox('Cannot open the file!');
%     return;
% end
% set(h,'Pointer','watch');
% dataset=load_dataset(strcat(PathName,FileName), []);
dataset=load_csv([]);
if numel(dataset.data)<2
    return
end
handles.dataset=dataset;
guidata(hObject,handles);

ui_state(handles, 1, 1);

% set(h,'Pointer','arrow');

str=sprintf('Dataset Information:\n    sample number: %d\n    feature number: %d\n    time length: %d\n\nTask Type: Recall',...
    dataset.total_sample_number, dataset.feature_number, dataset.length_per_sample);
output_information(str, handles);