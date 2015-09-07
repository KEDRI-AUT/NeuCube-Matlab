function varargout = ParameterOptimizationPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ParameterOptimizationPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @ParameterOptimizationPanel_OutputFcn, ...
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


% --- Executes just before ParameterOptimizationPanel is made visible.
function ParameterOptimizationPanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ParameterOptimizationPanel (see VARARGIN)

% Choose default command line output for ParameterOptimizationPanel
handles.output = hObject;
handles.confirmation=0;
% Update handles structure
param_grid=varargin{1};

initparam(handles, param_grid);
set(handles.crossover_function_pop,'enable','off');
set(handles.selection_function_pop,'enable','off');
set(handles.population_size_edit,'enable','off');
set(handles.crossover_fraction_edit,'enable','off');
set(handles.generation_number_edit,'enable','off');
set(handles.elite_count_edit,'enable','off');
% msgbox('Opt dialog');
guidata(hObject, handles);
uiwait(hObject);

% UIWAIT makes ParameterOptimizationPanel wait for user response (see UIRESUME)
% uiwait(handles.ParameterOptimizationPanel);

function ParameterOptimizationPanel_CloseRequestFcn(hObject, eventdata, handles)
uiresume(hObject);
% Hint: delete(hObject) closes the figure



% --- Outputs from this function are returned to the command line.
function varargout = ParameterOptimizationPanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1}=0;
varargout{2}=0;
varargout{3}=0;
varargout{4}=0;
varargout{5}=0;
varargout{6}=0;
if handles.confirmation==1
    varargout{1}=1;
    param_grid=getparam(handles);
    varargout{2} = param_grid;
    checkstate=getcheck(handles);
    varargout{3}=checkstate;
    varargout{4}=str2double(get(handles.po_cv_number_edit,'string'));
    varargout{5}=get(handles.optimization_tool_pop,'value');
    if varargout{5}==2
        population_size=str2double(get(handles.population_size_edit,'String'));
         generation_number=str2double(get(handles.generation_number_edit,'String'));
         crossover_fraction=str2double(get(handles.crossover_fraction_edit,'String'));
         elite_count=str2double(get(handles.elite_count_edit,'String'));

         toolparam = gaoptimset('PopulationSize',population_size,'Generations',generation_number,'CrossoverFraction',crossover_fraction,'EliteCount',elite_count);
         
         crossover_function=get(handles.crossover_function_pop,'Value');
         if(crossover_function==1)
             toolparam.CrossoverFcn=@crossoverscattered;
         elseif(crossover_function==2)
             toolparam.CrossoverFcn=@crossoversinglepoint;
         elseif(crossover_function==3)
             toolparam.CrossoverFcn=@crossovertwopoint;
         elseif(crossover_function==4)
             toolparam.CrossoverFcn=@crossoverarithmetic;
         end
    
         selection_function=get(handles.selection_function_pop,'Value');
         if(selection_function==1)
             toolparam.SelectionFcn=@selectionstochunif;
         elseif(selection_function==2)
             toolparam.SelectionFcn=@selectionremainder;
         elseif(selection_function==3)
             toolparam.SelectionFcn=@selectionuniform;
         elseif(selection_function==4)
             toolparam.SelectionFcn=@selectionroulette;
         elseif(selection_function==5)
             toolparam.SelectionFcn=@selectiontournament;
         end
         toolparam.PlotFcns=@gaplotbestf;
        varargout{6}=toolparam;
    end
else
    varargout{1}=0;
end
delete(hObject);

function aer_threshold_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.aer_threshold_minimum_edit,'enable','on');
    set(handles.aer_threshold_step_edit,'enable','on');
    set(handles.aer_threshold_maximum_edit,'enable','on');
else
    set(handles.aer_threshold_minimum_edit,'enable','off');
    set(handles.aer_threshold_step_edit,'enable','off');
    set(handles.aer_threshold_maximum_edit,'enable','off');
end

function aer_threshold_minimum_edit_Callback(hObject, eventdata, handles)


function aer_threshold_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function aer_threshold_step_edit_Callback(hObject, eventdata, handles)


function aer_threshold_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function aer_threshold_maximum_edit_Callback(hObject, eventdata, handles)


function aer_threshold_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function connection_distance_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.connection_distance_minimum_edit,'enable','on');
    set(handles.connection_distance_step_edit,'enable','on');
    set(handles.connection_distance_maximum_edit,'enable','on');
else
    set(handles.connection_distance_minimum_edit,'enable','off');
    set(handles.connection_distance_step_edit,'enable','off');
    set(handles.connection_distance_maximum_edit,'enable','off');
end

function connection_distance_minimum_edit_Callback(hObject, eventdata, handles)


function connection_distance_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function connection_distance_step_edit_Callback(hObject, eventdata, handles)


function connection_distance_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function connection_distance_maximum_edit_Callback(hObject, eventdata, handles)


function connection_distance_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function stdp_rate_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.stdp_rate_minimum_edit,'enable','on');
    set(handles.stdp_rate_step_edit,'enable','on');
    set(handles.stdp_rate_maximum_edit,'enable','on');
