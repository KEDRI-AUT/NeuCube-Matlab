 for c=1:number_of_class
            label=labelset(c);
            L=class_label==label;
            samples_of_this_class=eeg_data(:,:,L);  % all samples of this class
            sample_id_of_this_class=sample_id(L);
            number_of_samples_this_class=sum(L);
            
            number_of_training_sample=floor(number_of_samples_this_class*training_percentage);
            number_of_validation_sample=number_of_samples_this_class-number_of_training_sample;
            
            if training_percentage==1
                training_idx=1:number_of_samples_this_class;
            elseif training_percentage==0
                validation_idx=1:number_of_samples_this_class;
            else
                idx=randperm(number_of_samples_this_class);
                training_idx=idx(1:number_of_training_sample);
                validation_idx=idx(number_of_training_sample+1:end);
            end
            
            if number_of_training_sample>0
                eeg_data_for_training=cat(3,eeg_data_for_training,samples_of_this_class(:,:,training_idx));
                class_label_for_training = [class_label_for_training ones(1,number_of_training_sample)*c];
                training_sample_id=cat(2,training_sample_id,sample_id_of_this_class(training_idx));
                
                
            end
            
            if number_of_validation_sample>0
                eeg_data_for_validation=cat(3,eeg_data_for_validation, samples_of_this_class(:,:,validation_idx));
                class_label_for_validation = [class_label_for_validation ones(1,number_of_validation_sample)*c];
                validation_sample_id=cat(2,validation_sample_id,sample_id_of_this_class(validation_idx));
            end
            
            sample_amount_for_training=sample_amount_for_training+number_of_training_sample;
            sample_amount_for_validation=sample_amount_for_validation+number_of_validation_sample;
 end
