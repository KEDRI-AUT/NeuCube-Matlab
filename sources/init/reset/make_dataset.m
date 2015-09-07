function dataset=make_dataset(training_data,training_target, training_time_length, validation_data, validation_target, validation_time_length,number_of_class, type)
dataset=create_empty_dataset();
dataset.file_name=''; 
dataset.data=cat(3, training_data, validation_data);  
dataset.length_per_sample=size(dataset.data,1); 
dataset.feature_number=size(dataset.data,2);
dataset.total_sample_number=size(dataset.data,3);  
dataset.feature_name={}; 

dataset.number_of_class=number_of_class; 
dataset.target_value=cat(1,training_target(:), validation_data(:)); 
dataset.type=type;

dataset.training_set_ratio=0;
dataset.training_data=training_data;
dataset.target_value_for_training=training_target;
dataset.spike_state_for_training=[];
dataset.training_time_length=training_time_length;
dataset.sample_amount_for_training=length(training_target);
dataset.training_sample_id=[];

dataset.validation_data=validation_data;
dataset.target_value_for_validation=validation_target;
dataset.spike_state_for_validation=[];
dataset.validation_time_length=validation_time_length;
dataset.sample_amount_for_validation=length(validation_target); 
dataset.predict_value_for_validation=[];

dataset.encoding.method=1;
dataset.encoding.spike_threshold=0.5;
dataset.encoding.window_size=5;
dataset.encoding.filter_type=1;