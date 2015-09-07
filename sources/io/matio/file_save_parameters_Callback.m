function file_save_parameters_Callback(hObject, eventdata, handles)
[file,path] = uiputfile('*.mat','Save Workspace As',strcat('parameters_',datestr(now,30),'.mat'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    gui_params=handles.gui_params;
    save(strcat(path,file),'gui_params');
end
output_information('Parameters are saved sucessfully!', handles);