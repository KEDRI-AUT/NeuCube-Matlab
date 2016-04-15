function [dataset, dataset_tmp]=ecd_aer(dataset,dataset_tmp,encoding_params)
dataset.encoding.method=1;
dataset.encoding.spike_threshold=encoding_params.spike_threshold;
dataset=AER_encoding(dataset, false);
dataset=AER_encoding(dataset, true);
dataset_tmp=AER_encoding(dataset_tmp, true);

%dataset.training_data(:,1,1)
%find(dataset.spike_state_for_training((1-1)*dataset.length_per_sample+1:1*dataset.length_per_sample, 1))