function [training_sets, validation_sets]=partition_CV_dataset(dataset, fold_number)
training_sets=[];
validation_sets=[];
if isempty(dataset.data)
    msgbox('Please load data set first');
    return;
end
total_sample_number=dataset.total_sample_number;
target_value=dataset.target_value;
rind=randperm(total_sample_number);

training_sets=cell(fold_number);
validation_sets=cell(fold_number);
if fold_number==1 || fold_number==total_sample_number
    for k=1:fold_number
        ind=1:fold_number;
        ind(k)=[];
        training_sets{k}=ind;
        validation_sets{k}=k;
    end
else
    if dataset.number_of_class==1% regression
        Nk= floor(total_sample_number/fold_number);
        if Nk<1
            msgbox('Number of fold is too large!');
            return;
        end
        for k=1:fold_number-1
            tind=rind;
            tind((k-1)*Nk+1:k*Nk)=[];
            training_sets{k}=tind;
            validation_sets{k}=rind((k-1)*Nk+1:k*Nk);
        end
        k=k+1;
        tind=rind;
        tind(k*Nk+1:end)=[];
        training_sets{k}=tind;
        validation_sets{k}=rind((k-1)*Nk+1:end);
    else %classification
        
        class_label=target_value(:);
        labelset=unique(class_label);
        number_of_class=length(labelset);
        for k=1:fold_number-1 
            tind=[];
            for c=1:number_of_class
                label=labelset(c);
                L=class_label==label;
                N=sum(L);
                Nk=floor(N/fold_number);
                if Nk<1
                    msgbox('Number of fold is too large!');
                    return;
                end
                
                class_ind=find(L);
                index = randperm(numel(class_ind));
                class_ind = class_ind(index);
                tind=cat(1,tind, class_ind((k-1)*Nk+1:k*Nk));
            end
            
            
            %training_sets{k}=tind;
            validation_sets{k}=tind;
            
            L=false(length(class_label),1);
            L(tind)=true;
            %validation_sets{k}=find(~L);
            training_sets{k}=find(~L);
        end
        k=k+1;
        tind=[];
        for c=1:number_of_class
            label=labelset(c);
            L=class_label==label;
            N=sum(L);
            Nk=floor(N/fold_number);
            if Nk<1
                msgbox('Number of fold is too large!');
                return;
            end
            class_ind=find(L);
            tind=cat(1,tind, class_ind((k-1)*Nk+1:end));
        end
        
        %training_sets{k}=tind;
        validation_sets{k}=tind;
        
        L=false(length(class_label),1);
        L(tind)=true;
        %validation_sets{k}=find(~L);
        training_sets{k}=find(~L);
    end

end