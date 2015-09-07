    if mod(m,floor(spike_state_length/100)) == 0 && show_progress_bar
        if state_flag == 1 && STDP==1
            str=sprintf('Training cube, round %d..., %d%% done', round, floor(m/spike_state_length*100));
            waitbar(m/spike_state_length, hbar,str);
        elseif state_flag == 1 && STDP==0 
            str=sprintf('Processing training data..., %d%% done', floor(m/spike_state_length*100));
            waitbar(m/spike_state_length, hbar,str);
        elseif state_flag == 2
            str=sprintf('Processing validation data..., %d%% done', floor(m/spike_state_length*100));
            waitbar(m/spike_state_length, hbar,str);
        end
    end