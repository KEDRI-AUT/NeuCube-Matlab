function dataset=AER_encoding(dataset, flag)

% flag: true to encode training data, else to encode validation data

%==========================
inputnum=dataset.feature_number;
variable_threshold=get_threshold(dataset,dataset.encoding.spike_threshold); 
%==========================
if isempty(variable_threshold) || length(variable_threshold)~=inputnum
    msgbox('Encoding threshold used for the data set is incorrect');
	return;
end
if isempty(dataset.data)
    msgbox('No data!');
	return;
end
sample_amount_for_training=dataset.sample_amount_for_training;
sample_amount_for_validation=dataset.sample_amount_for_validation;
if flag==true && sample_amount_for_training>0
  
    data_for_training=dataset.training_data;
    timelength=dataset.training_time_length;
    if timelength<=1
        timelength=floor(timelength*size(data_for_training,1));
    end
    data_for_training=data_for_training(1:timelength,:,:);
    spike_state_length=timelength*sample_amount_for_training;
    
    
    spike_state_for_training=[];
    if sample_amount_for_training>0 % in case of only doing training or validation
        spike_state_for_training = zeros(spike_state_length,inputnum*2);   %用以计算脑电信号转换的脉冲
        
        threshold=repmat(variable_threshold',[size(data_for_training,1),1,size(data_for_training,3)]);
        
        eegbase=[data_for_training(1,:,:);data_for_training(1:timelength-1,:,:)];
        excspike=(data_for_training-eegbase>threshold);            % increase more than AER_threshold in one time tick, emit a exciting spike
        inhspike=(data_for_training-eegbase<-threshold);           % decrease more than AER_threshold in one time tick, emit a inhbiting spike
        eegspike=[excspike-inhspike,inhspike];
        
        for i=1:sample_amount_for_training
            spike_state_for_training((i-1)*timelength+1:i*timelength,:)=eegspike(:,:,i);
        end
        
    end
    dataset.spike_state_for_training=spike_state_for_training;
elseif flag==false && sample_amount_for_validation>=0
 
    data_for_validation=dataset.validation_data;
    timelength=dataset.validation_time_length;
    if timelength<=1
        timelength=floor(timelength*size(data_for_validation,1));
    end
    spike_state_length=timelength*sample_amount_for_validation;
    
    data_for_validation=data_for_validation(1:timelength,:,:);
    
    spike_state_for_validation=[];
    
    if sample_amount_for_validation>0
        spike_state_for_validation = zeros(spike_state_length,inputnum*2);   
        threshold=repmat(variable_threshold',[size(data_for_validation,1),1,size(data_for_validation,3)]);
        %threshold=repmat(variable_threshold',[size(data_for_training,1),1,size(data_for_training,3)]);
        
        eegbase=[data_for_validation(1,:,:);data_for_validation(1:timelength-1,:,:)];
        excspike=(data_for_validation-eegbase>threshold);          % increase more than AER_threshold in one time tick, emit a exciting spike
        inhspike=(data_for_validation-eegbase<-threshold);         % decrease more than AER_threshold in one time tick, emit a inhbiting spike
        eegspike=[excspike-inhspike,inhspike];
        
        for i=1:sample_amount_for_validation
            spike_state_for_validation((i-1)*timelength+1:i*timelength,:)=eegspike(:,:,i);
        end
    end
    dataset.spike_state_for_validation=spike_state_for_validation;
end

