function varargout = ClassificationResultAnalysisPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClassificationResultAnalysisPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @ClassificationResultAnalysisPanel_OutputFcn, ...
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

function ClassificationResultAnalysisPanel_OpeningFcn(hObject, eventdata, handles, varargin)
dataset=varargin{1};
target=dataset.target_value_for_validation;
predict=dataset.predict_value_for_validation;
ct=confusion_table(dataset.target_value_for_validation, dataset.predict_value_for_validation);
set(gcf,'windowstyle','modal');
for k=1:dataset.number_of_class
    str=sprintf('Class %d',k);
    Names{k}=str;
end
set(handles.confusion_table,'RowName',Names);
set(handles.confusion_table,'ColumnName',Names);
set(handles.confusion_table,'data',ct);

str=sprintf('Overall Accuracy: %.02f%%\n- ',sum(target(:)==predict(:))/length(target)*100);
cls=unique(target);
for k=1:length(cls)
    L=target==cls(k);
    s=sprintf('Class %d Accuracy: %.02f%%\n- ',k,sum(predict(L)==cls(k))/sum(L)*100);
    str=strcat(str,s);
end
str=str(1:end-1);
set(handles.information_text,'string',str);

function varargout = ClassificationResultAnalysisPanel_OutputFcn(hObject, eventdata, handles) 

% varargout{1} = handles.output;
