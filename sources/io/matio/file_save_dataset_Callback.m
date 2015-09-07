function file_save_dataset_Callback(hObject, eventdata, handles)
h=gcf;
[file,path] = uiputfile('*.mat','Save Workspace As',strcat('dataset_',datestr(now,30),'.mat'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    set(h,'Pointer','watch');
    dataset=handles.dataset;
    save(strcat(path,file),'dataset');
end
output_information('Data set is saved sucessfully!', handles);
set(h,'Pointer','arrow');