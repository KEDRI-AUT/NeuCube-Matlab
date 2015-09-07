function [dataset, dataset_tmp]=ecd_aer(dataset,dataset_tmp,encoding_params)
dataset.encoding.method=1;
dataset.encoding.spike_threshold=encoding_params.spike_threshold;
dataset=AER_encoding(dataset, false);
dataset=AER_encoding(dataset, true);
dataset_tmp=AER_encoding(dataset_tmp, true);