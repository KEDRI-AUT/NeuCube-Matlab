function [ deltaw ] = STDP( pre_spike,post_spike,STDP_learning_rate)
%STDP Summary of this function goes here
%STDP function should be called every time a neuron receives(presynaptic)
%or generates(post synaptic) a spike
%STDP receives 3 parameters:
%   PRE_SPIKE: It is the binary vector of size n specifying the presynaptic
%   spike history of the neuron. The last element signifies a spike/no
%   spike at current timepoint t, second last element signifies a spike/no
%   spike at t-1 and so on.
%   POST_SPIKE:It is a binary vector of size n specifying the post synaptic
%   spike history. The last element signifies a spike/no
%   spike at current timepoint t, second last element signifies a spike/no
%   spike at t-1 and so on.
%   STDP_learning_rate: It is a hyperparameter to control the bounds of
%   deltaw. 
%   The function is slower for larger value of n
%STDP generates 1 parameter:
%   DELTAW: it is the change of connection weight between pre and post
%   synaptic neuron
%   UPDATE: w(t)=w(t-1)+deltaw;
pre_spike_energy=0;
post_spike_energy=0;
%%calculation of LTD
time_of_spike=size(pre_spike,2); %%defines the length of historical spikes, the algorithm looks into for calculation of weight update

if(pre_spike(1,time_of_spike)==1)
 
    for i=1:time_of_spike
        if(post_spike(1,i)==1)
            post_spike_energy=post_spike_energy+energy_function((time_of_spike-i),STDP_learning_rate);
        end
    end
end
%%calculation of LTP
if(post_spike(1,time_of_spike)==1)

    for i=1:time_of_spike
        if(pre_spike(1,i)==1)
            pre_spike_energy=pre_spike_energy+energy_function((time_of_spike-i),STDP_learning_rate);
        end
    end
end
deltaw=pre_spike_energy-post_spike_energy;
end

