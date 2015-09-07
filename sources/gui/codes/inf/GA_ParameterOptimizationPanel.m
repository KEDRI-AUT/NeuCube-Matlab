function varargout = GA_ParameterOptimizationPanel(varargin)
% GA_PARAMETEROPTIMIZATIONPANEL MATLAB code for GA_ParameterOptimizationPanel.fig
%      GA_PARAMETEROPTIMIZATIONPANEL, by itself, creates a new GA_PARAMETEROPTIMIZATIONPANEL or raises the existing
%      singleton*.
%
%      H = GA_PARAMETEROPTIMIZATIONPANEL returns the handle to a new GA_PARAMETEROPTIMIZATIONPANEL or the handle to
%      the existing singleton*.
%
%      GA_PARAMETEROPTIMIZATIONPANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GA_PARAMETEROPTIMIZATIONPANEL.M with the given input arguments.
%
%      GA_PARAMETEROPTIMIZATIONPANEL('Property','Value',...) creates a new GA_PARAMETEROPTIMIZATIONPANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GA_ParameterOptimizationPanel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GA_ParameterOptimizationPanel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GA_ParameterOptimizationPanel

% Last Modified by GUIDE v2.5 09-Mar-2015 11:32:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GA_ParameterOptimizationPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @GA_ParameterOptimizationPanel_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before GA_ParameterOptimizationPanel is made visible.
function GA_ParameterOptimizationPanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GA_ParameterOptimizationPanel (see VARARGIN)



% Choose default command line output for GA_ParameterOptimizationPanel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GA_ParameterOptimizationPanel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GA_ParameterOptimizationPanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in START_btn.
function START_btn_Callback(hObject, eventdata, handles)
% hObject    handle to START_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
genetic_algorithm(handles);


% --- Executes on button press in CANCEL_btn.
function CANCEL_btn_Callback(hObject, eventdata, handles)
% hObject    handle to CANCEL_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function CROSS_VAL_txt_Callback(hObject, eventdata, handles)
% hObject    handle to CROSS_VAL_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CROSS_VAL_txt as text
%        str2double(get(hObject,'String')) returns contents of CROSS_VAL_txt as a double


% --- Executes during object creation, after setting all properties.
function CROSS_VAL_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CROSS_VAL_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AER_chkbx.
function AER_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to AER_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AER_chkbx
if(get(hObject,'Value'))
    set(handles.AER_min_txt,'Enable','on');
    set(handles.AER_max_txt,'Enable','on');
else
    set(handles.AER_min_txt,'Enable','off');
    set(handles.AER_max_txt,'Enable','off');
end



function AER_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to AER_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AER_min_txt as text
%        str2double(get(hObject,'String')) returns contents of AER_min_txt as a double


% --- Executes during object creation, after setting all properties.
function AER_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AER_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function AER_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to AER_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AER_max_txt as text
%        str2double(get(hObject,'String')) returns contents of AER_max_txt as a double


% --- Executes during object creation, after setting all properties.
function AER_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AER_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SWC_chkbx.
function SWC_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to SWC_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SWC_chkbx
if(get(hObject,'Value'))
    set(handles.SWC_min_txt,'Enable','on');
    set(handles.SWC_max_txt,'Enable','on');
else
    set(handles.SWC_min_txt,'Enable','off');
    set(handles.SWC_max_txt,'Enable','off');
end



function SWC_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to SWC_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SWC_min_txt as text
%        str2double(get(hObject,'String')) returns contents of SWC_min_txt as a double


% --- Executes during object creation, after setting all properties.
function SWC_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SWC_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SWC_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to SWC_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SWC_max_txt as text
%        str2double(get(hObject,'String')) returns contents of SWC_max_txt as a double


% --- Executes during object creation, after setting all properties.
function SWC_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SWC_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in STDP_chkbx.
function STDP_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to STDP_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of STDP_chkbx
if(get(hObject,'Value'))
    set(handles.STDP_min_txt,'Enable','on');
    set(handles.STDP_max_txt,'Enable','on');
else
    set(handles.STDP_min_txt,'Enable','off');
    set(handles.STDP_max_txt,'Enable','off');
end


function STDP_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to STDP_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of STDP_min_txt as text
%        str2double(get(hObject,'String')) returns contents of STDP_min_txt as a double


