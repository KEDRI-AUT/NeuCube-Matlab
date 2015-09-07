function file_load_neucube_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end

load(strcat(PathName,FileName));
if ~exist('neucube','var')
    msgbox('Please select a NeuCube file!');
    return;
end

handles.neucube=neucube;
ui_state(handles, neucube.step, 0);
update_cube(neucube, handles);
guidata(hObject,handles);
output_information('Neucube is loaded sucessfully!', handles);