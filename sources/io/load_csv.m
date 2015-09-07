function dataset=load_csv(flag)
if ~isempty(flag)
[eeg_data, class_label, Names, file_name]=LoadDataset(0);
else
 [eeg_data, class_label, Names, file_name]=LoadDataset(1);  
 
end

% file_name=[];
if isempty(eeg_data) || isempty(class_label)
    return;
end
dataset=create_empty_dataset();
if ~exist('Names','var') || ~iscell(Names)
    Names={};
    for k=1:size(eeg_data,2)
        Names{k}=sprintf('feature %d',k);
    end
end

if ~isempty(flag)
    cls=unique(class_label);
    if flag==false;
        dataset.number_of_class=1;
        dataset.type=2;
    else
        dataset.number_of_class=length(cls);
        dataset.type=1;
        target=zeros(size(class_label));
        for k=1:length(cls)
            L=class_label==cls(k);
            target(L)=k;
        end
        class_label=target;
    end
else
    dataset.type=3;
    class_label=[];
end

dataset.file_name=file_name;
dataset.data=eeg_data; 
dataset.target_value=class_label(:); 
dataset.length_per_sample=size(eeg_data,1); 
dataset.feature_number=size(eeg_data,2);
dataset.total_sample_number=size(eeg_data,3);  
dataset.feature_name=Names; 


dataset.training_data=[];
dataset.target_value_for_training=[];
dataset.spike_state_for_training=[];
dataset.training_time_length=size(eeg_data,1); 
dataset.sample_amount_for_training=0;
dataset.training_sample_id=[];

dataset.validation_data=[];
dataset.target_value_for_validation=[];
dataset.spike_state_for_validation=[];
dataset.validation_time_length=size(eeg_data,1);
dataset.sample_amount_for_validation=0; 