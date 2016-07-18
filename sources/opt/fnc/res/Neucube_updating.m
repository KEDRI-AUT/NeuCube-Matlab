function neucube = Neucube_updating(dataset,neucube,state_flag,STDP,round,handles)
    global show_progress_bar       
    if show_progress_bar
        if (state_flag == 1) && (STDP == 1)
            str = sprintf('Training cube, round %d...', round);
            hbar = waitbar(0,str);
        elseif (state_flag == 1) && (STDP == 0)
            str = 'Processing training data...';
            hbar = waitbar(0,str);
        elseif state_flag == 2
            str = 'Processing validation data...';
            hbar = waitbar(0,str);
        end
    end

    switch state_flag
        case 1
            spike_state = dataset.spike_state_for_training;
            points_per_sample = dataset.training_time_length;
            number_of_samples = dataset.sample_amount_for_training;
            if (STDP == 1) && (neucube.LDC_probability > 0)
                input_neighbors = {};
                for inputid = 1:neucube.number_of_input
                    root_idx = neucube.indices_of_input_neuron(inputid);
                    [id_queue, rank_queue, pairs] = get_descendants(root_idx,neucube.neucube_connection,1);
                    input_neighbors{inputid}.id_queue = id_queue;
                    input_neighbors{inputid}.rank_queue = rank_queue;
                end
            end
        case 2
            spike_state = dataset.spike_state_for_validation;
            points_per_sample = dataset.validation_time_length;
            number_of_samples = dataset.sample_amount_for_validation;
    end
    
    if STDP == 1
        STDP_calculation_time_record = zeros(neucube.number_of_neucube_neural);
        STDP_rate = neucube.STDP_rate * 0.1/sqrt(neucube.training_round);       % error: should be 'round' (input variable)
    end

    if ~isempty(handles)    % extra variables for visualization module (MOSTLY REDUNDANT)
        visual_type = get(handles.visual_type_pop,'value') - 1;
        if  visual_type > 0
            global vidObj frame_size legend_handle
            number_of_neucube_neural = neucube.number_of_neucube_neural;
            neucube_weight = neucube.neucube_weight;
            prev_weight = neucube.neucube_weight;
            neucube_output = zeros(size(spike_state,1),number_of_neucube_neural);
            
            input_number = neucube.number_of_input;
            indices_of_input_neuron = neucube.indices_of_input_neuron;
            
            neuron_location = neucube.neuron_location;
            neuinput = neucube.input_mapping{1};
            neumid = neucube.neumid;           
                        
            Linput = false(number_of_neucube_neural,1);
            Linput(indices_of_input_neuron) = true;
            last_content = -1;                    
        end
    end    
    max_value_of_neucube_weight=2;
	min_value_of_neucube_weight=-2;
    % process data through Cube
    spike_transmission_vec = zeros(neucube.number_of_neucube_neural,1);
    neucube.neucube_output = zeros(size(spike_state,1),neucube.number_of_neucube_neural);
    for sample=1:number_of_samples
        %% reset the cube state after each sample    
        neucube_spike_flag = zeros(1,neucube.number_of_neucube_neural);
        neucube_last_spike_time = zeros(1,neucube.number_of_neucube_neural);
        neucube_refactory = zeros(1,neucube.number_of_neucube_neural);
        neucube_potential = zeros(1,neucube.number_of_neucube_neural);
        for point=1:points_per_sample
            time_elapse = points_per_sample*(sample-1) + point;
            %% propagate spikes: update potential states
            ind_sp = (neucube_spike_flag == 1);     % indexes of neurons which emitted a spike
            ind_re = (neucube_refactory == 0);      % indexes of neurons which are ready to increase potential (refractory == 0)           
            neucube_spike_flag(ind_sp) = 0;         % clear spike flag
            neucube_potential(ind_re) = neucube_potential(ind_re) + sum(neucube.neucube_weight(ind_sp,ind_re),1);   % update neucube potential
            % extra variables for STDP or network analysis
            neucube_last_spike_time(ind_sp) = time_elapse;                          % remember last spike time for STDP rule
            spike_transmission_vec(ind_sp) = spike_transmission_vec(ind_sp) + 1;	% used for network analysis       
            %% propagate spikes: update neuron states after the potential update 
            ind_up_thr = (neucube_potential >= neucube.threshold_of_firing);
            ind_dw_thr = (neucube_potential < neucube.threshold_of_firing);
            % update state of neurons, which have spiked
            neucube_spike_flag(ind_up_thr) = 1;
            neucube_potential(ind_up_thr) = 0;
            neucube_refactory(ind_up_thr) = neucube.refactory_time;
            % update state of neurons, which haven't spiked
            neucube_potential(ind_dw_thr) = max(0, neucube_potential(ind_dw_thr) - neucube.potential_leak_rate);    % leaking 
            neucube_refactory(ind_dw_thr) = max(0, neucube_refactory(ind_dw_thr) - 1);
            %% STDP - it is neither correct or robust implementation of STDP, should be modified and optimized for version 1.4 
            if STDP == 1
                ind_sp_stdp = find(neucube_spike_flag == 1);
                for i=ind_sp_stdp
                    for j=1:neucube.number_of_neucube_neural
                        if (neucube.neucube_connection(i,j) == 1) && (STDP_calculation_time_record(i,j) ~= neucube_last_spike_time(j))
                            STDP_calculation_time_record(i,j) = neucube_last_spike_time(j);
                            update=(neucube.neucube_weight(i,j) - STDP_rate / (time_elapse - neucube_last_spike_time(j) + 1));
                            if(update>=0)
                                neucube.neucube_weight(i,j)=min(update,max_value_of_neucube_weight);
                            else
                                neucube.neucube_weight(i,j)=max(update,min_value_of_neucube_weight);
                            end
                            %neucube.neucube_weight(i,j) = (neucube.neucube_weight(i,j) - STDP_rate / (time_elapse - neucube_last_spike_time(j) + 1));
                        elseif (neucube.neucube_connection(j,i) == 1) && (STDP_calculation_time_record(j,i) ~= neucube_last_spike_time(j))
                            STDP_calculation_time_record(j,i) = neucube_last_spike_time(j);           
                            %neucube.neucube_weight(j,i) = neucube.neucube_weight(j,i) + STDP_rate / (time_elapse - neucube_last_spike_time(j) + 1);
                            update=neucube.neucube_weight(j,i) + STDP_rate / (time_elapse - neucube_last_spike_time(j) + 1);
                            if(update>=0)
                                neucube.neucube_weight(i,j)=min(update,max_value_of_neucube_weight);
                            else
                                neucube.neucube_weight(i,j)=max(update,min_value_of_neucube_weight);
                            end
                        end
                    end
                end
                % LDC (NOT CHANGED, should be checked and maybe modified for version 1.4)
                if (neucube.LDC_probability > 0) && (time_elapse > 1)
                    prev_spk = spike_state(time_elapse-1,1:neucube.number_of_input);  
                    curr_spk = spike_state(time_elapse,1:neucube.number_of_input);
                    prev_neuron = find(prev_spk > 0);
                    curr_neuron = find(curr_spk > 0);
                    if (~isempty(prev_neuron)) && (~isempty(curr_neuron)) && (rand < neucube.LDC_probability)
                        for kk1=1:length(prev_neuron)
                            nid1 = prev_neuron(kk1);
                            id_queue1 = input_neighbors{nid1}.id_queue;
                            rank_queue1 = input_neighbors{nid1}.rank_queue;
                            for kk2=1:length(curr_neuron)
                                vIdx = find(rank_queue1 == 2); 
                                ridx = randperm(length(vIdx)); 
                                if length(ridx) < 2
                                    continue;
                                end
                                ridx=ridx(1:2);
                                neuron_idx1 = id_queue1(vIdx(ridx));      % fire first
                    
                                nid2=curr_neuron(kk2);
                                id_queue2 = input_neighbors{nid2}.id_queue;
                                rank_queue2 = input_neighbors{nid2}.rank_queue;
                    
                                vIdx = find(rank_queue2 == 2); 
                                ridx = randperm(length(vIdx)); 
                                if length(ridx) < 2
                                    continue;
                                end
                                ridx = ridx(1:2);
                                neuron_idx2 = id_queue2(vIdx(ridx)); %fire later
                    
                                A = neuron_idx1(1); B = neuron_idx2(1); 
                                C = neuron_idx1(2); D = neuron_idx2(2);
                                if (neucube.neucube_connection(A,B) == 1) && (neucube.neucube_connection(C,D) == 0) && (neucube.neucube_connection(D,C) == 0)
                                    neucube.neucube_connection(D,C) = 1;
                                    
									update=neucube.neucube_weight(A,B) + neucube.LDC_initial_weight;
									if(update>=0)
										neucube.neucube_weight(A,B)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(A,B)=max(update,min_value_of_neucube_weight);
									end
									
                                    update= neucube.neucube_weight(D,C) - neucube.LDC_initial_weight; 
									if(update>=0)
										neucube.neucube_weight(D,C)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(D,C)=max(update,min_value_of_neucube_weight);
									end
                                elseif (neucube.neucube_connection(A,B) == 0) && (neucube.neucube_connection(B,A) == 0) && (neucube.neucube_connection(C,D) == 1)
                                    neucube.neucube_connection(A,B) = 1;
                                    
									update=neucube.neucube_weight(A,B) + neucube.LDC_initial_weight;
									if(update>=0)
										neucube.neucube_weight(A,B)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(A,B)=max(update,min_value_of_neucube_weight);
									end 
                                    update= neucube.neucube_weight(D,C) - neucube.LDC_initial_weight; 
									if(update>=0)
										neucube.neucube_weight(D,C)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(D,C)=max(update,min_value_of_neucube_weight);
									end 
                                elseif (neucube.neucube_connection(A,B) == 0) && (neucube.neucube_connection(B,A) == 0) && (neucube.neucube_connection(C,D) == 0) && (neucube.neucube_connection(D,C) == 0)
                                    neucube.neucube_connection(A,B) = 1;
                                    neucube.neucube_connection(D,C) = 1;
                                    
									update=neucube.neucube_weight(A,B) + neucube.LDC_initial_weight;
									if(update>=0)
										neucube.neucube_weight(A,B)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(A,B)=max(update,min_value_of_neucube_weight);
									end
                                    update= neucube.neucube_weight(D,C) - neucube.LDC_initial_weight; 
									if(update>=0)
										neucube.neucube_weight(D,C)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(D,C)=max(update,min_value_of_neucube_weight);
									end
                                elseif (neucube.neucube_connection(B,A) == 1) && (neucube.neucube_connection(C,D) == 0) && (neucube.neucube_connection(D,C) == 0)
                                    t=A; A=C; C=t;
                                    t=B; B=D; D=t;
                                    neucube.neucube_connection(A,B) = 1;
                                    
									update=neucube.neucube_weight(A,B) + neucube.LDC_initial_weight;
									if(update>=0)
										neucube.neucube_weight(A,B)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(A,B)=max(update,min_value_of_neucube_weight);
									end 
                                    update= neucube.neucube_weight(D,C) - neucube.LDC_initial_weight; 
									if(update>=0)
										neucube.neucube_weight(D,C)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(D,C)=max(update,min_value_of_neucube_weight);
									end
                                elseif (neucube.neucube_connection(A,B) == 0) && (neucube.neucube_connection(B,A) == 0) && (neucube.neucube_connection(C,D) == 1)
                                    t=A; A=C; C=t;
                                    t=B; B=D; D=t;
                                    neucube.neucube_connection(D,C) = 1;
                                    
									update=neucube.neucube_weight(A,B) + neucube.LDC_initial_weight;
									if(update>=0)
										neucube.neucube_weight(A,B)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(A,B)=max(update,min_value_of_neucube_weight);
									end 
                                    update= neucube.neucube_weight(D,C) - neucube.LDC_initial_weight; 
									if(update>=0)
										neucube.neucube_weight(D,C)=min(update,max_value_of_neucube_weight);
									else
										neucube.neucube_weight(D,C)=max(update,min_value_of_neucube_weight);
									end
                                end
                            end
                        end
                    end
                end
            end
            %% neucube_spike_flag -> neucube_output
            neucube_spike_flag(neucube.indices_of_input_neuron) = spike_state(time_elapse,1:neucube.number_of_input);       % update inputs processing positive spikes
            neucube_spike_flag(end-neucube.number_of_input+1:end) = spike_state(time_elapse,neucube.number_of_input+1:end); % update inputs processing negative spikes
            neucube.neucube_output(time_elapse,:) = neucube_spike_flag;
            %% visualization (NOT CHANGED, should be modified for version 1.4)
            if ~isempty(handles)
                visual_type = get(handles.visual_type_pop,'value') - 1;
                if  visual_type > 0
                    m = time_elapse;
                    neucube_weight = neucube.neucube_weight;
                    neucube_output(m,:) = neucube_spike_flag;
                    %set(handles.edit5,'String',num2str(time_elapse));   % time window in GUI interface, update each time point in case of visualization (otherwise update each sample)
                    NeuCubeVisualization;                               % big external script, this part left like it was (not checked)
                end
                chkstate; % external script
            end
            %% showbar
            if (mod(time_elapse,floor(size(spike_state,1)/100)) == 0) && (show_progress_bar)
                perc_left = time_elapse/size(spike_state,1);
                waitbar(perc_left, hbar, strcat([str,', ',num2str(floor(perc_left*100)),'% done']));
            end
        end
        %set(handles.edit5,'String',num2str(time_elapse));   % time window in GUI interface, update after each sample
    end
    %% data for Network Analysis
    if ~isfield(neucube,'spike_amount')
        neucube.spike_transmission_amount = zeros(neucube.number_of_neucube_neural);
    end
    neucube.spike_transmission_amount = neucube.spike_transmission_amount + repmat(spike_transmission_vec,1,neucube.number_of_neucube_neural).*neucube.neucube_connection;

    neucube.neucube_output_visualization = neucube.neucube_output'; % REDUNDANT
    if show_progress_bar && ishandle(hbar)
        close(hbar);
    end   
end