else
    set(handles.stdp_rate_minimum_edit,'enable','off');
    set(handles.stdp_rate_step_edit,'enable','off');
    set(handles.stdp_rate_maximum_edit,'enable','off');
end

function stdp_rate_minimum_edit_Callback(hObject, eventdata, handles)


function stdp_rate_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function stdp_rate_step_edit_Callback(hObject, eventdata, handles)


function stdp_rate_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function stdp_rate_maximum_edit_Callback(hObject, eventdata, handles)


function stdp_rate_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threshold_of_firing_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.threshold_of_firing_minimum_edit,'enable','on');
    set(handles.threshold_of_firing_step_edit,'enable','on');
    set(handles.threshold_of_firing_maximum_edit,'enable','on');
else
    set(handles.threshold_of_firing_minimum_edit,'enable','off');
    set(handles.threshold_of_firing_step_edit,'enable','off');
    set(handles.threshold_of_firing_maximum_edit,'enable','off');
end

function threshold_of_firing_minimum_edit_Callback(hObject, eventdata, handles)


function threshold_of_firing_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threshold_of_firing_step_edit_Callback(hObject, eventdata, handles)


function threshold_of_firing_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threshold_of_firing_maximum_edit_Callback(hObject, eventdata, handles)


function threshold_of_firing_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refactory_time_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.refactory_time_minimum_edit,'enable','on');
    set(handles.refactory_time_step_edit,'enable','on');
    set(handles.refactory_time_maximum_edit,'enable','on');
else
    set(handles.refactory_time_minimum_edit,'enable','off');
    set(handles.refactory_time_step_edit,'enable','off');
    set(handles.refactory_time_maximum_edit,'enable','off');
end

function refactory_time_minimum_edit_Callback(hObject, eventdata, handles)


function refactory_time_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refactory_time_step_edit_Callback(hObject, eventdata, handles)


function refactory_time_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refactory_time_maximum_edit_Callback(hObject, eventdata, handles)


function refactory_time_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_time_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.training_time_minimum_edit,'enable','on');
    set(handles.training_time_step_edit,'enable','on');
    set(handles.training_time_maximum_edit,'enable','on');
else
    set(handles.training_time_minimum_edit,'enable','off');
    set(handles.training_time_step_edit,'enable','off');
    set(handles.training_time_maximum_edit,'enable','off');
end

function training_time_minimum_edit_Callback(hObject, eventdata, handles)


function training_time_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_time_step_edit_Callback(hObject, eventdata, handles)


function training_time_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_time_maximum_edit_Callback(hObject, eventdata, handles)


function training_time_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mod_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.mod_minimum_edit,'enable','on');
    set(handles.mod_step_edit,'enable','on');
    set(handles.mod_maximum_edit,'enable','on');
else
    set(handles.mod_minimum_edit,'enable','off');
    set(handles.mod_step_edit,'enable','off');
    set(handles.mod_maximum_edit,'enable','off');
end

function mod_minimum_edit_Callback(hObject, eventdata, handles)


function mod_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mod_step_edit_Callback(hObject, eventdata, handles)


function mod_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mod_maximum_edit_Callback(hObject, eventdata, handles)


function mod_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function drift_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.drift_minimum_edit,'enable','on');
    set(handles.drift_step_edit,'enable','on');
    set(handles.drift_maximum_edit,'enable','on');
else
    set(handles.drift_minimum_edit,'enable','off');
    set(handles.drift_step_edit,'enable','off');
    set(handles.drift_maximum_edit,'enable','off');
end

function drift_minimum_edit_Callback(hObject, eventdata, handles)


function drift_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function drift_step_edit_Callback(hObject, eventdata, handles)


function drift_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function drift_maximum_edit_Callback(hObject, eventdata, handles)


function drift_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close;

function pushbutton2_Callback(hObject, eventdata, handles)
close


function po_cv_number_edit_Callback(hObject, eventdata, handles)


function po_cv_number_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function population_size_edit_Callback(hObject, eventdata, handles)


function population_size_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function generation_number_edit_Callback(hObject, eventdata, handles)


function generation_number_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function crossover_fraction_edit_Callback(hObject, eventdata, handles)


function crossover_fraction_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function crossover_function_pop_Callback(hObject, eventdata, handles)


function crossover_function_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function selection_function_pop_Callback(hObject, eventdata, handles)


function selection_function_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function elite_count_edit_Callback(hObject, eventdata, handles)


function elite_count_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function optimization_tool_pop_Callback(hObject, eventdata, handles)
setbtn(hObject,handles)

function optimization_tool_pop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function k_minimum_edit_Callback(hObject, eventdata, handles)


function k_minimum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function k_step_edit_Callback(hObject, eventdata, handles)


function k_step_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function k_maximum_edit_Callback(hObject, eventdata, handles)


function k_maximum_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function k_checkbox_Callback(hObject, eventdata, handles)
if get(hObject, 'value')==1
    set(handles.k_minimum_edit,'enable','on');
    set(handles.k_step_edit,'enable','on');
    set(handles.k_maximum_edit,'enable','on');
else
    set(handles.k_minimum_edit,'enable','off');
    set(handles.k_step_edit,'enable','off');
    set(handles.k_maximum_edit,'enable','off');
end
