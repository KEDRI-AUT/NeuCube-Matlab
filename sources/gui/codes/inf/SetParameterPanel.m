function varargout = SetParameterPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SetParameterPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @SetParameterPanel_OutputFcn, ...
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

function SetParameterPanel_OpeningFcn(hObject, eventdata, handles, varargin)

% set(hObject,'windowstyle','modal');
handles.confirmation=0;

gui_params=varargin{1};
feature_number=varargin{2};
Names=varargin{3};
if isempty(gui_params) || ~isstruct(gui_params)
    return;
end

encoding_params=gui_params.encoding;
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

end


init_params=gui_params.init;
if isstruct(init_params)
    set(handles.neuron_number_x_edit,'string', init_params.neuron_number_x);
    set(handles.neuron_number_y_edit, 'string', init_params.neuron_number_y);
    set(handles.neuron_number_z_edit, 'string', init_params.neuron_number_z);
    set(handles.small_world_radius_edit,'string', init_params.small_world_radius);
    set(handles.input_mapping_pop, 'value', init_params.input_mapping);
    
    set(handles.mapping_coordinate_table,'ColumnName',{'X coordinate', 'Y coordinate', 'Zcoordinate'});
    set(handles.mapping_coordinate_table,'RowName',Names);
    if ~isempty(init_params.mapping_coordinate) && size(init_params.mapping_coordinate,1)==feature_number
        set(handles.mapping_coordinate_table,'data',init_params.mapping_coordinate);
    else
        set(handles.mapping_coordinate_table,'data',zeros(feature_number,3));
    end
    if init_params.input_mapping==3
        set(handles.mapping_coordinate_table,'enable','on');
    else
        set(handles.mapping_coordinate_table,'enable','off');
    end
    if init_params.input_mapping==2
        set(handles.browser_btn,'enable','on');
    else
        set(handles.browser_btn,'enable','off');
    end
    
    method=init_params.neuron_coord_method;
    if method==1
        set(handles.neuron_number_x_edit,'enable','on');
        set(handles.neuron_number_y_edit,'enable','on');
        set(handles.neuron_number_z_edit,'enable','on');
        set(handles.coord_brower_btn,'enable','off');
    else
        set(handles.neuron_number_x_edit,'enable','off');
        set(handles.neuron_number_y_edit,'enable','off');
        set(handles.neuron_number_z_edit,'enable','off');
        set(handles.coord_brower_btn,'enable','on');
    end

end
unsup_params=gui_params.unsup;
if isstruct(unsup_params)
    set(handles.potential_leak_rate_edit,'string', unsup_params.potential_leak_rate);
    set(handles.STDP_rate_edit, 'string', unsup_params.STDP_rate);
    set(handles.threshold_of_firing_edit, 'string', unsup_params.threshold_of_firing);
    set(handles.training_round_edit, 'value', unsup_params.training_round);
    set(handles.refactory_time_edit, 'value', unsup_params.refactory_time);
    set(handles.LDC_probability_edit, 'value', unsup_params.LDC_probability);
end

sup_params=gui_params.sup;
if isstruct(sup_params)
    set(handles.classifier_pop,'value', sup_params.classifier_flag);
    if sup_params.classifier_flag==1
        set(handles.mod_edit, 'string', sup_params.mod);
        set(handles.drift_edit, 'string', sup_params.drift);
        set(handles.K_edit, 'string', sup_params.K);
        set(handles.sigma_edit, 'string', sup_params.sigma);
    end
end
handles.gui_params=gui_params;
handles.feature_number=feature_number;
guidata(hObject, handles);
uiwait(hObject);



function varargout = SetParameterPanel_OutputFcn(hObject, eventdata, handles)
if ishandle(hObject)
    if handles.confirmation==1
        varargout{1} = handles.gui_params;
    else
        varargout{1}=0;
    end
    delete(hObject);
end


function classifier_pop_Callback(hObject, eventdata, handles)


function classifier_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mod_edit_Callback(hObject, eventdata, handles)


function mod_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function drift_edit_Callback(hObject, eventdata, handles)


function drift_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function K_edit_Callback(hObject, eventdata, handles)


function K_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sigma_edit_Callback(hObject, eventdata, handles)


function sigma_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function potential_leak_rate_edit_Callback(hObject, eventdata, handles)


function potential_leak_rate_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function STDP_rate_edit_Callback(hObject, eventdata, handles)


