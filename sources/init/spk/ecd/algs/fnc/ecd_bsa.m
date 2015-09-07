function [dataset, dataset_tmp]=ecd_bsa(dataset,dataset_tmp,encoding_params)
dataset.encoding.method=2;
dataset.encoding.spike_threshold=encoding_params.spike_threshold;
dataset.encoding.filter_type=encoding_params.filter_type;
dataset=BSA_encoding(dataset,false);
dataset=BSA_encoding(dataset,true);
dataset_tmp=BSA_encoding(dataset_tmp, true);