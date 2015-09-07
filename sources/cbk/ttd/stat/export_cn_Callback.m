function export_cn_Callback(hObject, eventdata, handles)
h=gcf;
neucube=handles.neucube;
[file,path] = uiputfile('*.csv','Save Workspace As','ConnectionWeight.csv');
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    set(h,'Pointer','watch');
    csvwrite(strcat(path,file),neucube.neucube_weight)
    set(h,'Pointer','arrow');
end