function STDP_rate_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threshold_of_firing_edit_Callback(hObject, eventdata, handles)


function threshold_of_firing_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_round_edit_Callback(hObject, eventdata, handles)


function training_round_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refactory_time_edit_Callback(hObject, eventdata, handles)


function refactory_time_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function LDC_probability_edit_Callback(hObject, eventdata, handles)


function LDC_probability_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function input_mapping_pop_Callback(hObject, eventdata, handles)
init_params=handles.gui_params.init;
feature_number=handles.feature_number;
mapping=get(hObject,'value');
switch mapping
    case 1 % auto
        init_params.input_mapping=1;
        set(handles.mapping_coordinate_table,'enable','off');
        set(handles.browser_btn,'enable','off');
    case 2 % file
        init_params.input_mapping=2;
        set(handles.mapping_coordinate_table,'enable','off');
        set(handles.browser_btn,'enable','on');
    case 3 % manual
        init_params.input_mapping=3;
        set(handles.mapping_coordinate_table,'enable','on');
        set(handles.browser_btn,'enable','off');
        if ~isempty(init_params.mapping_coordinate) && size(init_params.mapping_coordinate,1)==feature_number
            set(handles.mapping_coordinate_table,'data',init_params.mapping_coordinate);
        else
            set(handles.mapping_coordinate_table,'data',zeros(feature_number,3));
        end
end


function input_mapping_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function browser_btn_Callback(hObject, eventdata, handles)
feature_number=handles.feature_number;
mapping_coordinate=handles.init_params.mapping_coordinate;


