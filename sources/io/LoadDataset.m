function varargout = LoadDataset(varargin)
% LOADDATASET MATLAB code for LoadDataset.fig
%      LOADDATASET, by itself, creates a new LOADDATASET or raises the existing
%      singleton*.
%
%      H = LOADDATASET returns the handle to a new LOADDATASET or the handle to
%      the existing singleton*.
%
%      LOADDATASET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOADDATASET.M with the given input arguments.
%
%      LOADDATASET('Property','Value',...) creates a new LOADDATASET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LoadDataset_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LoadDataset_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LoadDataset

% Last Modified by GUIDE v2.5 19-Jun-2015 11:00:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LoadDataset_OpeningFcn, ...
                   'gui_OutputFcn',  @LoadDataset_OutputFcn, ...
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


% --- Executes just before LoadDataset is made visible.
function LoadDataset_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LoadDataset (see VARARGIN)

% Choose default command line output for LoadDataset
handles.output = hObject;
handles.dataset=0;
handles.class_label=0;
handles.names=0;
set(hObject,'windowstyle','modal');
handles.confirmation=0;
handles.is_recall=varargin{1};
% Update handles structure
guidata(hObject, handles);
uiwait(hObject);

% UIWAIT makes LoadDataset wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LoadDataset_OutputFcn(hObject, eventdata, handles) 

if ishandle(hObject)
    if handles.confirmation==1
        varargout{1} = handles.dataset;
        varargout{2} = handles.class_label;
        varargout{3}= handles.names;
        varargout{4}=handles.d;
    else
        varargout{1}=0;
        varargout{2}=0;
        varargout{3}=0;
        varargout{4}=0;
    end
    delete(hObject);
end

function OK_btn_Callback(hObject, eventdata, handles)
handles.confirmation=1;
guidata(hObject,handles);
close

function cancel_btn_Callback(hObject, eventdata, handles)
handles.confirmation=0;
guidata(hObject,handles);
close



function figure1_CloseRequestFcn(hObject, eventdata, handles)
if handles.confirmation==0
    handles.dataset=0;
    handles.class_label=0;
    guidata(hObject, handles);
elseif handles.confirmation==1 && numel( handles.dataset)==1
        msgbox('Please load the data samples');
        return;
end
if isequal(get(hObject,'waitstatus'),'waiting') 
    uiresume(hObject);
else
    delete(hObject);
end


function feature_name_btn_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.txt','Select the feature name file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
handles.names=textread(strcat(PathName,FileName),'%s');
guidata(hObject, handles);


% --- Executes on button press in log_chkbox.
function log_chkbox_Callback(hObject, eventdata, handles)
% hObject    handle to log_chkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of log_chkbox
if(get(hObject,'Value'))
    [FileName,PathName] = uiputfile({'*.txt'},'Save log file as');
    if(FileName~=0)
        handles.logfilepath=strcat(PathName,FileName);
    else
        set(handles.log_chkbox,'Value',0);
    end
end
guidata(hObject,handles);

% --- Executes on button press in choose_folder.
function choose_folder_Callback(hObject, eventdata, handles)
% hObject    handle to choose_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d = uigetdir(pwd, 'Select a folder'); %choose the folder containing data
flag=0;
if(get(handles.log_chkbox,'Value')) %check if the log checkbox is ticked
    fileID = fopen(handles.logfilepath,'w');
    flag=1;
end
%-----------------------read sample files------------------------%
if(flag)
    fprintf(fileID,'reading sample files....\n');
end
files = dir(fullfile(d, 'sam*.csv'));%%choose all the files starting with sam
count=1;
token=[];
handles.d=d;
for i=1:size(files,1)    %for all the files tokenize the digits
    exp=regexp(files(i).name,'sam(\d+)','tokens');   %%search for numbers after 'sam' in each file
    if(~isempty(exp)) %%checks if the sample file contains digits after 'sam'
        newfiles(count)=files(i);
        token(count)=str2num(cell2mat(exp{1}));
        index(count)=i;
        count=count+1; 
    else
        if(flag)
            fprintf(fileID,strcat('Sample file ignored:',files(i).name,'[filename validation failed]','\n'));
        end
    end
end
if(size(token,1)~=0)
    [B,I]=sort(token); %%sort the tokens from the 'sam' files
    for i=1:size(I,2) %%read the sample files in increasing order of the digits
        data=csvread(strcat(d,'\',newfiles(I(i)).name));
        if(i==1)
            num_time=size(data,1);
            num_feature=size(data,2);      
            dataset(:,:,i)=data;
            if(flag)
%                 fprintf(fileID,strcat('Sample loading successful:',newfiles(I(i)).name,'\n'));
            end
        end
        if(i>1)
            if((size(data,1)==num_time)&&(size(data,2)==num_feature))
                dataset(:,:,i)=data;
                if(flag)
%                     fprintf(fileID,strcat('Sample loading successful:',newfiles(I(i)).name,'\n'));
                end
            else
                if(flag)
                    fprintf(fileID, strcat('Sample loading failed:',newfiles(I(i)).name,'[matrix dimension match failed]'));
                    fclose(fileID);
                end
                msgbox('[Matrix dimension mismatch]:Sample loading failed!!')
                return;
            end
        end
    end
else
    if(flag)
        fprintf(fileID, 'Error: No sample found');
        fclose(fileID);
    end
    msgbox('[No sample file found]:Sample loading failed!!')
    return;
end

if ~isempty(dataset)
    handles.dataset=dataset;
    handles.sample_number=size(dataset,3);
    guidata(hObject,handles);
end
if(flag)
    fprintf(fileID,'sample loaded successfully\n');
end
num_sample=size(dataset,3);


if(handles.is_recall==0)
%--------------read target file---------------------------%
if(flag)
    fprintf(fileID,'reading target file....\n');
end
files = dir(fullfile(d, 'tar*.csv'));%%choose all the files starting with tar
if(size(files,1)~=1)
    if(flag)
        fprintf(fileID,'Error:no or multiple target file found.\n');
        fclose(fileID);
    end
    msgbox('[No or multiple target files found]: Target loading failed!!');
    return;
end
class_label=csvread(strcat(d,'\',files(1).name));

if(size(class_label,1)~=num_sample)
    if(flag)
        fprintf('Target loading failed: number of sample mismatch\n');
        fclose(fileID);
    end    
    msgbox('[Number of sample mismatch]:target loading failed!!');
    return;
end
class_label=class_label';
if ~isempty(class_label)
    handles.class_label=class_label;
    guidata(hObject,handles);
end
if(flag)
    fprintf(fileID,'Target loaded successfully');
end

if(flag)
    fclose(fileID);
end
else
    handles.class_label=[];
end
msgbox('Files loaded succesfully!!');