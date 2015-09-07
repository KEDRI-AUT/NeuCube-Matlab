function varargout = EncodingPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EncodingPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @EncodingPanel_OutputFcn, ...
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

%------------------------------------------------------------------------------------------------------------%
function EncodingPanel_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

set(hObject,'windowstyle','modal');
handles.confirmation=0;
encoding_params=varargin{1};
is_recall=varargin{2};
total_sample_number=varargin{3};
Samples={};
for k=1:total_sample_number
    Samples{k}=sprintf('Sample %d', k);
end
set(handles.sample_pop,'string', Samples);
Features=varargin{4};
set(handles.feature_pop,'string', Features);
if isstruct(encoding_params)
    switch encoding_params.method
        case 1
            set(handles.spike_threshold_edit,'string',encoding_params.spike_threshold );
            set(handles.window_size_edit,'enable','off');
            set(handles.filter_type_pop,'enable','off');
        case 2 % BAS
            set(handles.spike_threshold_edit,'string',encoding_params.spike_threshold );
            set(handles.filter_type_pop,'value', encoding_params.filter_type);
            set(handles.filter_type_pop,'enable','on');
            set(handles.window_size_edit,'enable','off');
        case 3 % Moving window
            set(handles.spike_threshold_edit,'string',encoding_params.spike_threshold );
            set(handles.window_size_edit,'string', encoding_params.window_size);
            set(handles.filter_type_pop,'enable','off');
            set(handles.window_size_edit,'enable','on');
        case 4
            set(handles.spike_threshold_edit,'string',encoding_params.spike_threshold );
            set(handles.window_size_edit,'enable','off');
            set(handles.filter_type_pop,'enable','off');
    end
    set(handles.encoding_method_pop,'value', encoding_params.method);
    set(handles.spike_threshold_edit,'string',encoding_params.spike_threshold);
    set(handles.validation_time_length_edit,'string',encoding_params.validation_time_length);
    
    if is_recall
        set(handles.training_set_ratio_edit,'string',0);
        set(handles.training_set_ratio_edit,'enable','off');
        set(handles.training_time_length_edit,'string',1);
        set(handles.training_time_length_edit,'enable','off');
    else
        set(handles.training_set_ratio_edit,'string',encoding_params.training_set_ratio);
         set(handles.training_set_ratio_edit,'enable','on');
         set(handles.training_time_length_edit,'string',encoding_params.training_time_length);
         set(handles.training_time_length_edit,'enable','on');
    end
end

handles.encoding_params=encoding_params;
guidata(hObject, handles);
uiwait(hObject);

function spike_encoding_ok_btn_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close

function spike_encoding_cancel_btn_Callback(hObject, eventdata, handles)
handles.confirmation=0;
guidata(hObject,handles);
close

function figure1_CloseRequestFcn(hObject, eventdata, handles)
if handles.confirmation==1
    method=get(handles.encoding_method_pop,'value');
    
    encoding_params=[];
    encoding_params.method=method;
    switch method
        case 1
            spike_threshold=str2double(get(handles.spike_threshold_edit,'string'));
        case 2 % BAS
            spike_threshold=str2double(get(handles.spike_threshold_edit,'string'));
            filter_type=get(handles.filter_type_pop,'value');
            encoding_params.filter_type=filter_type;
        case 3 % Moving window
            spike_threshold=str2double(get(handles.spike_threshold_edit,'string'));
            window_size=str2double(get(handles.window_size_edit,'string'));
            if window_size<=0
                msgbox('Window Size must be larger than 0!');
                return;
            end
            encoding_params.window_size=window_size;
        case 4
            spike_threshold=str2double(get(handles.spike_threshold_edit,'string'));
    end
    encoding_params.spike_threshold=spike_threshold;
    ratio=str2double(get(handles.training_set_ratio_edit,'string'));
    if ratio<0 || ratio>1
        msgbox('Training Set Ratio must be in [0, 1]');
        return;
    end
    ttl=str2double(get(handles.training_time_length_edit,'string'));
    if ttl<=0 || ttl>1
        msgbox('Training Time Length must be in (0, 1]');
        return;
    end
    vtl=str2double(get(handles.validation_time_length_edit,'string'));
    if vtl<=0 || vtl>1
        msgbox('Validation Time Length must be in (0, 1]');
        return;
    end

    encoding_params.training_set_ratio=ratio;
    encoding_params.training_time_length=ttl;
    encoding_params.validation_time_length=vtl;

    handles.encoding_params=encoding_params;
    handles.sample_id=get(handles.sample_pop,'value');
    handles.feature_id=get(handles.feature_pop,'value');
    guidata(hObject, handles);
end
if isequal(get(hObject,'waitstatus'),'waiting') 
    uiresume(hObject);
else
    delete(hObject);
end

function varargout = EncodingPanel_OutputFcn(hObject, eventdata, handles)
if ishandle(hObject)
    if handles.confirmation==1
        varargout{1} = handles.encoding_params;
        varargout{2}=handles.sample_id;
        varargout{3}=handles.feature_id;
    else
        varargout{1}=0;
        varargout{2}=0;
        varargout{3}=0;
    end
    delete(hObject);
end
%------------------------------------------------------------------------------------------------------------%



function encoding_method_pop_Callback(hObject, eventdata, handles)
method=get(hObject,'value');
switch method
    case 1
        set(handles.window_size_edit,'enable','off');
        set(handles.filter_type_pop,'enable','off');
    case 2 % BAS
        set(handles.filter_type_pop,'enable','on');
        set(handles.window_size_edit,'enable','off');
    case 3 % Moving window
        set(handles.filter_type_pop,'enable','off');
        set(handles.window_size_edit,'enable','on');
    case 4
        set(handles.window_size_edit,'enable','off');
        set(handles.filter_type_pop,'enable','off');
end

function encoding_method_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function spike_threshold_edit_Callback(hObject, eventdata, handles)


function spike_threshold_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function window_size_edit_Callback(hObject, eventdata, handles)


function window_size_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filter_type_pop_Callback(hObject, eventdata, handles)


function filter_type_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function training_set_ratio_edit_Callback(hObject, eventdata, handles)

function training_set_ratio_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function training_time_length_edit_Callback(hObject, eventdata, handles)


function training_time_length_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function validation_time_length_edit_Callback(hObject, eventdata, handles)


function validation_time_length_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function feature_pop_Callback(hObject, eventdata, handles)


function feature_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sample_pop_Callback(hObject, eventdata, handles)


function sample_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
