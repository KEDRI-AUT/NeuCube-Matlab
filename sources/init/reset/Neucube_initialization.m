function neucube=Neucube_initialization(neucube)
global show_progress_bar 
SWR=neucube.small_world_radius*10;
number_of_input=neucube.number_of_input;
neuinput=neucube.input_mapping{1};
number_of_neucube_neural=neucube.number_of_neucube_neural;
neuron_location=neucube.neuron_location;
if number_of_input<=0
    error('Please link this neucube to a valid data set!');
end
if isempty(neuinput)
    error('No input mapping!');
end

%find the index of each input neuron
indices_of_input_neuron=ones(number_of_input,1)*-1;
for k=1:size(neuinput,1)
    coord=neuinput(k,:);

    L=ismember(neuron_location,coord,'rows');

    idx=find(L);
    if ~neucube.is_extended && (isempty(idx) || length(idx)>1)
        error('Some input coordinates are incorrect or repeated!');
    end
    idx=sort(idx);
    indices_of_input_neuron(k)=idx(1);
end
indices_of_input_neuron(indices_of_input_neuron==-1)=[];
if length(unique(indices_of_input_neuron))<number_of_input || min(indices_of_input_neuron)<1 || max(indices_of_input_neuron)>number_of_neucube_neural
    error('Some input coordinates are incorrect or repeated!');
end

%find neurons in the middle
L=ismember(neuinput,neuron_location,'rows');
if sum(L)~=size(neuinput,1)
    error('Some of the coordinates of the input neurons are incorrect');
end
L=ismember(neuron_location,neuinput,'rows');
neumid=neuron_location(~L,:);

% add extra neurons at the end, which receives the inhibitate spikes
if ~neucube.is_extended
    neuron_location=cat(1,neuron_location,neuinput);  
    number_of_neucube_neural=number_of_neucube_neural+size(neuinput,1);
    neucube.is_extended=true;
end

neudistance=L2_distance(neuron_location', neuron_location');  %distance between neurons
L=neudistance==0;
neudistance_inv=1./neudistance;
neudistance_inv(L)=0;


%20 percent of the weight is positive number, and 80 percent is negative
neucube_weight = sign(rand(number_of_neucube_neural)-0.2).*rand(number_of_neucube_neural).*neudistance_inv;
neucube_connection = ones(number_of_neucube_neural);
choice=randi(2,number_of_neucube_neural)-1;

distancethreshold = SWR;

aaa=number_of_neucube_neural-number_of_input+1;

LL=false(number_of_neucube_neural,1);
LL(indices_of_input_neuron)=true;

if show_progress_bar
    hbar=waitbar(0,'Initializing NeuCube...');
end

for i =1:number_of_neucube_neural
    for j = 1:number_of_neucube_neural
        
        if neudistance(i,j)>distancethreshold || j>= aaa || LL(j) 
            neucube_connection(i,j)=0;
        elseif neucube_connection(i,j)==1 && neucube_connection(j,i)==1
                if choice(i,j) == 1
                    neucube_connection(i,j) = 0;
                else
                    neucube_connection(j,i)=0;            
                end
        end
         neucube_weight(i,j)=neucube_connection(i,j)*neucube_weight(i,j);
         if i>=aaa
                 neucube_weight(i,j) = 0;
         elseif LL(i) 
                neucube_weight(i,j) = 2*abs(neucube_weight(i,j));
         end
        
    end
    if show_progress_bar
        if ~ishandle(hbar)
            error('User terminated!');
        end
        if mod(i,20)==0
            hbar=waitbar(i/number_of_neucube_neural,hbar);
        end
    end
end
if show_progress_bar && ishandle(hbar)
    close(hbar);
end

%find the adjacent neightbors of each input neuron, kept for LDC learning
input_neighbors={};
for inputid=1:number_of_input
    root_idx=indices_of_input_neuron(inputid);
    [id_queue, rank_queue, pairs]=get_descendants(root_idx, neucube_connection, 1);
    input_neighbors{inputid}.id_queue=id_queue;
    input_neighbors{inputid}.rank_queue=rank_queue;
end

neucube.neuron_location=neuron_location;
neucube.number_of_neucube_neural=number_of_neucube_neural;
neucube.neumid=neumid;
neucube.indices_of_input_neuron=indices_of_input_neuron;
neucube.neucube_weight=neucube_weight;
neucube.neucube_connection=neucube_connection;
neucube.input_neighbors=input_neighbors;
