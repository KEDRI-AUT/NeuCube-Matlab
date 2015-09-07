function file_load_parameters_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end

load(strcat(PathName,FileName));
if ~exist('gui_params','var')
    msgbox('Please select a NeuCube parameter file!');
    return;
end
handles.gui_params=gui_params;
guidata(hObject,handles);
output_information('Parameters are loaded sucessfully!', handles);