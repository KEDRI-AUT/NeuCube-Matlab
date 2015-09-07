function [dataset, dataset_tmp]=ecd_fws(dataset,dataset_tmp,encoding_params)
dataset.encoding.method=4;
dataset.encoding.spike_threshold=encoding_params.spike_threshold;
dataset=StepForward_encoding(dataset,false);
dataset=StepForward_encoding(dataset,true);
dataset_tmp=StepForward_encoding(dataset_tmp, true);