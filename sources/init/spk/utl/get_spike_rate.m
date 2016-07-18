function rate=get_spike_rate(dataset)
if  isempty(dataset.data)
    msgbox('Please load your dataset and choose your encolding method');
end
number_of_input=dataset.feature_number;
pos_neg_spike_state=cat(1,dataset.spike_state_for_training,dataset.spike_state_for_validation);
pos_neg_spike_state=pos_neg_spike_state(:,1:number_of_input);
rate=sum(pos_neg_spike_state(:)~=0)/numel(pos_neg_spike_state);