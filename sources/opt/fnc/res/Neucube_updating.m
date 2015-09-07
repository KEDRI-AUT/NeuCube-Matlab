function neucube=Neucube_updating(dataset, neucube, state_flag,STDP, round, handles)

global vidObj frame_size show_progress_bar legend_handle

neuron_location=neucube.neuron_location;
neucube_connection=neucube.neucube_connection;
number_of_neucube_neural=neucube.number_of_neucube_neural;
indices_of_input_neuron=neucube.indices_of_input_neuron;
number_of_input=neucube.number_of_input;
neucube_weight=neucube.neucube_weight;
neucube_threshold=neucube.threshold_of_firing;
refactory_time=neucube.refactory_time;
neucube_leak_per_tickt=neucube.potential_leak_rate;
STDP_rate=neucube.STDP_rate*0.1/sqrt(neucube.training_round);
LDC_initial_weight=neucube.LDC_initial_weight;
LDCprobability=neucube.LDC_probability;
neuinput=neucube.input_mapping{1};
neumid=neucube.neumid;

if state_flag==1 
    spike_state=dataset.spike_state_for_training;
    length_per_sample=dataset.training_time_length;
    if STDP==1 && LDCprobability>0 
        input_neighbors={};
        for inputid=1:number_of_input
            root_idx=indices_of_input_neuron(inputid);
            [id_queue, rank_queue, pairs]=get_descendants(root_idx, neucube_connection, 1);
            input_neighbors{inputid}.id_queue=id_queue;
            input_neighbors{inputid}.rank_queue=rank_queue;
        end
    end
elseif state_flag==2
    spike_state=dataset.spike_state_for_validation;
    length_per_sample=dataset.validation_time_length;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% neucube_spike_flag = zeros(1,number_of_neucube_neural);
% neucube_last_spike_time = zeros(1,number_of_neucube_neural);
% neucube_refactory=zeros(1,number_of_neucube_neural);
% neucube_potential = zeros(1,number_of_neucube_neural);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

last_content=-1;

%cm=colormap(jet(256));
Linput=false(number_of_neucube_neural,1);
Linput(indices_of_input_neuron)=true;
input_number=number_of_input;

prev_weight=neucube_weight;
% number_of_neucube_neural = 1485;
neucube_output = zeros(size(spike_state,1),number_of_neucube_neural);
spike_state_length = size(spike_state,1);
STDP_caculation_time_record = zeros(number_of_neucube_neural,number_of_neucube_neural);
inc_count = 0;
dec_count = 0;
time_elapse = 0;

if isfield(neucube,'spike_amount')
    spike_transmission_amount=neucube.spike_amount;
else
    spike_transmission_amount=zeros(number_of_neucube_neural);
end

if show_progress_bar
    if state_flag == 1 && STDP==1
        hbar=waitbar(0,'Training cube...');
    elseif state_flag == 1 && STDP==0
        hbar=waitbar(0,'Processing training data...');
    elseif state_flag == 2
        hbar=waitbar(0,'Processing validation data...');
    end
end
for m = 1:spike_state_length  %all time frames of all patient  
    %     Neucube_update_MEX(spike_state_length,time_elapse,neucube_spike_flag,neucube_last_spike_time,neucube_connection,neucube_potential,neucube_weight,neucube_threshold,spike_state,neucube_output,m,neucube_leak_per_tickt);
    if mod(m,length_per_sample) == 1     
        neucube_spike_flag = zeros(1,number_of_neucube_neural);
        neucube_last_spike_time = zeros(1,number_of_neucube_neural);
        neucube_refactory=zeros(1,number_of_neucube_neural);
        neucube_potential = zeros(1,number_of_neucube_neural);
    end
    time_elapse = time_elapse + 1;

    for i = 1:number_of_neucube_neural
        if neucube_spike_flag(i) == 1 
            neucube_last_spike_time(i) = time_elapse;
            for j = 1:number_of_neucube_neural
                if neucube_connection(i,j)==1
                    spike_transmission_amount(i,j)=spike_transmission_amount(i,j)+1; 
                end
                if neucube_connection(i,j) == 1 && neucube_refactory(j) == 0
                    neucube_potential(j) = neucube_potential(j) + neucube_weight(i,j);
                end
            end
            neucube_spike_flag(i) = 0;
        end
    end
    %     if weight_record_flag == 1;
    %          potential_record(m) = neucube_potential(track_sn); %track the potential changes of neuron 555 during all training process
    %     end
    
    %计算所有神经元是否到达阈值,对于没有到达阈值的神经元计算电位的下降

    for i = 1:number_of_neucube_neural
        if neucube_potential(i) >= neucube_threshold %发出脉冲spike 
            neucube_potential(i) = 0;
            neucube_refactory(i) = refactory_time;
            neucube_spike_flag(i) = 1;
        else
            neucube_potential(i) = max(0, neucube_potential(i) - neucube_leak_per_tickt); 
            neucube_refactory(i) = max(0, neucube_refactory(i) - 1);  
        end
    end
    if STDP == 1
        %专门计算STDP
        for i = 1:number_of_neucube_neural
            if neucube_spike_flag(i) == 1 
                for j = 1:number_of_neucube_neural
                    if neucube_connection(i,j) == 1 && STDP_caculation_time_record(i,j) ~= neucube_last_spike_time(j)
                        STDP_caculation_time_record(i,j) = neucube_last_spike_time(j);
                        neucube_weight(i,j) = neucube_weight(i,j) - STDP_rate / (time_elapse - neucube_last_spike_time(j) + 1); 
                        dec_count = dec_count + 1; 
                    elseif neucube_connection(j,i) == 1 && STDP_caculation_time_record(j,i) ~= neucube_last_spike_time(j) 
                        STDP_caculation_time_record(j,i) = neucube_last_spike_time(j);           
                        neucube_weight(j,i) = neucube_weight(j,i) + STDP_rate / (time_elapse - neucube_last_spike_time(j) + 1); 
                        inc_count = inc_count + 1; 
                    end
                end
            end
        end
    end
    
    neucube_spike_flag(indices_of_input_neuron) = spike_state(m,1:input_number);  
    neucube_spike_flag(end-input_number+1:end)=spike_state(m,input_number+1:end);
    
    LDCweight=LDC_initial_weight;
    if LDCprobability>0 && STDP == 1 && m>1
        long_dist;
    end
    
    neucube_output(m,:)=neucube_spike_flag;
    
    if ~isempty(handles)
        visual_type=get(handles.visual_type_pop,'value')-1;
        if  visual_type >0
            NeuCubeVisualization;
        end
        chkstate;
    end
    showbar;
end

if show_progress_bar && ishandle(hbar)
    close(hbar);
end

neucube.neucube_output=neucube_output;
neucube.neucube_weight=neucube_weight;
neucube.neucube_connection=neucube_connection; 
neucube.spike_transmission_amount=spike_transmission_amount;