% --- Executes during object creation, after setting all properties.
function STDP_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to STDP_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function STDP_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to STDP_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of STDP_max_txt as text
%        str2double(get(hObject,'String')) returns contents of STDP_max_txt as a double


% --- Executes during object creation, after setting all properties.
function STDP_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to STDP_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in THRESHOLD_chkbx.
function THRESHOLD_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to THRESHOLD_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of THRESHOLD_chkbx
if(get(hObject,'Value'))
    set(handles.THRESHOLD_min_txt,'Enable','on');
    set(handles.THRESHOLD_max_txt,'Enable','on');

else
    set(handles.THRESHOLD_min_txt,'Enable','off');
    set(handles.THRESHOLD_max_txt,'Enable','off');
    
end


function THRESHOLD_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to THRESHOLD_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of THRESHOLD_min_txt as text
%        str2double(get(hObject,'String')) returns contents of THRESHOLD_min_txt as a double


% --- Executes during object creation, after setting all properties.
function THRESHOLD_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to THRESHOLD_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function THRESHOLD_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to THRESHOLD_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of THRESHOLD_max_txt as text
%        str2double(get(hObject,'String')) returns contents of THRESHOLD_max_txt as a double


% --- Executes during object creation, after setting all properties.
function THRESHOLD_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to THRESHOLD_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in REFACTORY_chkbx.
function REFACTORY_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to REFACTORY_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REFACTORY_chkbx
if(get(hObject,'Value'))
    set(handles.REFACTORY_min_txt,'Enable','on');
    set(handles.REFACTORY_max_txt,'Enable','on');
    set(handles.selection_function_popup,'Enable','off');
    set(handles.crossover_function_popup,'Enable','off');
    
else
    if(~get(handles.TRAIN_TIME_chkbx,'Value'))
        set(handles.selection_function_popup,'Enable','on');
        set(handles.crossover_function_popup,'Enable','on');
    end
    set(handles.REFACTORY_min_txt,'Enable','off');
    set(handles.REFACTORY_max_txt,'Enable','off');
    
end


function REFACTORY_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to REFACTORY_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of REFACTORY_min_txt as text
%        str2double(get(hObject,'String')) returns contents of REFACTORY_min_txt as a double


% --- Executes during object creation, after setting all properties.
function REFACTORY_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to REFACTORY_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function REFACTORY_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to REFACTORY_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of REFACTORY_max_txt as text
%        str2double(get(hObject,'String')) returns contents of REFACTORY_max_txt as a double


% --- Executes during object creation, after setting all properties.
function REFACTORY_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to REFACTORY_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TRAIN_TIME_chkbx.
function TRAIN_TIME_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to TRAIN_TIME_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TRAIN_TIME_chkbx
if(get(hObject,'Value'))
    set(handles.TRAIN_TIME_min_txt,'Enable','on');
    set(handles.TRAIN_TIME_max_txt,'Enable','on');
    set(handles.selection_function_popup,'Enable','off');
    set(handles.crossover_function_popup,'Enable','off');
else
    if(~get(handles.REFACTORY_chkbx,'Value'))
        set(handles.selection_function_popup,'Enable','on');
        set(handles.crossover_function_popup,'Enable','on');
    end
    set(handles.TRAIN_TIME_min_txt,'Enable','off');
    set(handles.TRAIN_TIME_max_txt,'Enable','off');
    
end


function TRAIN_TIME_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to TRAIN_TIME_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TRAIN_TIME_min_txt as text
%        str2double(get(hObject,'String')) returns contents of TRAIN_TIME_min_txt as a double


% --- Executes during object creation, after setting all properties.
function TRAIN_TIME_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TRAIN_TIME_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function TRAIN_TIME_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to TRAIN_TIME_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TRAIN_TIME_max_txt as text
%        str2double(get(hObject,'String')) returns contents of TRAIN_TIME_max_txt as a double


% --- Executes during object creation, after setting all properties.
function TRAIN_TIME_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TRAIN_TIME_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MOD_chkbx.
function MOD_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to MOD_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MOD_chkbx
if(get(hObject,'Value'))
    set(handles.MOD_min_txt,'Enable','on');
    set(handles.MOD_max_txt,'Enable','on');
else
    set(handles.MOD_min_txt,'Enable','off');
    set(handles.MOD_max_txt,'Enable','off');
end


function MOD_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to MOD_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MOD_min_txt as text
%        str2double(get(hObject,'String')) returns contents of MOD_min_txt as a double


