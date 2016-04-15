    if sample_amount_for_training==total_sample_number %pure training
        eeg_data_for_training=eeg_data;
        class_label_for_training=class_label;
        training_sample_id=sample_id;
    elseif sample_amount_for_training== 0% pure validation
        eeg_data_for_validation=eeg_data;
        class_label_for_validation=class_label;
         sample_amount_for_validation=total_sample_number;
    else
        idx=randperm(total_sample_number,sample_amount_for_training);
        L=false(total_sample_number,1);
        L(idx)=true;
        
        eeg_data_for_training=eeg_data(:,:,L);
        eeg_data_for_validation=eeg_data(:,:,~L);
        
        class_label_for_training=class_label(L);
        class_label_for_validation=class_label(~L);
        training_sample_id=sample_id(L);
        validation_sample_id=sample_id(~L);
        
        sample_amount_for_training=sum(L);
        sample_amount_for_validation=total_sample_number-sum(L);
    end