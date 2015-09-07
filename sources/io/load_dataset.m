function dataset=load_dataset(file_name, flag)
%flag: true for classification, false for regression, empty for recall
dataset=create_empty_dataset();

SS=load(file_name);

fnames=fieldnames(SS);
if length(fnames)>3
    msgbox('The data set must only contain sample matrix (3D), class label vector and variable name cell');
    return ;
end

eeg_data=[];
class_label=[];
for k=1:length(fnames)
    pp=getfield(SS,fnames{k});
    dims=size(pp);
    if length(dims)==3
        eeg_data=double(getfield(SS,fnames{k}));
    elseif isvector(pp) && (strcmp(class(pp),'double') || strcmp(class(pp),'logical') || strcmp(class(pp),'uint8') || strcmp(class(pp),'uint32'))
        class_label=getfield(SS,fnames{k});
        class_label=class_label(:)';
    elseif isvector(pp) && iscellstr(pp)
        Names=getfield(SS,fnames{k});
    end
end

if isempty(eeg_data) 
    msgbox('No sample matrix detected in this data set');
    return;
end
if ~exist('Names','var')
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
