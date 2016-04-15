function dataset=data_split(dataset)
% split the dataset into training and validation parts

if isempty(dataset.data) || length(size(dataset.data))~=3
    error('Bad data matrix! ');
end

training_percentage=dataset.training_set_ratio;
if training_percentage<0 || training_percentage>1
    error('Training set division must be in interval [0,1]');
end
eeg_data=dataset.data;
total_sample_number = dataset.total_sample_number;  %samples
number_of_class = dataset.number_of_class;
class_label=dataset.target_value;

sample_id=1:total_sample_number;
eeg_data_for_training=[];
eeg_data_for_validation=[];
class_label_for_training=[];
class_label_for_validation=[];
sample_amount_for_training=0;
sample_amount_for_validation=0;
training_sample_id=[];
validation_sample_id=[];

if number_of_class==1 %regression
    sample_amount_for_training=floor(total_sample_number*training_percentage);
    split_one;
else
    if ~isempty(class_label)
        labelset=unique(class_label);
        split_reg;
    else  %pure classification, no validation
        eeg_data_for_validation=eeg_data;
        sample_amount_for_validation=total_sample_number;
        class_label_for_validation=[];
    end
end

dataset.sample_amount_for_training=sample_amount_for_training;
dataset.sample_amount_for_validation=sample_amount_for_validation;

dataset.training_data=eeg_data_for_training;
dataset.validation_data=eeg_data_for_validation;

dataset.target_value_for_training=class_label_for_training;
dataset.target_value_for_validation=class_label_for_validation;

dataset.training_sample_id=training_sample_id;
dataset.validation_sample_id=validation_sample_id;