% --- Executes during object creation, after setting all properties.
function MOD_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOD_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function MOD_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to MOD_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MOD_max_txt as text
%        str2double(get(hObject,'String')) returns contents of MOD_max_txt as a double


% --- Executes during object creation, after setting all properties.
function MOD_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOD_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DRIFT_chkbx.
function DRIFT_chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to DRIFT_chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DRIFT_chkbx
if(get(hObject,'Value'))
    set(handles.DRIFT_min_txt,'Enable','on');
    set(handles.DRIFT_max_txt,'Enable','on');
else
    set(handles.DRIFT_min_txt,'Enable','off');
    set(handles.DRIFT_max_txt,'Enable','off');
end


function DRIFT_min_txt_Callback(hObject, eventdata, handles)
% hObject    handle to DRIFT_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DRIFT_min_txt as text
%        str2double(get(hObject,'String')) returns contents of DRIFT_min_txt as a double


% --- Executes during object creation, after setting all properties.
function DRIFT_min_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DRIFT_min_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DRIFT_max_txt_Callback(hObject, eventdata, handles)
% hObject    handle to DRIFT_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DRIFT_max_txt as text
%        str2double(get(hObject,'String')) returns contents of DRIFT_max_txt as a double


% --- Executes during object creation, after setting all properties.
function DRIFT_max_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DRIFT_max_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function population_size_txt_Callback(hObject, eventdata, handles)
% hObject    handle to population_size_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of population_size_txt as text
%        str2double(get(hObject,'String')) returns contents of population_size_txt as a double


% --- Executes during object creation, after setting all properties.
function population_size_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to population_size_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selection_function_popup.
function selection_function_popup_Callback(hObject, eventdata, handles)
% hObject    handle to selection_function_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selection_function_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selection_function_popup



% --- Executes during object creation, after setting all properties.
function selection_function_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selection_function_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function elite_count_txt_Callback(hObject, eventdata, handles)
% hObject    handle to elite_count_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elite_count_txt as text
%        str2double(get(hObject,'String')) returns contents of elite_count_txt as a double


% --- Executes during object creation, after setting all properties.
function elite_count_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elite_count_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crossover_fraction_txt_Callback(hObject, eventdata, handles)
% hObject    handle to crossover_fraction_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crossover_fraction_txt as text
%        str2double(get(hObject,'String')) returns contents of crossover_fraction_txt as a double


% --- Executes during object creation, after setting all properties.
function crossover_fraction_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crossover_fraction_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in crossover_function_popup.
function crossover_function_popup_Callback(hObject, eventdata, handles)
% hObject    handle to crossover_function_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns crossover_function_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crossover_function_popup


% --- Executes during object creation, after setting all properties.
function crossover_function_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crossover_function_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function generation_txt_Callback(hObject, eventdata, handles)
% hObject    handle to generation_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of generation_txt as text
%        str2double(get(hObject,'String')) returns contents of generation_txt as a double


% --- Executes during object creation, after setting all properties.
function generation_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to generation_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function genetic_algorithm(handles)

NUMBER_VARIABLES=8;
VARIABLES_UPPER_BOUND=zeros(NUMBER_VARIABLES,1);
VARIABLES_LOWER_BOUND=zeros(NUMBER_VARIABLES,1);
%%%%%%%  change 0 to default values. %%%%%%%%%%%%%%

if(get(handles.AER_chkbx,'Value'))
    AER_min=str2double(get(handles.AER_min_txt,'String'));
    AER_max=str2double(get(handles.AER_max_txt,'String'));
    VARIABLES_LOWER_BOUND(1,1)=AER_min;
    VARIABLES_UPPER_BOUND(1,1)=AER_max;
end
if(get(handles.SWC_chkbx,'Value'))
    SWC_min=str2double(get(handles.SWC_min_txt,'String'));
    SWC_max=str2double(get(handles.SWC_max_txt,'String'));
    VARIABLES_LOWER_BOUND(2,1)=SWC_min;
    VARIABLES_UPPER_BOUND(2,1)=SWC_max;
end
if(get(handles.STDP_chkbx,'Value'))
    STDP_min=str2double(get(handles.STDP_min_txt,'String'));
    STDP_max=str2double(get(handles.STDP_max_txt,'String'));
    VARIABLES_LOWER_BOUND(3,1)=STDP_min;
    VARIABLES_UPPER_BOUND(3,1)=STDP_max;
