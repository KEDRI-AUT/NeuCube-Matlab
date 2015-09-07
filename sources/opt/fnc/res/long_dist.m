 prev_spk=spike_state(m-1,1:input_number);  
        curr_spk=spike_state(m,1:input_number);
        
        prev_neuron=find(prev_spk>0);
        curr_neuron=find(curr_spk>0);
        
        if ~isempty(prev_neuron) && ~isempty(curr_neuron) && rand<LDCprobability
            for kk1=1:length(prev_neuron)
                nid1=prev_neuron(kk1);
                id_queue1=input_neighbors{nid1}.id_queue;
                rank_queue1=input_neighbors{nid1}.rank_queue;
                
                
                for kk2=1:length(curr_neuron)
                    vIdx=find(rank_queue1==2); 
                    ridx=randperm(length(vIdx)); 
                    if length(ridx)<2
                        continue;
                    end
                        ridx=ridx(1:2);
                    neuron_idx1=id_queue1(vIdx(ridx));      % fire first
                    
                    nid2=curr_neuron(kk2);
                    id_queue2=input_neighbors{nid2}.id_queue;
                    rank_queue2=input_neighbors{nid2}.rank_queue;
                    
                    vIdx=find(rank_queue2==2); 
                    ridx=randperm(length(vIdx)); 
                    if length(ridx)<2
                        continue;
                    end
                    ridx=ridx(1:2);
                    neuron_idx2=id_queue2(vIdx(ridx)); %fire later
                    
                    A=neuron_idx1(1); B=neuron_idx2(1); 
                    C=neuron_idx1(2); D=neuron_idx2(2);
                    if neucube_connection(A,B)==1 && neucube_connection(C,D)==0 && neucube_connection(D,C)==0
                        neucube_connection(D,C)=1;
                        neucube_weight(A,B)=neucube_weight(A,B)+LDCweight; 
                        neucube_weight(D,C)=neucube_weight(D,C)-LDCweight; 
                    elseif neucube_connection(A,B)==0 && neucube_connection(B,A)==0 && neucube_connection(C,D)==1
                        neucube_connection(A,B)=1;
                        neucube_weight(A,B)=neucube_weight(A,B)+LDCweight; 
                        neucube_weight(D,C)=neucube_weight(D,C)-LDCweight; 
                    elseif neucube_connection(A,B)==0 && neucube_connection(B,A)==0 && neucube_connection(C,D)==0 && neucube_connection(D,C)==0
                        neucube_connection(A,B)=1;
                        neucube_connection(D,C)=1;
                        neucube_weight(A,B)=neucube_weight(A,B)+LDCweight; 
                        neucube_weight(D,C)=neucube_weight(D,C)-LDCweight; 
                    elseif neucube_connection(B,A)==1 && neucube_connection(C,D)==0 && neucube_connection(D,C)==0
                        t=A; A=C; C=t;
                        t=B; B=D; D=t;
                        neucube_connection(A,B)=1;
                        neucube_weight(A,B)=neucube_weight(A,B)+LDCweight; 
                        neucube_weight(D,C)=neucube_weight(D,C)-LDCweight;
                    elseif neucube_connection(A,B)==0 && neucube_connection(B,A)==0 && neucube_connection(C,D)==1
                        t=A; A=C; C=t;
                        t=B; B=D; D=t;
                        neucube_connection(D,C)=1;
                        neucube_weight(A,B)=neucube_weight(A,B)+LDCweight; 
                        neucube_weight(D,C)=neucube_weight(D,C)-LDCweight; 
                    end
                end
            end
        end