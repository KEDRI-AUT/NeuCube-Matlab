function file_save_neucube_Callback(hObject, eventdata, handles)
[file,path] = uiputfile('*.mat','Save Workspace As',strcat('neucube_',datestr(now,30),'.mat'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    neucube=handles.neucube;
    save(strcat(path,file),'neucube', '-v7.3');
end
output_information('NeuCube is saved sucessfully!', handles);