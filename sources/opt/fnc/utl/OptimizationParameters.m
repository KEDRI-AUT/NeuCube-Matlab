best_result=1e30;
best_params=[];
best_neucube=[];
ErrMatrix=zeros(aer_threshold_len,length(small_world_radius_v),length(STDP_rate_v),length(neucube_threshold_v),length(refactory_time_v),length(time_to_train_v),length(deSNN_mod_v),length(deSNN_drift_v));
loop_num=0;
total_loop=aer_threshold_len*length(small_world_radius_v)*length(STDP_rate_v)*length(neucube_threshold_v)*length(refactory_time_v)*length(time_to_train_v)*length(deSNN_mod_v)*length(deSNN_drift_v);

gui_params=handles.gui_params;
for i_po=1:aer_threshold_len
    for j_po=1:length(small_world_radius_v)
        for k_po=1:length(STDP_rate_v)
            for l_po=1:length(neucube_threshold_v)
                for m_po=1:length(refactory_time_v)
                    for n_po=1:length(time_to_train_v)
                        for p_po=1:length(deSNN_mod_v)
                            for q_po=1:length(deSNN_drift_v)

                                gui_params2=gui_params;
                                gui_params2.encoding.spike_threshold=aer_threshold_v(i_po);
                                gui_params2.init.small_world_radius=small_world_radius_v(j_po);
                                gui_params2.unsup.training_round=floor(time_to_train_v(n_po));
                                gui_params2.unsup.STDP_rate=STDP_rate_v(k_po);
                                gui_params2.unsup.threshold_of_firing=neucube_threshold_v(l_po);
                                gui_params2.unsup.refactory_time=floor(refactory_time_v(m_po));
                                gui_params2.sup.mod=deSNN_mod_v(p_po);
                                gui_params2.sup.drift=deSNN_drift_v(q_po);
                                
                                loop_num=loop_num+1;
                                fprintf('\nRun %d with parameters:\n',loop_num);
                                fprintf('    AER  threshold:%.03f, Small world radius:%.03f,  STDP rate:%.03f,  Firing threshold:%.03f\n',gui_params2.encoding.spike_threshold,small_world_radius_v(j_po),STDP_rate_v(k_po),neucube_threshold_v(l_po));
                                fprintf('    Refactory time:%d,      Train     round:%d,      deSNN mod:%.03f,   deSNN      drift:%.03f\n',refactory_time_v(m_po),time_to_train_v(n_po),deSNN_mod_v(p_po),deSNN_drift_v(q_po));
                                
                                %init neucube
                                neucube=reset_neucube(dataset,gui_params2);
                                neucube.small_world_radius=gui_params2.init.small_world_radius;
                                neucube.input_mapping{1}=gui_params2.init.mapping_coordinate;
                                xn=gui_params2.init.neuron_number_x;
                                yn=gui_params2.init.neuron_number_y;
                                zn=gui_params2.init.neuron_number_z;
                                if  isempty(neucube.input_mapping{1})
                                    neucube=graph_matching_mapping(dataset, neucube,xn , yn, zn);
                                end
                                num=xn*yn*zn;
                                if gui_params2.init.neuron_coord_method==1
                                    neucube.neuron_location=compute_neuron_coordinate(xn,yn,zn);
                                    neucube.number_of_neucube_neural=num;
                                    neucube.is_extended=false;
                                else
                                    neucube.neuron_location=gui_params2.init.neuron_location;
                                    neucube.neuron_number_x=0;
                                    neucube.neuron_number_y=0;
                                    neucube.neuron_number_z=0;
                                    neucube.number_of_neucube_neural=size(neucube.neuron_location,1);
                                    neucube.is_extended=true;
                                end
                                neucube=Neucube_initialization(neucube);
                                
                                [ground_truth_label, predicted_label]=cross_validation(handles, dataset, neucube, gui_params2, cv_number);
                                
                                if dataset.number_of_class==1
                                    err=sum(abs(ground_truth_label-predicted_label).^2)/length(predicted_label);
                                    fprintf('MSE: %.02f\n',err);
                                else
                                    err=sum(ground_truth_label~=predicted_label)/numel(ground_truth_label);
                                    fprintf('Error: %.02f%%\n',err*100);
                                end
                                ErrMatrix(i_po,j_po,k_po,l_po,m_po,n_po,p_po,q_po)=err;
                                if  err<best_result
                                    best_result=err;
                                    best_params=gui_params2;
                                    best_neucube=neucube;
                                end

                                
                                t2=clock;
                                time_cost=etime(t2,t1);
                                str=sprintf('Total time elapsed: %.02fmin \nEstimated remaining time: %.02fmin\n',time_cost/60,(time_cost/loop_num/60)*(total_loop-loop_num));
                                output_information(str, handles);
                                fprintf('Total time elapsed: %.02fmin, Estimated remaining time: %.02fmin\n',time_cost/60,(time_cost/loop_num/60)*(total_loop-loop_num));
                                fprintf('================================ Run %d finished.  Total %d runs =============================\n',loop_num,total_loop);
                            end
                        end
                    end
                end
            end
        end
    end
end