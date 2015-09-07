function classifier=reset_classifier(sup_params)
flag=sup_params.classifier_flag;% 1: deSNNs; 2: deSNNm; 3: span
if flag==1
    classifier.drift=sup_params.drift;
    classifier.mod=sup_params.mod;
    classifier.K=sup_params.K;
    classifier.sigma=sup_params.sigma;
    classifier.C=sup_params.C;
    classifier.output_neurals_weight=[]; 
    classifier.training_target_value=[];
    classifier.x=[];
    classifier.y=[];
elseif flag==2
    
end
