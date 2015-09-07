function [ matlab_cube ] = json2m_cube( cube )
%JSON2M_CUBE Summary of this function goes here
%   Detailed explanation goes here
    if(isfield(cube.structure,'neuron_count'))
        neuron_count=cube.structure.neuron_count;
    end
    if(isfield(cube.structure,'input_neuron_count'))
        input_neuron_count=cube.structure.input_neuron_count;
    end
    if(isfield(cube.structure,'spike_state_count'))
        spike_state_count=cube.structure.spike_state_count;
    end
    %%convert the json cube cell structure to matrix structure
    if(isfield(cube.classifier,'output_neurals_weight'))
        cube.classifier.output_neurals_weight=cell2mat(cube.classifier.output_neurals_weight);
    end
    if(isfield(cube.classifier,'training_target_value'))
        cube.classifier.training_target_value=cell2mat(cube.classifier.training_target_value);
    end
    if(isfield(cube.classifier,'x'))
        cube.classifier.x=cell2mat(cube.classifier.x);
    end
    if(isfield(cube.classifier,'y'))
        cube.classifier.y=cell2mat(cube.classifier.y);
    end
    if(isfield(cube.classifier,'output_neurals_PSP'))
        cube.classifier.output_neurals_PSP=cell2mat(cube.classifier.output_neurals_PSP);
    end
  
        if(~isempty(neuron_count))
            if(isfield(cube.structure,'neuron_location'))
                if(~isempty(cube.structure.neuron_location))
                    cube.structure.neuron_location=reshape(cell2mat(cube.structure.neuron_location),3,neuron_count)';
                else
                    cube.structure.neuron_location={}; 
                end
            end
            if(isfield(cube.structure,'connection_matrix'))
                if(~isempty(cube.structure.connection_matrix))
                    cube.structure.connection_matrix=reshape(cell2mat(cube.structure.connection_matrix),neuron_count,neuron_count)';
                else
                    cube.structure.connection_matrix={};
                end
            end
            if(isfield(cube.structure,'weight_matrix'))
                if(~isempty(cube.structure.weight_matrix))
                    cube.structure.weight_matrix=reshape(cell2mat(cube.structure.weight_matrix)',neuron_count,neuron_count)';
                else
                    cube.structure.weight_matrix={};
                end
            end
            if(isfield(cube.structure,'spike_transmission_amount'))
                if(~isempty(cube.structure.spike_transmission_amount))
                    cube.structure.spike_transmission_amount=reshape(cell2mat(cube.structure.spike_transmission_amount),neuron_count,neuron_count)';
                else
                    cube.structure.spike_transmission_amount={};
                end
            end
            if(isfield(cube.structure,'spike_states'))
                if(~isempty(cube.structure.spike_states)&&~isempty(spike_state_count))
                    cube.structure.spike_states=reshape(cell2mat(cube.structure.spike_states),neuron_count,[])';
                end
            end
        end
    
    if(isfield(cube.structure,'input_indices'))
        cube.structure.input_indices=cell2mat(cube.structure.input_indices)';
    end
    if(isfield(cube.structure,'input_names'))
        cube.structure.input_names=cube.structure.input_names';
    end
    
    
    
    %%convert json cube structure to matlab cube structure
    if(isfield(cube.structure,'neuron_location'))
        matlab_cube.neuron_location=cube.structure.neuron_location;
    end
    if(isfield(cube.structure,'connection_matrix'))
        matlab_cube.neucube_connection=cube.structure.connection_matrix;
    end
    if(isfield(cube.structure,'weight_matrix'))
        matlab_cube.neucube_weight=cube.structure.weight_matrix;
    end
        %%generate input mapping 
    if(isfield(cube.structure,'neuron_location')&&isfield(cube.structure,'input_indices'))
        if(~isempty(cube.structure.neuron_location)&&~isempty(cube.structure.input_indices))    
            %[matlab_cube.neumid] = removerows(cube.structure.neuron_location,'ind',cube.structure.input_indices);
            
            [matlab_cube.neumid] = reshape(cell2mat(cube.structure.neumid),3,[])';
            %matlab_cube.input_mapping{1}=zeros(input_neuron_count,3);
        
            matlab_cube.input_mapping{1}=cube.structure.neuron_location(cube.structure.input_indices,:); 
        else
            matlab_cube.neumid={};
            matlab_cube.input_mapping{1}={};      
        end
    end
    if(isfield(cube.structure,'input_names'))
        
        matlab_cube.input_mapping{2}=cube.structure.input_names{:};
    end
    if(isfield(cube.structure,'input_indices'))
        matlab_cube.indices_of_input_neuron=cube.structure.input_indices;
    end
    if(isfield(cube,'is_extended'))
        matlab_cube.is_extended=cube.is_extended;
    end
    if(isfield(cube,'small_world_radius'))
        matlab_cube.small_world_radius=cube.small_world_radius;
    end
   
        matlab_cube.number_of_neucube_neural=neuron_count;
   
    
        matlab_cube.number_of_input=input_neuron_count;
   
    if(isfield(cube.structure,'STDP_rate'))
        matlab_cube.STDP_rate=cube.structure.STDP_rate;
    end
    if(isfield(cube.structure,'threshold_of_firing'))
        matlab_cube.threshold_of_firing=cube.structure.threshold_of_firing;
    end
    if(isfield(cube.structure,'potential_leak_rate'))
        matlab_cube.potential_leak_rate=cube.structure.potential_leak_rate;
    end
    if(isfield(cube.structure,'refactory_time'))
        matlab_cube.refactory_time=cube.structure.refactory_time;
    end
    if(isfield(cube,'LDC_probability'))
        matlab_cube.LDC_probability=cube.LDC_probability;
    end
    if(isfield(cube,'LDC_initial_weight'))
        matlab_cube.LDC_initial_weight=cube.LDC_initial_weight;
    end
    if(isfield(cube,'training_round'))
        matlab_cube.training_round=cube.training_round;
    end
    if(isfield(cube.structure,'spike_states'))
        matlab_cube.neucube_output=cube.structure.spike_states;
    end
    if(isfield(cube.structure,'spike_transmission_amount'))
        matlab_cube.spike_transmission_amount=cube.structure.spike_transmission_amount;
    end
    if(isfield(cube,'step'))
        matlab_cube.step=cube.step;
    end
    if(isfield(cube,'type'))
        matlab_cube.type=cube.type;
    end
    if(isfield(cube.classifier,'classifier_flag'))
        matlab_cube.classifier_flag=cube.classifier.classifier_flag;
    end
    if(isfield(cube.classifier,'drift'))
        matlab_cube.classifier.drift=cube.classifier.drift;
    end
    if(isfield(cube.classifier,'mod'))
        matlab_cube.classifier.mod=cube.classifier.mod;
    end
    if(isfield(cube.classifier,'K'))
        matlab_cube.classifier.K=cube.classifier.K;
    end
    if(isfield(cube.classifier,'sigma'))
        matlab_cube.classifier.sigma=cube.classifier.sigma;
    end
    if(isfield(cube.classifier,'C'))
        matlab_cube.classifier.C=cube.classifier.C;
    end
    if(isfield(cube.classifier,'output_neurals_weight')&&isfield(cube.classifier,'output_neurals_weight_dim1')&&isfield(cube.classifier,'output_neurals_weight_dim2'))
         if(~isempty(cube.classifier.output_neurals_weight))
            matlab_cube.classifier.output_neurals_weight=reshape(cell2mat(cube.classifier.output_neurals_weight),cube.classifier.output_neurals_weight_dim2,[])';
         else
            matlab_cube.classifier.output_neurals_weight=[]; 
         end
    end
    if(isfield(cube.classifier,'output_neurals_train_weight')&&isfield(cube.classifier,'output_neurals_train_weight_dim1'))
         if(~isempty(cube.classifier.output_neurals_train_weight))
            matlab_cube.classifier.output_neurals_train_weight=reshape(cell2mat(cube.classifier.output_neurals_train_weight),[],cube.classifier.output_neurals_train_weight_dim1)';
         else
            matlab_cube.classifier.output_neurals_weight=[]; 
         end
    end
    if(isfield(cube.classifier,'output_neurals_test_weight')&&isfield(cube.classifier,'output_neurals_test_weight_dim1'))
         if(~isempty(cube.classifier.output_neurals_test_weight))
            matlab_cube.classifier.output_neurals_test_weight=reshape(cell2mat(cube.classifier.output_neurals_test_weight),[],cube.classifier.output_neurals_test_weight_dim1)';
         else
            matlab_cube.classifier.output_neurals_test_weight=[]; 
         end
    end
    if(isfield(cube.classifier,'training_target_value'))
        matlab_cube.classifier.training_target_value=cube.classifier.training_target_value;
    end
    if(isfield(cube.classifier,'x'))
        matlab_cube.classifier.x=cube.classifier.x;
    end
    if(isfield(cube.classifier,'y'))
        matlab_cube.classifier.y=cube.classifier.y;
    end
    if(isfield(cube.classifier,'firing_order'))
        matlab_cube.classifier.firing_order=cube.classifier.firing_order;
    end
    if(isfield(cube.classifier,'output_neurals_PSP'))
        matlab_cube.classifier.output_neurals_PSP=cube.classifier.output_neurals_PSP;
    end
    if(isfield(cube,'input_neighbors'))
        matlab_cube.input_neighbors=cube.input_neighbors;
    end
end

