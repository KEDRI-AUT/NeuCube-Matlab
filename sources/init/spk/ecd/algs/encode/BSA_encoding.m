function dataset=BSA_encoding(dataset,flag)
%flag: true for training data, false for validation data

%======================================================
%FilterType
%1 -- proper for a short and slow changing signal
%2 -- proper for a long signal, like eeg
%3 -- proper for a long and severely changing signal
FilterType=dataset.encoding.filter_type;
if FilterType==1
    Filter=fir1(2,0.8);
elseif FilterType==2
    Filter=fir1(6,0.05);
elseif FilterType==3
    Filter=fir1(6,0.8);
end
filter_length=length(Filter);

inputnum=dataset.feature_number;

if isempty(dataset.data)
    error('No data!');
end

%check the threshold
threshold=dataset.encoding.spike_threshold;
if length(threshold)==1 %the threshold is a scalar
    BSA_Threshold_rowVector=ones(1,inputnum)*threshold;
elseif length(threshold)==inputnum
    BSA_Threshold_rowVector=threshold;
else
    error('Encoding threshold used for the data set is incorrect');
end

%get the number of samples for training data and validation data seperately
sample_amount_for_training=dataset.sample_amount_for_training;
sample_amount_for_validation=dataset.sample_amount_for_validation;

%encoding training data if training samples exist
if flag==true
    spike_state_for_training=[];
    
    if sample_amount_for_training>0
        %get the encoding data length for each sample
        timelength=dataset.training_time_length;
        spike_state_length=timelength*sample_amount_for_training;
        data_for_training=dataset.training_data;
        
        time_len=size(data_for_training,1); %the time length for one feature input
        
        %signal normalization [0,1]
        min_data=min(data_for_training,[],1);
        max_data=max(data_for_training,[],1);
        EncodingSignal=data_for_training-repmat(min_data,[time_len,1,1]);
        EncodingSignal=EncodingSignal./(repmat(max_data,[time_len,1,1])-repmat(min_data,[time_len,1,1]));
        
        total_error=zeros(1,inputnum,sample_amount_for_training);
        
        SpikeTrain_temp=zeros(timelength,inputnum,sample_amount_for_training);
        
        for s=1:sample_amount_for_training
            for f=1:inputnum
                for i=1:(timelength-filter_length+1)
                    error1=0;
                    error2=0;
                    for j=1:filter_length
                        error1=error1+abs(EncodingSignal(i+j-1,f,s)-Filter(j));
                        error2=error2+abs(EncodingSignal(i+j-1,f,s));
                    end
                    
                    if error1<=(error2-BSA_Threshold_rowVector(f)) %spike criterion
                        SpikeTrain_temp(i,f,s)=1;
                        
                        for j=1:filter_length
                            EncodingSignal(i+j-1,f,s)=EncodingSignal(i+j-1,f,s)-Filter(j);
                        end
                        
                        total_error(1,f,s)=total_error(1,f,s)+error1;
                    else
                        total_error(1,f,s)=total_error(1,f,s)+error2;
                    end
                end
            end
        end
        
        %repmat the spike state
        spike_state_for_training=zeros(spike_state_length,inputnum*2);
        
        for s=1:sample_amount_for_training
            spike_state_for_training((s-1)*timelength+1:s*timelength,1:inputnum)=SpikeTrain_temp(:,:,s);
        end
        
    end
    
    dataset.spike_state_for_training=spike_state_for_training;
else %flag false for encoding validation data
    spike_state_for_validation=[];
    
    if sample_amount_for_validation>0
        %get the encoding data length for each sample
        timelength=dataset.validation_time_length;
        spike_state_length=timelength*sample_amount_for_validation;
        data_for_validation=dataset.validation_data;
        
        time_len=size(data_for_validation,1); %the time length for one feature input
        
        %signal normalization [0,1]
        min_data=min(data_for_validation,[],1);
        max_data=max(data_for_validation,[],1);
        EncodingSignal=data_for_validation-repmat(min_data,[time_len,1,1]);
        EncodingSignal=EncodingSignal./(repmat(max_data,[time_len,1,1])-repmat(min_data,[time_len,1,1]));
        
        total_error=zeros(1,inputnum,sample_amount_for_validation);
        
        SpikeTrain_temp=zeros(timelength,inputnum,sample_amount_for_validation);
        
        for s=1:sample_amount_for_validation
            for f=1:inputnum
                for i=1:(timelength-filter_length+1)
                    error1=0;
                    error2=0;
                    for j=1:filter_length
                        error1=error1+abs(EncodingSignal(i+j-1,f,s)-Filter(j));
                        error2=error2+abs(EncodingSignal(i+j-1,f,s));
                    end
                    
                    if error1<=(error2-BSA_Threshold_rowVector(f)) %spike criterion
                        SpikeTrain_temp(i,f,s)=1;
                        
                        for j=1:filter_length
                            EncodingSignal(i+j-1,f,s)=EncodingSignal(i+j-1,f,s)-Filter(j);
                        end
                        
                        total_error(1,f,s)=total_error(1,f,s)+error1;
                    else
                        total_error(1,f,s)=total_error(1,f,s)+error2;
                    end
                end
            end
        end
        
        %repmat the spike state for validation data
        spike_state_for_validation=zeros(spike_state_length,inputnum*2);
        for s=1:sample_amount_for_validation
            spike_state_for_validation((s-1)*timelength+1:s*timelength,1:inputnum)=SpikeTrain_temp(:,:,s);
        end
    end
    
    dataset.spike_state_for_validation=spike_state_for_validation;
end
