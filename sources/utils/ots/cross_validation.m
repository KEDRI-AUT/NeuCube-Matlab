function [ground_truth_label, predicted_label]=cross_validation(handles, dataset, neucube, gui_params, fold_number)
%neucube is initilized
%dataset is original data

neucube_backup=neucube;
data=dataset.data;
target_value=dataset.target_value;
total_sample_number=dataset.total_sample_number;
number_of_class=dataset.number_of_class;

if fold_number==1
    fold_number=total_sample_number;
end

training_time_length=gui_params.encoding.training_time_length;
validation_time_length=gui_params.encoding.validation_time_length;
dataset.training_time_length=floor(size(dataset.data,1)*training_time_length);
dataset.validation_time_length=floor(size(dataset.data,1)*validation_time_length);

[training_sets, validation_sets]=partition_CV_dataset(dataset, fold_number);
ground_truth_label=[];
predicted_label=[];
for k=1:fold_number

    fprintf('    %03d of %d folds...,', k,fold_number);
    
    %split dataset
    tind=training_sets{k};
    training_data=data(:,:,tind);
    training_target=target_value(tind);
    
    vind=validation_sets{k};
    validation_data=data(:,:,vind);
    validation_target=target_value(vind);
    cv_dataset=make_dataset(training_data,training_target, dataset.training_time_length, validation_data, validation_target, dataset.validation_time_length,number_of_class, dataset.type);
    
    % encoding
    cv_dataset.encoding.spike_threshold=gui_params.encoding.spike_threshold;
    cv_dataset.encoding.method=gui_params.encoding.method;
    method=gui_params.encoding.method;
    switch method
        case 1 % AER
            cv_dataset=AER_encoding(cv_dataset, false);
            cv_dataset=AER_encoding(cv_dataset, true);
        case 2 % BAS
            cv_dataset.encoding.filter_type=gui_params.encoding.filter_type;
            cv_dataset=BSA_encoding(cv_dataset,false);
            cv_dataset=BSA_encoding(cv_dataset,true);
        case 3 % Moving window
            cv_dataset.encoding.window_size=gui_params.encoding.window_size;
            cv_dataset=MW_encoding(cv_dataset,false);
            cv_dataset=MW_encoding(cv_dataset,true);
        case 4 % Foreward step
            cv_dataset=StepForward_encoding(cv_dataset,false);
            cv_dataset=StepForward_encoding(cv_dataset,true);
    end
    
    neucube=neucube_backup;
    
    neucube.training_round=gui_params.unsup.training_round;
    neucube.threshold_of_firing=gui_params.unsup.threshold_of_firing;
    neucube.refactory_time=gui_params.unsup.refactory_time;
    neucube.STDP_rate=gui_params.unsup.STDP_rate;
    neucube.potential_leak_rate=gui_params.unsup.potential_leak_rate;
    neucube.LDC_probability=gui_params.unsup.LDC_probability;
    neucube=Neucube_unsupervised(cv_dataset, neucube, handles);
    
    neucube.classifier=reset_classifier(gui_params.sup);
    neucube=Neucube_supervised(cv_dataset, neucube,handles);
    
    output_tartget_value=Neucube_verification(cv_dataset, neucube,handles);

    ground_truth_label=cat(1,ground_truth_label,validation_target(:));
    predicted_label=cat(1,predicted_label,output_tartget_value(:));
    
    if dataset.type==1
        Err=sum(output_tartget_value(:)~=validation_target(:))/length(validation_target);
        fprintf(' fold %03d finished, Error= %.02f%%!\n', k, Err*100);
    else
        %Err=sum(abs(output_tartget_value(:)-validation_target(:)))/sum(abs(validation_target));
        Err=power(sum(power(output_tartget_value(:)-validation_target(:),2))/length(validation_target),0.5);
        fprintf(' fold %03d finished, RMSE= %.02f\n', k, Err);
    end
end