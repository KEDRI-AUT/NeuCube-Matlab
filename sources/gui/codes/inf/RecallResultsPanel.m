function varargout = RecallResultsPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RecallResultsPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @RecallResultsPanel_OutputFcn, ...
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

function RecallResultsPanel_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
dataset=varargin{1};
predict_value_for_validation=dataset.predict_value_for_validation;
set(handles.recall_result_table, 'RowName','Value');
RN={};
for k=1:length(predict_value_for_validation)
    RN{k}=sprintf('Sample %d', k);
end
set(handles.recall_result_table, 'ColumnName',RN);
set(handles.recall_result_table, 'data',predict_value_for_validation(:)');
handles.results=predict_value_for_validation;
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = RecallResultsPanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function export_result_btn_Callback(hObject, eventdata, handles)
results=handles.results;
[file,path] = uiputfile('*.mat','Save Workspace As',strcat('Result_',datestr(now,30),'.mat'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
     label=results.predict_value_for_validation;
    label=label';
    csvwrite(strcat(path,file),label)
%     save(strcat(path,file),'results');
end
msgbox('Export successfully!');