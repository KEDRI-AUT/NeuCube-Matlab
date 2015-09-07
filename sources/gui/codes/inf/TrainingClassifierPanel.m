function varargout = TrainingClassifierPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainingClassifierPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainingClassifierPanel_OutputFcn, ...
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


function TrainingClassifierPanel_OpeningFcn(hObject, eventdata, handles, varargin)
sup_params=varargin{1};
set(hObject,'windowstyle','modal');
handles.confirmation=0;

if isstruct(sup_params)
    set(handles.classifier_pop,'value', sup_params.classifier_flag);
    if sup_params.classifier_flag==1
        set(handles.mod_edit, 'string', sup_params.mod);
        set(handles.drift_edit, 'string', sup_params.drift);
        set(handles.K_edit, 'string', sup_params.K);
        set(handles.sigma_edit, 'string', sup_params.sigma);
        set(handles.C_edit, 'string', sup_params.C);
    end
end
handles.sup_params=sup_params;
guidata(hObject, handles);
uiwait(hObject);

function classifier_panel_ok_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close

function classifier_panel_cancel_Callback(hObject, eventdata, handles)
handles.confirmation=0;
guidata(hObject,handles);
close

function figure1_CloseRequestFcn(hObject, eventdata, handles)
if handles.confirmation==1
    classifier=get(handles.classifier_pop,'value');
    sup_params.classifier_flag=classifier;
    switch classifier
        case 1
            sup_params.mod=str2double(get(handles.mod_edit, 'string'));
            sup_params.drift=str2double(get(handles.drift_edit, 'string'));
            sup_params.K=str2double(get(handles.K_edit, 'string'));
            sup_params.sigma=str2double(get(handles.sigma_edit, 'string'));
            sup_params.C=str2double(get(handles.C_edit, 'string'));
    end
    handles.sup_params=sup_params;
    guidata(hObject, handles);
end
if isequal(get(hObject,'waitstatus'),'waiting') 
    uiresume(hObject);
else
    delete(hObject);
end


function varargout = TrainingClassifierPanel_OutputFcn(hObject, eventdata, handles) 
if ishandle(hObject)
    if handles.confirmation==1
        varargout{1} = handles.sup_params;
    else
        varargout{1}=0;
    end
    delete(hObject);
end


function classifier_pop_Callback(hObject, eventdata, handles)
classifier=get(hObject,'value');
switch classifier
    case 1
        t=0;
    case 2
        msgbox('Not available yet!');
        return;
    case 3
        msgbox('Not available yet!');
        return;
end

function classifier_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mod_edit_Callback(hObject, eventdata, handles)


function mod_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function drift_edit_Callback(hObject, eventdata, handles)


function drift_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function K_edit_Callback(hObject, eventdata, handles)


function K_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sigma_edit_Callback(hObject, eventdata, handles)


function sigma_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_edit_Callback(hObject, eventdata, handles)
% hObject    handle to C_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_edit as text
%        str2double(get(hObject,'String')) returns contents of C_edit as a double


% --- Executes during object creation, after setting all properties.
function C_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