[FileName,PathName] = uigetfile({'*.txt;*.mat','Mapping files'},'Select mappping coordinate file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end

flag=false;
if strcmp(FileName(end-2:end),'mat')
    SS=load(strcat(PathName,FileName));
    if isstruct(SS)
        fnames=fieldnames(SS);
        if length(fnames)>1
            msgbox('The mapping file must only contain a 2D matrix!');
            return ;
        end
        pp=getfield(SS,fnames{1});
    end
    if size(pp,1)~=feature_number || size(pp,2)~=3
        msgbox(sprintf('For this dataset, the coordinate mapping file should contain %d rows and 3 columns only!',feature_number))
        return;
    end
    
    if ~isequal(pp/10,round(pp/10)) || min(pp(:))<=0
        msgbox(sprintf('Coordinates must be positive and integer times 10!'))
        return;
    end
        
    mapping_coordinate=pp;
    flag=true;
else
    msgbox('Unrecognized file format');
    return;
end
if flag==true
    set(handles.mapping_coordinate_table,'data',mapping_coordinate);
    handles.gui_params.init.mapping_coordinate=mapping_coordinate;
    guidata(hObject, handles);
end

function neuron_number_x_edit_Callback(hObject, eventdata, handles)


function neuron_number_x_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function neuron_number_y_edit_Callback(hObject, eventdata, handles)


function neuron_number_y_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function neuron_number_z_edit_Callback(hObject, eventdata, handles)


function neuron_number_z_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu3_Callback(hObject, eventdata, handles)


function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function neuron_coordinate_pop_Callback(hObject, eventdata, handles)
method=get(hObject, 'value');
if method==1
    set(handles.neuron_number_x_edit,'enable','on');
    set(handles.neuron_number_y_edit,'enable','on');
    set(handles.neuron_number_z_edit,'enable','on');
    set(handles.coord_brower_btn,'enable','off');
else
    set(handles.neuron_number_x_edit,'enable','off');
    set(handles.neuron_number_y_edit,'enable','off');
    set(handles.neuron_number_z_edit,'enable','off');
    set(handles.coord_brower_btn,'enable','on');
end

function neuron_coordinate_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function small_world_radius_edit_Callback(hObject, eventdata, handles)


function small_world_radius_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function coord_brower_btn_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile({'*.txt;*.mat','Coordinates files'},'Select neuron coordinate file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end

if strcmp(FileName(end-2:end),'mat')
    SS=load(strcat(PathName,FileName));
    if isstruct(SS)
        fnames=fieldnames(SS);
        if length(fnames)>1
            msgbox('The coordinates file must only contain a 2D matrix!');
            return ;
        end
        pp=getfield(SS,fnames{1});
    end
    if size(pp,2)~=3 
        msgbox(sprintf('The coordinate file should contain 3 columns matrix only!'))
        return;
    end
    if ~isequal(pp/10,round(pp/10)) || min(pp(:))<=0
        msgbox(sprintf('Coordinates must be positive and integer times 10!'))
        return;
    end
    handles.neuron_location=pp;
    guidata(hObject, handles);
else
    msgbox('Unrecognized file format');
    return;
end


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

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function spike_threshold_edit_Callback(hObject, eventdata, handles)


function spike_threshold_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function window_size_edit_Callback(hObject, eventdata, handles)


function window_size_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filter_type_pop_Callback(hObject, eventdata, handles)


function filter_type_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_set_ratio_edit_Callback(hObject, eventdata, handles)


function training_set_ratio_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function training_time_length_edit_Callback(hObject, eventdata, handles)


function training_time_length_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function validation_time_length_edit_Callback(hObject, eventdata, handles)


function validation_time_length_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function set_parameter_panel_ok_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close

function set_parameter_panel_cancel_Callback(hObject, eventdata, handles)
handles.confirmation=0;
guidata(hObject,handles);
close


function figure1_CloseRequestFcn(hObject, eventdata, handles)
gui_params=handles.gui_params;

if handles.confirmation==1
    encoding_params=gui_params.encoding;
    method=get(handles.encoding_method_pop,'value');
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
    gui_params.encoding=encoding_params;
    
    
    init_params=gui_params.init;
    method=get(handles.neuron_coordinate_pop,'value');
    if method==1 %auto neuron coord
        neuron_number_x=str2double(get(handles.neuron_number_x_edit,'string'));
        neuron_number_y=str2double(get(handles.neuron_number_y_edit,'string'));
        neuron_number_z=str2double(get(handles.neuron_number_z_edit,'string'));
        if neuron_number_x<=0 || round(neuron_number_x)~=neuron_number_x ||...
                neuron_number_y<=0 || round(neuron_number_y)~=neuron_number_y ||...
                neuron_number_z<=0 || round(neuron_number_z)~=neuron_number_z
            msgbox('Neuron number must be positive integer!');
            return;
        end 
        init_params.neuron_number_x=neuron_number_x;
        init_params.neuron_number_y=neuron_number_y;
        init_params.neuron_number_z=neuron_number_z;
        init_params.neuron_location=[];
    else
        init_params.neuron_location=handles.neuron_location;
    end
    
    init_params.neuron_coord_method=method;
    small_world_radius=str2double(get(handles.small_world_radius_edit,'string'));
    input_mapping=get(handles.input_mapping_pop,'value');
    mapping_coordinate=get(handles.mapping_coordinate_table,'data');
    if input_mapping==1 % graph matching
        mapping_coordinate=[];
    else
        if ~isequal(mapping_coordinate/10,round(mapping_coordinate/10)) || min(mapping_coordinate(:))<=0
            msgbox(sprintf('Mapping coordinates must be positive and integer times 10!'))
            return;
        end
    end
    init_params.small_world_radius=small_world_radius;
    init_params.input_mapping=input_mapping;
    init_params.mapping_coordinate=mapping_coordinate;
    gui_params.init=init_params;
    
    unsup_params=gui_params.unsup;
    unsup_params.potential_leak_rate=str2double(get(handles.potential_leak_rate_edit,'string'));
    unsup_params.STDP_rate=str2double(get(handles.STDP_rate_edit, 'string'));
    unsup_params.threshold_of_firing=str2double(get(handles.threshold_of_firing_edit,'string'));
    unsup_params.training_round=str2double(get(handles.training_round_edit, 'string'));
    unsup_params.refactory_time=str2double(get(handles.refactory_time_edit, 'string'));
    unsup_params.LDC_probability=str2double(get(handles.LDC_probability_edit,'string'));
    gui_params.unsup=unsup_params;
    
    sup_params=gui_params.sup;
    classifier=get(handles.classifier_pop,'value');
    sup_params.classifier_flag=classifier;
    switch classifier
        case 1
            sup_params.mod=str2double(get(handles.mod_edit, 'string'));
            sup_params.drift=str2double(get(handles.drift_edit, 'string'));
            sup_params.K=str2double(get(handles.K_edit, 'string'));
            sup_params.sigma=str2double(get(handles.sigma_edit, 'string'));
    end
    gui_params.sup=sup_params;
    handles.gui_params=gui_params;
    
    guidata(hObject, handles);
end
if isequal(get(hObject,'waitstatus'),'waiting') 
    uiresume(hObject);
else
    delete(hObject);
end
