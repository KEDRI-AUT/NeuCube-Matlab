function varargout = InitializationPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InitializationPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @InitializationPanel_OutputFcn, ...
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

function InitializationPanel_OpeningFcn(hObject, eventdata, handles, varargin)

init_params=varargin{1};
feature_number=varargin{2};
Names=varargin{3};

set(hObject,'windowstyle','modal');
handles.confirmation=0;

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
    set(handles.input_mapping_pop,'value',init_params.input_mapping);
    
    method=init_params.neuron_coord_method;
    if method==1
        set(handles.neuron_number_x_edit,'enable','on');
        set(handles.neuron_number_y_edit,'enable','on');
        set(handles.neuron_number_z_edit,'enable','on');
        set(handles.coord_brower_btn,'enable','off');
        set(handles.transform_check,'enable','off');
    else
        set(handles.neuron_number_x_edit,'enable','off');
        set(handles.neuron_number_y_edit,'enable','off');
        set(handles.neuron_number_z_edit,'enable','off');
        set(handles.coord_brower_btn,'enable','on');
        set(handles.transform_check,'enable','on');
    end
    set(handles.neuron_coordinate_pop,'value',method);

end

handles.init_params=init_params;
handles.feature_number=feature_number;
handles.neuron_location=init_params.neuron_location;
guidata(hObject, handles);
uiwait(hObject);

function browser_btn_Callback(hObject, eventdata, handles)
feature_number=handles.feature_number;
mapping_coordinate=handles.init_params.mapping_coordinate;


% [FileName,PathName] = uigetfile({'*.txt;*.mat','Mapping files'},'Select mappping coordinate file');
% if isempty(FileName) || isa(FileName,'double')==1
%     msgbox('Cannot open the file!');
%     return;
% end
% 
% if strcmp(FileName(end-2:end),'mat')
%     SS=load(strcat(PathName,FileName));
%     if isstruct(SS)
%         fnames=fieldnames(SS);
%         if length(fnames)>1
%             msgbox('The mapping file must only contain a 2D matrix!');
%             return ;
%         end
%         pp=getfield(SS,fnames{1});
%     end
% elseif strcmp(FileName(end-2:end),'txt')
% else
%     msgbox('Unrecognized file format');
%     return;
% end
pp= import_csv_eeg_mapping( feature_number );
if size(pp,1)~=feature_number || size(pp,2)~=3
    msgbox(sprintf('For this dataset, the coordinate mapping file should contain %d rows and 3 columns only!',feature_number))
    return;
end

% if ~isequal(pp/10,round(pp/10)) || min(pp(:))<=0
%     msgbox(sprintf('Coordinates must be positive and integer times 10!'))
%     return;
% end

mapping_coordinate=pp;
set(handles.mapping_coordinate_table,'data',mapping_coordinate);
handles.init_params.mapping_coordinate=mapping_coordinate;
guidata(hObject, handles);

        

function input_mapping_pop_Callback(hObject, eventdata, handles)
init_params=handles.init_params;
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

function mapping_coordinate_table_CellEditCallback(hObject, eventdata, handles)
init_params=handles.init_params;
mapping_coordinate=get(handles.mapping_coordinate_table,'data');
init_params.mapping_coordinate=mapping_coordinate;
handles.init_params=init_params;
guidata(hObject,handles);

function initialization_panel_ok_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close

function initialization_panel_cancel_Callback(hObject, eventdata, handles)
handles.confirmation=0;
guidata(hObject,handles);
close


function figure1_CloseRequestFcn(hObject, eventdata, handles)

if handles.confirmation==1
    init_params=handles.init_params;
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
%     else
%         if ~isequal(mapping_coordinate/10,round(mapping_coordinate/10)) || min(mapping_coordinate(:))<=0
%             msgbox(sprintf('Mapping coordinates must be positive and integer times 10!'))
%             return;
%         end
    end
    if get(handles.transform_check,'value')==1
        [neuinput,neuron_location]=shift_coord(mapping_coordinate, init_params.neuron_location);
         init_params.neuron_location=neuron_location;
         mapping_coordinate=neuinput;
    end
    init_params.small_world_radius=small_world_radius;
    init_params.input_mapping=input_mapping;
    init_params.mapping_coordinate=mapping_coordinate;
        
    handles.init_params=init_params;
    guidata(hObject, handles);
end
if isequal(get(hObject,'waitstatus'),'waiting') 
    uiresume(hObject);
else
    delete(hObject);
end

function varargout = InitializationPanel_OutputFcn(hObject, eventdata, handles) 

if ishandle(hObject)
    if handles.confirmation==1
        varargout{1} = handles.init_params;
    else
        varargout{1}=0;
    end
    delete(hObject);
end



function neuron_number_x_edit_Callback(hObject, eventdata, handles)


function neuron_number_x_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function small_world_radius_edit_Callback(hObject, eventdata, handles)


function small_world_radius_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu2_Callback(hObject, eventdata, handles)


function popupmenu2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function neuron_number_z_edit_Callback(hObject, eventdata, handles)


function neuron_number_z_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function neuron_number_y_edit_Callback(hObject, eventdata, handles)


function neuron_number_y_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_mapping_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu4_Callback(hObject, eventdata, handles)


function popupmenu4_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
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
    set(handles.transform_check,'enable','off');
else
    set(handles.neuron_number_x_edit,'enable','off');
    set(handles.neuron_number_y_edit,'enable','off');
    set(handles.neuron_number_z_edit,'enable','off');
    set(handles.coord_brower_btn,'enable','on');
    set(handles.transform_check,'enable','on');
end

function neuron_coordinate_pop_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function coord_brower_btn_Callback(hObject, eventdata, handles)
% [FileName,PathName] = uigetfile({'*.txt;*.mat','Coordinates files'},'Select neuron coordinate file');
% if isempty(FileName) || isa(FileName,'double')==1
%     msgbox('Cannot open the file!');
%     return;
% end
% 
% if strcmp(FileName(end-2:end),'mat')
%     SS=load(strcat(PathName,FileName));
%     if isstruct(SS)
%         fnames=fieldnames(SS);
%         if length(fnames)>1
%             msgbox('The coordinates file must only contain a 2D matrix!');
%             return ;
%         end
%         pp=getfield(SS,fnames{1});
%     end
%     if size(pp,2)~=3 
%         msgbox(sprintf('The coordinate file should contain 3 columns matrix only!'))
%         return;
%     end
%     if ~isequal(pp/10,round(pp/10)) || min(pp(:))<=0
%         msgbox(sprintf('Coordinates must be positive and integer times 10!'))
%         return;
%     end
%     handles.neuron_location=pp;
%     guidata(hObject, handles);
% else
%     msgbox('Unrecognized file format');
%     return;
% end

pp = import_csv_brain_coordinate;
if size(pp,2)~=3
    msgbox(sprintf('The coordinate file should contain 3 columns matrix only!'))
    return;
end
% if ~isequal(pp/10,round(pp/10)) || min(pp(:))<=0
%     msgbox(sprintf('Coordinates must be positive and integer times 10!'))
%     return;
% end

handles.neuron_location=unique(pp,'rows');
guidata(hObject, handles);


function transform_check_Callback(hObject, eventdata, handles)



