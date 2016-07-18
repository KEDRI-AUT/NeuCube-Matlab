function dataset=MW_encoding(dataset,flag)
%flag: true for training data, false for validation data

%=================================================================
inputnum=dataset.feature_number;

if isempty(dataset.data)
    msgbox('No data!');
	return;
end

%check the threshold
variable_threshold=get_threshold(dataset,dataset.encoding.spike_threshold);
if length(variable_threshold) ~= inputnum
    msgbox('Encoding threshold used for the data set is incorrect');
	return;
end

%get the window size for the moving window
windowsize=dataset.encoding.window_size;


%encoding for training data
if flag
    sample_amount_for_training=dataset.sample_amount_for_training;
    
    spike_state_for_training=[];
    if sample_amount_for_training>0
        
        %get the encoding data length for each sample
        timelength=dataset.training_time_length;
        spike_state_length=timelength*sample_amount_for_training;
        data_for_training=dataset.training_data;
        
        SpikeTrain_temp=zeros(timelength,inputnum,sample_amount_for_training);
        for s=1:sample_amount_for_training
            for f=1:inputnum
                %the base value for distinguish a change in signal
                base_value=data_for_training(1,f,s);
                for t=2:timelength
                    
                    if t<=windowsize
                        base_value=mean(data_for_training(1:t-1,f,s));
                    else
                        base_value=mean(data_for_training(t-3:t-1,f,s));
                    end
                    
                    if data_for_training(t,f,s)>=(base_value+variable_threshold(f))%positive spike
                        SpikeTrain_temp(t,f,s)=1;
                    elseif data_for_training(t,f,s)<=(base_value-variable_threshold(f)) %negative spike
                        SpikeTrain_temp(t,f,s)=-1;
                    end
                end
            end
        end
        
        %repmat the spike state
        spike_state_for_training=zeros(spike_state_length,inputnum*2);
        
        for s=1:sample_amount_for_training
            %positive side
            spike_state_for_training((s-1)*timelength+1:s*timelength,1:inputnum)=SpikeTrain_temp(:,:,s);
            %negative side in spike state
            spike_state_for_training((s-1)*timelength+1:s*timelength,inputnum+1:end)= (SpikeTrain_temp(:,:,s)==-1);
        end
    end
    
    dataset.spike_state_for_training=spike_state_for_training;
else %false -- encoding for validation data
    sample_amount_for_validation=dataset.sample_amount_for_validation;
    
    spike_state_for_validation=[];
    if sample_amount_for_validation>0
        %get the encoding data length for each sample
        timelength=dataset.validation_time_length;
        spike_state_length=timelength*sample_amount_for_validation;
        data_for_validation=dataset.validation_data;
        
        SpikeTrain_temp=zeros(timelength,inputnum,sample_amount_for_validation);
        for s=1:sample_amount_for_validation
            for f=1:inputnum
                %the base value for distinguish a change in signal
                base_value=data_for_validation(1,f,s);
                for t=2:timelength
                    
                    if t<=windowsize
                        base_value=mean(data_for_validation(1:t-1,f,s));
                    else
                        base_value=mean(data_for_validation(t-3:t-1,f,s));
                    end
                    
                    if data_for_validation(t,f,s)>=(base_value+variable_threshold(f))%positive spike
                        SpikeTrain_temp(t,f,s)=1;
                    elseif data_for_validation(t,f,s)<=(base_value-variable_threshold(f)) %negative spike
                        SpikeTrain_temp(t,f,s)=-1;
                    end
                end
            end
        end
        
        %repmat the spike state
        spike_state_for_validation=zeros(spike_state_length,inputnum*2);
        
        for s=1:sample_amount_for_validation
            %positive side
            spike_state_for_validation((s-1)*timelength+1:s*timelength,1:inputnum)=SpikeTrain_temp(:,:,s);
            %negative side in spike state
            spike_state_for_validation((s-1)*timelength+1:s*timelength,inputnum+1:end)= (SpikeTrain_temp(:,:,s)==-1);
        end
        
    end
    
    dataset.spike_state_for_validation=spike_state_for_validation;
end
