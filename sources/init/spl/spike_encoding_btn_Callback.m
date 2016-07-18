function spike_encoding_btn_Callback(hObject, eventdata, handles)

h=gcf;
dataset=handles.dataset;
if isempty(dataset.data)
    msgbox('Please load a dataset!');
    return;
end
if validate_limit(dataset)==true
    return;
end
encoding_params=handles.gui_params.encoding;
if isempty(dataset.target_value) 
    [encoding_params, sample_id, feature_id]=EncodingPanel(encoding_params, true, dataset.total_sample_number, dataset.feature_name);
    is_recall=true;
else
    [encoding_params, sample_id, feature_id]=EncodingPanel(encoding_params, false, dataset.total_sample_number, dataset.feature_name);
    is_recall=false;
end
if ~isstruct(encoding_params)
    return;
end
set(h,'Pointer','watch');
drawnow
training_time_length=encoding_params.training_time_length;
validation_time_length=encoding_params.validation_time_length;
training_set_ratio=encoding_params.training_set_ratio;

dataset.training_time_length=floor(size(dataset.data,1)*training_time_length);
dataset.validation_time_length=floor(size(dataset.data,1)*validation_time_length);
dataset.training_set_ratio=training_set_ratio;
dataset_tmp=dataset;
dataset=data_split(dataset);

method=encoding_params.method;

dataset_tmp.training_set_ratio=1;
dataset_tmp=data_split(dataset_tmp);
signal=dataset_tmp.data(:,feature_id, sample_id);
len=length(signal);
if len>500
    len=500;
end
%handles.signal=signal;
if(dataset.type~=3)
    if(dataset.training_set_ratio==1)
        dataset.validation_data=dataset.training_data;
        dataset.target_value_for_validation=dataset.target_value_for_training;
        dataset.sample_amount_for_validation=dataset.sample_amount_for_training;
    end
end
switch method
    case 1 % AER
        [dataset, dataset_tmp]=ecd_aer(dataset,dataset_tmp,encoding_params);
        str=sprintf('Encoding Parameters:\n   Method: TR\n   Threshold:%.02f \n\nSpike Rate: %.02f',encoding_params.spike_threshold,get_spike_rate(dataset));
    case 2 % BAS
        [dataset, dataset_tmp]=ecd_bsa(dataset,dataset_tmp,encoding_params);
        str=sprintf('Encoding Parameters:\n   Method: BSA\n   Threshold:%.02f\nFilter:%d \n\nSpike Rate: %.02f',encoding_params.spike_threshold,encoding_params.filter_type,get_spike_rate(dataset));
        %sum(sum(dataset_tmp.spike_state_for_training))
    case 3 % Moving window
        [dataset, dataset_tmp]=ecd_mvw(dataset,dataset_tmp,encoding_params);
        str=sprintf('Encoding Parameters:\n   Method: MV\n   Threshold:%.02f\nWindow Size:%d \n\nSpike Rate: %.02f',encoding_params.spike_threshold,encoding_params.window_size,get_spike_rate(dataset));
        
    case 4 % Foreward step
        [dataset, dataset_tmp]=ecd_fws(dataset,dataset_tmp,encoding_params);
        str=sprintf('Encoding Parameters:\n   Method: FS\n   Threshold:%.02f \n\nSpike Rate: %.02f',encoding_params.spike_threshold,get_spike_rate(dataset));
end
handles.signal=dataset.data(:,feature_id,sample_id);



set(h,'Pointer','arrow');
neucube.step=2;

if is_recall==true 
    ui_state(handles, 2, 1);
else
    ui_state(handles, 2, 0);
end
cla(handles.output_layer);
set(handles.network_analysis_btn,'enable','off');
output_information(str,handles);
handles.gui_params.encoding=encoding_params;
handles.dataset=dataset;



if(dataset.type~=3)
    spike=dataset_tmp.spike_state_for_training((sample_id-1)*dataset_tmp.length_per_sample+1:sample_id*dataset_tmp.length_per_sample, feature_id);
    L=spike==0;
    spike(L)=nan;
    handles.spike=spike;
    plots(handles,len);
else

  spike=dataset.spike_state_for_validation((sample_id-1)*dataset.length_per_sample+1:sample_id*dataset.length_per_sample, feature_id);
  L=spike==0;
  spike(L)=nan;

  handles.spike=spike;
  plots(handles,len);
end

guidata(hObject, handles);


