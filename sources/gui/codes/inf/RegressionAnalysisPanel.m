function varargout = RegressionAnalysisPanel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RegressionAnalysisPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @RegressionAnalysisPanel_OutputFcn, ...
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




function RegressionAnalysisPanel_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
dataset=varargin{1};
number_of_class=dataset.number_of_class;
target_value_for_validation=dataset.target_value_for_validation;
predict_value_for_validation=dataset.predict_value_for_validation;
axes(handles.regression_result_axes);
cla(handles.regression_result_axes,'reset') 

data=cat(1, target_value_for_validation(:)',predict_value_for_validation(:)');
set(handles.regression_result_table,'data', data);
set(handles.regression_result_table,'rowname', {'Truth','Prediction'});
RN={};
for k=1:length(predict_value_for_validation)
    RN{k}=sprintf('Sample %d', k);
end
set(handles.regression_result_table, 'ColumnName',RN);
results=[];
if number_of_class==1
    hold on
    plot(target_value_for_validation,'r-^');
    plot(predict_value_for_validation,'-*');
    hold off
    legend('True Value','Predicted Value');

    SAE=sum(abs(target_value_for_validation(:)'-predict_value_for_validation(:)'));
    SSE=sum((target_value_for_validation(:)'-predict_value_for_validation(:)').^2);
    SSE=sum((predict_value_for_validation(:)-target_value_for_validation(:)).^2)/length(predict_value_for_validation);
    str=sprintf('Prediction accuracy:\n    MSE=%.02f\n    RMSE=%.02f',SSE,sqrt(SSE));
    set(gcf,'name','Regression Result');
    results.SAE=SAE;
    results.SSE=SSE;
else
    hold on
    plot(target_value_for_validation,'r^');
    plot(predict_value_for_validation,'*');
    hold off
    legend('True Value','Predicted Value');

    str=sprintf('Overall Accuracy: %.02f%%\n- ',sum(target_value_for_validation(:)==predict_value_for_validation(:))/length(target_value_for_validation)*100);
    cls=unique(target_value_for_validation);
    for k=1:length(cls)
        L=target_value_for_validation==cls(k);
        acc=sum(predict_value_for_validation(L)==cls(k))/sum(L)*100;
        s=sprintf('Class %d Accuracy: %.02f%%\n- ',k,acc);
        str=strcat(str,s);
        
        field=sprintf('Class_%d',k);
        results=setfield(results, field,acc);
    end
    str=str(1:end-1);
    set(gcf,'name','Classification Result');
    set(gca,'ytick',cls);
end
set(handles.regression_result_text, 'string', str);
results.predict_value_for_validation=predict_value_for_validation;
results.target_value_for_validation=target_value_for_validation;
handles.results=results;
% Update handles structure
guidata(hObject, handles);




function varargout = RegressionAnalysisPanel_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function export_result_btn_Callback(hObject, eventdata, handles)
results=handles.results;
[file,path] = uiputfile('*.csv','Save Workspace As',strcat('Result_',datestr(now,30),'.csv'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    label=results.predict_value_for_validation;
    label(:,2)=results.target_value_for_validation;
    label=label';
    csvwrite(strcat(path,file),label)
%     save(strcat(path,file),'results');
end
msgbox('Export successfully!');
