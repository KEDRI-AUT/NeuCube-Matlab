function varargout = OptionPanel(varargin)
% OPTIONPANEL MATLAB code for OptionPanel.fig
%      OPTIONPANEL, by itself, creates a new OPTIONPANEL or raises the existing
%      singleton*.
%
%      H = OPTIONPANEL returns the handle to a new OPTIONPANEL or the handle to
%      the existing singleton*.
%
%      OPTIONPANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIONPANEL.M with the given input arguments.
%
%      OPTIONPANEL('Property','Value',...) creates a new OPTIONPANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OptionPanel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OptionPanel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OptionPanel

% Last Modified by GUIDE v2.5 03-Feb-2015 15:50:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OptionPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @OptionPanel_OutputFcn, ...
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


% --- Executes just before OptionPanel is made visible.
function OptionPanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OptionPanel (see VARARGIN)

% Choose default command line output for OptionPanel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OptionPanel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OptionPanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global show_progress_bar
set(handles.show_progress_bar_check,'value',show_progress_bar);
varargout{1} = handles.output;


function show_progress_bar_check_Callback(hObject, eventdata, handles)
global show_progress_bar
if get(hObject, 'value')==1
    show_progress_bar=true;
else
    show_progress_bar=false;
end