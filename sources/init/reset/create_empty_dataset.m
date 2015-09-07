function dataset=create_empty_dataset()
dataset.file_name=''; 
dataset.data=[];  
dataset.length_per_sample=0; 
dataset.feature_number=0;
dataset.total_sample_number=0;  
dataset.feature_name={}; 

dataset.number_of_class=0; %1 for regress; >=2 for classification
dataset.target_value=[]; %empty if recall
dataset.type=[]; %1 for classificaton, 2 for regression, 3 for recall

dataset.training_set_ratio=0.5;
dataset.training_data=[];
dataset.target_value_for_training=[];
dataset.spike_state_for_training=[];
dataset.training_time_length=0;
dataset.sample_amount_for_training=0;
dataset.training_sample_id=[];

dataset.validation_data=[];
dataset.target_value_for_validation=[];
dataset.spike_state_for_validation=[];
dataset.validation_time_length=0;
dataset.sample_amount_for_validation=0; 
dataset.predict_value_for_validation=[];

dataset.encoding.method=1;
dataset.encoding.spike_threshold=0.5;
dataset.encoding.window_size=5;
dataset.encoding.filter_type=1;