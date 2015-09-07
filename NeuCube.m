function varargout = NeuCube(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NeuCube_OpeningFcn, ...
                   'gui_OutputFcn',  @NeuCube_OutputFcn, ...
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

function NeuCube_OpeningFcn(hObject, eventdata, handles, varargin)
currentFolder = pwd;
if ~isdeployed
    addpath(genpath(currentFolder));
end
cla reset
I=imread('img\neurocomputing.png');
imshowh(handles.architecture_axes,I);
handles.output = hObject;
guidata(hObject, handles);


function varargout = NeuCube_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function module_one_btn_Callback(hObject, eventdata, handles)
h=gcf;
set(h,'pointer','watch');
drawnow
NeuCube_M1
set(h,'pointer','arrow');
set(h,'visible','off')

function module_two_btn_Callback(hObject, eventdata, handles)

function module_three_btn_Callback(hObject, eventdata, handles)

function module_four_btn_Callback(hObject, eventdata, handles)
