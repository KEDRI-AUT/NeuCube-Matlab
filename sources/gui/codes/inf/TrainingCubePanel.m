function varargout = TrainingCubePanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainingCubePanel_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainingCubePanel_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function TrainingCubePanel_OpeningFcn(hObject, eventdata, handles, varargin)
unsup_params=varargin{1};
set(hObject,'windowstyle','modal');
handles.confirmation=0;

if isstruct(unsup_params)
    set(handles.potential_leak_rate_edit,'string', unsup_params.potential_leak_rate);
    set(handles.STDP_rate_edit, 'string', unsup_params.STDP_rate);
    set(handles.threshold_of_firing_edit, 'string', unsup_params.threshold_of_firing);
    set(handles.training_round_edit, 'string', unsup_params.training_round);
    set(handles.refactory_time_edit, 'string', unsup_params.refactory_time);
    set(handles.LDC_probability_edit, 'string', unsup_params.LDC_probability);
end
handles.unsup_params=unsup_params;
guidata(hObject, handles);
uiwait(hObject);

function training_cube_panel_ok_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close

function training_cube_panel_cancel_Callback(hObject, eventdata, handles)
handles.confirmation=0;
guidata(hObject,handles);
close

function figure1_CloseRequestFcn(hObject, eventdata, handles)
if handles.confirmation==1
    unsup_params.potential_leak_rate=str2double(get(handles.potential_leak_rate_edit,'string'));
    unsup_params.STDP_rate=str2double(get(handles.STDP_rate_edit, 'string'));
    unsup_params.threshold_of_firing=str2double(get(handles.threshold_of_firing_edit,'string'));
    unsup_params.training_round=str2double(get(handles.training_round_edit, 'string'));
    unsup_params.refactory_time=str2double(get(handles.refactory_time_edit, 'string'));
    unsup_params.LDC_probability=str2double(get(handles.LDC_probability_edit,'string'));
    
    handles.unsup_params=unsup_params;
    guidata(hObject, handles);
end
if isequal(get(hObject,'waitstatus'),'waiting') 
    uiresume(hObject);
else
    delete(hObject);
end

% --- Outputs from this function are returned to the command line.
function varargout = TrainingCubePanel_OutputFcn(hObject, eventdata, handles) 
if ishandle(hObject)
    if handles.confirmation==1
        varargout{1} = handles.unsup_params;
    else
        varargout{1}=0;
    end
    delete(hObject);
end


function potential_leak_rate_edit_Callback(hObject, eventdata, handles)


function potential_leak_rate_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threshold_of_firing_edit_Callback(hObject, eventdata, handles)


function threshold_of_firing_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refactory_time_edit_Callback(hObject, eventdata, handles)


function refactory_time_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function STDP_rate_edit_Callback(hObject, eventdata, handles)


function STDP_rate_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_round_edit_Callback(hObject, eventdata, handles)


function training_round_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function LDC_probability_edit_Callback(hObject, eventdata, handles)


function LDC_probability_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
