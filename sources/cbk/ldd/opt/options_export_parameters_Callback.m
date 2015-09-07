function options_export_parameters_Callback(hObject, eventdata, handles)
[file,path] = uiputfile('*.csv','Save Workspace As',strcat('Parameter_',datestr(now,30),'.csv'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    fid = fopen(strcat(path,file), 'wt');
    gui_params=handles.gui_params;
    fprintf('NeuCube Parameters:\n');
    
    structarr=gui_params.encoding;
    fields = repmat(fieldnames(structarr), numel(structarr), 1);
    for k=1:length(fields)
        fprintf(fid, '%s,', fields{k});
        fprintf(fid, '%g\n', getfield(structarr, fields{k})); 
    end
    
    fprintf(fid, '\n');
    structarr=gui_params.init;
    fields = repmat(fieldnames(structarr), numel(structarr), 1);
    for k=1:length(fields)
        fprintf(fid, '%s,', fields{k});
        fprintf(fid, '%g\n', getfield(structarr, fields{k}));
    end
    
     fprintf(fid, '\n');
    structarr=gui_params.unsup;
    fields = repmat(fieldnames(structarr), numel(structarr), 1);
    for k=1:length(fields)
        fprintf(fid, '%s,', fields{k});
        fprintf(fid, '%g\n', getfield(structarr, fields{k}));
    end
    
     fprintf(fid, '\n');
    structarr=gui_params.sup;
    fields = repmat(fieldnames(structarr), numel(structarr), 1);
    for k=1:length(fields)
        fprintf(fid, '%s,', fields{k});
        fprintf(fid, '%g\n', getfield(structarr, fields{k}));
    end
    fclose(fid);
end
output_information('Parameters are exported sucessfully!', handles);