function varargout = helpDoc(varargin)
% HELPDOC MATLAB code for helpDoc.fig
%      HELPDOC, by itself, creates a new HELPDOC or raises the existing
%      singleton*.
%
%      H = HELPDOC returns the handle to a new HELPDOC or the handle to
%      the existing singleton*.
%
%      HELPDOC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HELPDOC.M with the given input arguments.
%
%      HELPDOC('Property','Value',...) creates a new HELPDOC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before helpDoc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to helpDoc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help helpDoc

% Last Modified by GUIDE v2.5 18-Dec-2013 16:07:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @helpDoc_OpeningFcn, ...
    'gui_OutputFcn',  @helpDoc_OutputFcn, ...
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


% --- Executes just before helpDoc is made visible.
function helpDoc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to helpDoc (see VARARGIN)

% Choose default command line output for helpDoc
handles.output = hObject;
% set(handles.pushbutton2,'pointer','hand');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes helpDoc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = helpDoc_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
open('docs\NeuCube V1.1 Manual June  2015.pdf')
close;


function text2_ButtonDownFcn(hObject, eventdata, handles)
web('http://www.kedri.aut.ac.nz/', '-browser');



function pushbutton2_Callback(hObject, eventdata, handles)
web('http://www.kedri.aut.ac.nz/', '-browser');
