function [dataset, dataset_tmp]=ecd_mvw(dataset,dataset_tmp,encoding_params)
dataset.encoding.method=3;
dataset.encoding.spike_threshold=encoding_params.spike_threshold;
dataset.encoding.window_size=encoding_params.window_size;
dataset=MW_encoding(dataset,false);
dataset=MW_encoding(dataset,true);
dataset_tmp=MW_encoding(dataset_tmp, true);