function neucube=Neucube_supervised(dataset, neucube, handles)
stage=1;
STDP=0;

neucube=Neucube_updating(dataset, neucube, stage, STDP,0, handles);

flag=neucube.classifier_flag;
if flag==1 %deSNNs
    neucube=deSNN_training(dataset, neucube);
elseif flag==2 %deSNNm

end

% neucube.neucube_output=[];