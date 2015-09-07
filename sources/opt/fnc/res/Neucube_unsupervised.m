function neucube=Neucube_unsupervised(dataset, neucube, handles)

number_of_neucube_neural=neucube.number_of_neucube_neural;
training_round=neucube.training_round;
neucube.spike_transmission_amount=zeros(number_of_neucube_neural);
stage=1;
STDP=1;
for loop_time = 1:training_round
    neucube=Neucube_updating(dataset, neucube, stage, STDP,loop_time, handles);       
end
