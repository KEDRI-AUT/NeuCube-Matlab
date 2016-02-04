function varargout = NeuCube_M1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NeuCube_M1_OpeningFcn, ...
    'gui_OutputFcn',  @NeuCube_M1_OutputFcn, ...
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

% the initialization of the software
function NeuCube_M1_OpeningFcn(hObject, eventdata, handles, varargin)
global show_progress_bar

% currentFolder
handles.output = hObject;
ui_state(handles, 0, 0);
hcube=handles.cube;
%reset the figure
cla(handles.cube,'reset')
axes(handles.cube);
plot3(0,0,0,'w');
axis([-60 60 -80 60 -40 60]);
box on
set(gcf,'name','NeuCube(V1.1)');

set(handles.output_layer,'xtick',[],'xticklabel',[])
set(handles.output_layer,'ytick',[],'yticklabel',[])
box on

axis(handles.axes4,'off');
axis(handles.axes5,'off');

% flag=time_check(1);
% if ~flag
%     retrun;
% end
str=sprintf('NeuCube is a Neurocomputing Software/Hardware Development Environment for Spiking Neural Network Applications in Data Mining, Pattern Recognition and Predictive Data Modelling. NeuCube is an intellectual property owned by AUT.\n\nPlease load your dataset from file menu.');
%str=sprintf('Copyright KEDRI (Please see "http://www.kedri.aut.ac.nz/neucube" for further detail)\n\nPlease load your dataset from file menu');
output_information(str,handles);
handles.gui_params=reset_parameters();
handles.dataset=create_empty_dataset();
handles.classifier_visual=-1;
show_progress_bar=true;
cube_pos=get(handles.cube,'Position');
handles.cube_pos=cube_pos;
set(handles.Axes_signal,'visible','off');
guidata(hObject, handles);


function file_menu_Callback(hObject, eventdata, handles)

function file_load_data_Callback(hObject, eventdata, handles)

function view_menu_Callback(hObject, eventdata, handles)


function pushbutton10_Callback(hObject, eventdata, handles)


function pushbutton11_Callback(hObject, eventdata, handles)


function next_step_btn_Callback(hObject, eventdata, handles)
uiresume


function visual_type_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function update_speed_edit_Callback(hObject, eventdata, handles)


function update_speed_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function visual_content_pop_Callback(hObject, eventdata, handles)


function visual_content_pop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function save_to_movie_check_Callback(hObject, eventdata, handles)


function neuron_legend_check_Callback(hObject, eventdata, handles)


function show_feature_btn_Callback(hObject, eventdata, handles)


function help_menu_Callback(hObject, eventdata, handles)


function help_user_manual_Callback(hObject, eventdata, handles)  
if isdeployed
  web('https://dev.aut.ac.nz/__data/assets/pdf_file/0004/578173/manual.pdf')
else
  web('https://dev.aut.ac.nz/__data/assets/pdf_file/0004/578173/manual.pdf')
   %open('docs\NeuCube V1.1 Manual June  2015.pdf') 
end
%open('NeuCube V1.1 Manual June  2015.pdf')

function help_about_Callback(hObject, eventdata, handles)
helpDoc;

function view_rotate_view_Callback(hObject, eventdata, handles)


function view_zoom_in_Callback(hObject, eventdata, handles)


function view_zoom_out_Callback(hObject, eventdata, handles)


function view_pan_view_Callback(hObject, eventdata, handles)


function toolbar_help_ClickedCallback(hObject, eventdata, handles)
helpDoc;

function file_cross_validation_Callback(hObject, eventdata, handles)


function file_quit_Callback(hObject, eventdata, handles)
delete(gcf);

function figure1_CloseRequestFcn(hObject, eventdata, handles)
clear global
delete(hObject);


function result_analysis_Callback(hObject, eventdata, handles)


function show_threshold_edit_Callback(hObject, eventdata, handles)


function show_threshold_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function varargout = NeuCube_M1_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


function options_menu_Callback(hObject, eventdata, handles)

function classifier_menu_Callback(hObject, eventdata, handles)

function M5_module_Callback(hObject, eventdata, handles)

function menu_statistics_Callback(hObject, eventdata, handles)

