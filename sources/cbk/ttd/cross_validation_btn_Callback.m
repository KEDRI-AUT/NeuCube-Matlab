function cross_validation_btn_Callback(hObject, eventdata, handles)
dataset=handles.dataset;
gui_params=handles.gui_params;
neucube=handles.neucube;

if isempty(dataset.data)
    msgbox('Please load data set first');
    return;
end

str=sprintf('Enter cross validation fold number\n(enter 1 for leave-one-out cross validation)');
prompt = {str,'Enter a file name to save the result:'};
dlg_title = 'NeuCube';
num_lines = 1;

def = {'2','Results_of_cross_validation'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    return;
end
fold_number=round(str2double(answer{1}));
if isempty(fold_number) || fold_number<1 || fold_number >=dataset.total_sample_number
    msgbox('Fold number must be positive integer and less than data set size');
    return;
end

set(handles.visual_type_pop,'value',1);
set(handles.visual_content_pop,'enable','off');
set(handles.update_speed_edit,'enable','off');
set(handles.save_to_movie_check,'enable','off');
set(handles.neuron_legend_check,'enable','off');
set(handles.next_step_btn,'enable','off');
set(handles.show_threshold_edit,'enable','off');
h=gcf;
set(h,'pointer','watch');
drawnow

fprintf('\n');
fprintf('\n');
fprintf('================= %d FOLD CROSS VALIDATION =====================\n',fold_number);
fprintf('Data set:');
disp(dataset.file_name);
fprintf('Time:');
fprintf(datestr(now));
fprintf('\n\n');
 [ground_truth_label, predicted_label]=cross_validation(handles, dataset, neucube, gui_params, fold_number);
 fprintf('\n');
 dataset.predict_value_for_validation=predicted_label;
 dataset.target_value_for_validation=ground_truth_label;
 output_result(dataset, handles);
  RegressionAnalysisPanel(dataset);
 if dataset.type==1
     str=sprintf('Cross validation finished. Overall Accuracy:%.02f%%', sum(ground_truth_label==predicted_label)/length(predicted_label)*100);
 else
     str=sprintf('Cross validation finished. Absolute Error:%.02f', sum(abs(ground_truth_label-predicted_label))/length(predicted_label)*100);
 end
 disp(str);
 fprintf('Time:');
fprintf(datestr(now));
 fprintf('\n================================================================\n');
 if ~isempty(answer{2})
     save(strcat('answer{2}'),'ground_truth_label','predicted_label','dataset','neucube','gui_params');
 end
 set(h,'pointer','arrow');