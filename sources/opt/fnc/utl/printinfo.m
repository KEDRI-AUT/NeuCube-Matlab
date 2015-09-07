global best_neucube best_params best_result
result=best_result; neucube=best_neucube; gui_params=best_params;
fprintf('\nLowest Error: %.02f\n',best_result);
fprintf('    AER  threshold:%.03f,    Small world radius:%.03f,    STDP rate:%.03f,  Firing threshold:%.03f\n',best_params.encoding.spike_threshold, best_params.init.small_world_radius, best_params.unsup.STDP_rate, best_params.unsup.threshold_of_firing);
fprintf('    Refractory time:%.03f,    Train     round:%.03f,    deSNN mod:%.03f,  deSNN      drift:%.03f\n',best_params.unsup.refactory_time, best_params.unsup.training_round, best_params.sup.mod, best_params.sup.drift);
set(gcf,'pointer','arrow');save(strcat('Best_result',datestr(now,30)),'result','gui_params','neucube');