end
if(get(handles.THRESHOLD_chkbx,'Value'))
    THRESHOLD_min=str2double(get(handles.THRESHOLD_min_txt,'String'));
    THRESHOLD_max=str2double(get(handles.THRESHOLD_max_txt,'String'));
    VARIABLES_LOWER_BOUND(4,1)=THRESHOLD_min;
    VARIABLES_UPPER_BOUND(4,1)=THRESHOLD_max;
end
if(get(handles.REFACTORY_chkbx,'Value'))
    REFACTORY_min=str2double(get(handles.REFACTORY_min_txt,'String'));
    REFACTORY_max=str2double(get(handles.REFACTORY_max_txt,'String'));
    VARIABLES_LOWER_BOUND(5,1)=REFACTORY_min;
    VARIABLES_UPPER_BOUND(5,1)=REFACTORY_max;
end
if(get(handles.TRAIN_TIME_chkbx,'Value'))
    TRAIN_TIME_min=str2double(get(handles.TRAIN_TIME_min_txt,'String'));
    TRAIN_TIME_max=str2double(get(handles.TRAIN_TIME_max_txt,'String'));
    VARIABLES_LOWER_BOUND(6,1)=TRAIN_TIME_min;
    VARIABLES_UPPER_BOUND(6,1)=TRAIN_TIME_max;
end
if(get(handles.MOD_chkbx,'Value'))
    MOD_min=str2double(get(handles.MOD_min_txt,'String'));
    MOD_max=str2double(get(handles.MOD_max_txt,'String'));
    VARIABLES_LOWER_BOUND(7,1)=MOD_min;
    VARIABLES_UPPER_BOUND(7,1)=MOD_max;
end
if(get(handles.DRIFT_chkbx,'Value'))
    DRIFT_min=str2double(get(handles.DRIFT_min_txt,'String'));
    DRIFT_max=str2double(get(handles.DRIFT_max_txt,'String'));
    VARIABLES_LOWER_BOUND(8,1)=DRIFT_min;
    VARIABLES_UPPER_BOUND(8,1)=DRIFT_max;
end

%GA parameter set%
intcon=[];
population_size=str2double(get(handles.population_size_txt,'String'));
generations=str2double(get(handles.generation_txt,'String'));
crossover_fraction=str2double(get(handles.crossover_fraction_txt,'String'));
elite_count=str2double(get(handles.elite_count_txt,'String'));

opts = gaoptimset('PopulationSize',population_size,'Generations',generations,'CrossoverFraction',crossover_fraction,'EliteCount',elite_count);
if(strcmp( get(handles.selection_function_popup,'Enable'),'on')&&strcmp( get(handles.crossover_function_popup,'Enable'),'on'))
    selection_function=get(handles.selection_function_popup,'Value');
    if(selection_function==1)
        opts.SelectionFcn=@selectionstochunif;
    elseif(selection_function==2)
        opts.SelectionFcn=@selectionremainder;
    elseif(selection_function==3) 
        opts.SelectionFcn=@selectionuniform;
    elseif(selection_function==4)
        opts.SelectionFcn=@selectionroulette;
    elseif(selection_function==5)
        opts.SelectionFcn=@selectiontournament;
    end

    crossover_function=get(handles.crossover_function_popup,'Value');
    if(crossover_function==1)
        opts.CrossoverFcn=@crossoverscattered;
    elseif(crossover_function==2)
        opts.CrossoverFcn=@crossoversinglepoint;
    elseif(crossover_function==3) 
        opts.CrossoverFcn=@crossovertwopoint;
    elseif(crossover_function==4)
        opts.CrossoverFcn=@crossoverarithmetic;
    end    
else
    intcon=[5,6]; % this for integer params. means the 5th and 6th are integer.
end

opts.PlotFcns=@gaplotbestf;
opts

%opts = gaoptimset('PlotFcns',@gaplotbestf,'CrossoverFcn',@crossoverscattered);

[best_param,fval,exitflag] = ga(@rastriginsfcn,NUMBER_VARIABLES,[],[],[],[],VARIABLES_LOWER_BOUND,VARIABLES_UPPER_BOUND,[],intcon,opts);
%[best_param]=ga(@rastriginsfcn,8,[],[],[],VARIABLES_LOWER_BOUND,VARIABLES_UPPER_BOUND,[],[],opts);
best_param


    
