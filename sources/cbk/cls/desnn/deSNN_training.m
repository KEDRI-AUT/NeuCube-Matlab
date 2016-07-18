function neucube=deSNN_training(dataset, neucube)        
global show_progress_bar 

classifier=neucube.classifier;
if isempty(classifier)
    msgbox('No classifier!');
end

input_dimension = neucube.number_of_neucube_neural;
length_per_sample=dataset.training_time_length;
amount_to_train = dataset.sample_amount_for_training; % 
class_label_for_training=dataset.target_value_for_training;
neucube_output_for_training=neucube.neucube_output;
mod_for_deSNN=classifier.mod;
drift=classifier.drift;
C=classifier.C;

output_neurals_PSP = zeros(1,amount_to_train);
output_neurals_weight = zeros(amount_to_train,input_dimension);
output_neurals_class_sn = ones(1,amount_to_train) * -1;
output_neurals_order = ones(amount_to_train,input_dimension) * -100; 

if show_progress_bar
    str=sprintf('Training classifier..., %d %%done',0);
    hbar=waitbar(0,str);
end
for x = 1:amount_to_train
    
    if show_progress_bar && ~ishandle(hbar)
        error('User terminated!');
        
    end
    
    order_sn = 0;
    order=[];
    
    for m = 1:length_per_sample
        for n=1:input_dimension
            if neucube_output_for_training(((x-1)*length_per_sample+m),n) == 1
                if output_neurals_order(x,n) < 0   %表示这个突触还没有spike到来过    
                    output_neurals_order(x,n) = order_sn;
                    order_sn = order_sn + 1;
                    output_neurals_weight(x,n) = mod_for_deSNN^order_sn;
                    order(end+1)=n;
                else
                    output_neurals_weight(x,n) = output_neurals_weight(x,n) + drift;
                end
                output_neurals_PSP(x) = output_neurals_PSP(x) + output_neurals_weight(x,n);
            else
                output_neurals_weight(x,n) = output_neurals_weight(x,n) - drift;
            end
        end
    end
    output_neurals_class_sn(x) = class_label_for_training(x);   %此处给输出神经元赋值所属的类序号      
    firing_order{x}=order;
    
    if show_progress_bar && ishandle(hbar)
        str=sprintf('Training classifier..., %d %%done',floor(x/amount_to_train*100));
        waitbar(x/amount_to_train,hbar,str);
    end
end

if show_progress_bar && ishandle(hbar)
    close(hbar);
end

classifier.output_neurals_train_weight=output_neurals_weight;
classifier.training_target_value=output_neurals_class_sn;
classifier.firing_order=firing_order;
classifier.output_neurals_PSP=output_neurals_PSP;

neucube.classifier=classifier;