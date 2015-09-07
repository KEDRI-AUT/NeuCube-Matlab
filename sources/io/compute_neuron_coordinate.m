function neuron_location=compute_neuron_coordinate(neuron_number_X,neuron_number_Y, neuron_number_Z)
%compute number_of_neucube_neural
% neuron_number_X=str2num(get(handles.neuron_number_X_edit,'string')); 
% neuron_number_Y=str2num(get(handles.neuron_number_Y_edit,'string')); 
% neuron_number_Z=str2num(get(handles.neuron_number_Z_edit,'string')); 
number_of_neucube_neural = neuron_number_X*neuron_number_Y*neuron_number_Z;

%compute neuron_location
neuron_location=ones(number_of_neucube_neural,3);
for z=1:neuron_number_Z
    for y=1:neuron_number_Y
        for x=1:neuron_number_X
            n=(z-1)*neuron_number_X*neuron_number_Y+(y-1)*neuron_number_X+x;
            neuron_location(n,1)=x*10;
            neuron_location(n,2)=y*10;
            neuron_location(n,3)=z*10;
        end
    end
end