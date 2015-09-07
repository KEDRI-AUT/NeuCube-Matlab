function [weight] = STDP_update(weight,spike_history,learning_rate )
%STDP_UPDATE Summary of this function goes here
%   Detailed explanation goes here
firing_neuron_index_j=find(spike_history(:,end));


for j=1:size(firing_neuron_index_j,1)
    neuron_index_j=firing_neuron_index_j(j,1);
    neuron_index_is=find(weight(:,neuron_index_j));
    for i=1:size(neuron_index_is,1)
        neuron_index_i=neuron_index_is(i,1);
        fired_spike_history_i=spike_history(neuron_index_i,:);
        fired_spike_history_j=spike_history(neuron_index_j,:);
        deltaw=STDP(fired_spike_history_i,fired_spike_history_j,learning_rate);
        weight(neuron_index_i,neuron_index_j)=weight(neuron_index_i,neuron_index_j)+deltaw;
        
    end
    
end


end

