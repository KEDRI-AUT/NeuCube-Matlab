function Export_ow_Callback(hObject, eventdata, handles)
h=gcf;
neucube=handles.neucube;
[file,path] = uiputfile('*.csv','Save Workspace As','OutlayerWeight.csv');
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    set(h,'Pointer','watch');
    if isfield(neucube.classifier,'output_neurals_test_weight')
        csvwrite(strcat(path,file),neucube.classifier.output_neurals_test_weight)
    elseif isfield(neucube.classifier,'output_neurals_train_weight')
        csvwrite(strcat(path,file),neucube.classifier.output_neurals_train_weight)
    end
    set(h,'Pointer','arrow');
end