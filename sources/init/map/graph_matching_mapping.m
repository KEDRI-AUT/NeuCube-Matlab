function neucube=graph_matching_mapping(dataset, neucube, neuron_number_X, neuron_number_Y, neuron_number_Z)
number_of_input=neucube.number_of_input;
neuron_location=compute_neuron_coordinate(neuron_number_X, neuron_number_Y, neuron_number_Z);


% randomly choose input location from the 6 face of the cube
mx=min(neuron_location(:,1)); Mx=max(neuron_location(:,1));
my=min(neuron_location(:,2)); My=max(neuron_location(:,2));
mz=min(neuron_location(:,3)); Mz=max(neuron_location(:,3));
L=neuron_location(:,1)==mx | neuron_location(:,1)==Mx | neuron_location(:,2)==my | neuron_location(:,2)==My | neuron_location(:,3)==mz | neuron_location(:,3)==Mz;
idx=find(L);
ppp = randperm(length(idx));
neuinput=neuron_location(idx(ppp(1:number_of_input)),:);


%input neurons
alpha=dataset.encoding.spike_threshold;

%variable_threshold=get_threshold(dataset,alpha);
%spike_train=signal2spike(dataset.data,variable_threshold);

spike_train=cat(1,dataset.spike_state_for_training,dataset.spike_state_for_validation);

pos_spk=spike_train(:,1:number_of_input)>0;
neg_spk=spike_train(:,1:number_of_input)<0;

N=size(pos_spk,1);
X=1:N;X=X';

p=normpdf(-5:5,0,1.5)';
pdf_pos=zeros(N,size(pos_spk,2));
for j=1:size(pos_spk,2)
    pdf=zeros(N,1);
    for i=6:N-5
        if pos_spk(i,j)==1
            pdf(i-5:i+5) = pdf(i-5:i+5)+p;
        end
    end
    pdf_pos(:,j)=pdf;
end

pdf_neg=zeros(N,size(pos_spk,2));
for j=1:size(neg_spk,2)
    pdf=zeros(N,1);
    for i=6:N-5
        if neg_spk(i,j)==1
            pdf(i-5:i+5) = pdf(i-5:i+5)+p;
        end
    end
    pdf_neg(:,j)=pdf;
end
pdf=pdf_pos-pdf_neg;

if size(neuinput,1)==3
    neuinput=[10    90    10
        10    70    20
        10    70    80];
else
    [name_ind, input_ind]=get_input_mapping(neuinput,pdf,4);

    neuinput=neuinput(input_ind,:);
    
    [~,ix]=sort(name_ind);
    neuinput=neuinput(ix,:);
end
neucube.input_mapping{1}=neuinput;