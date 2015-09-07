if checkstate(1)==1
    aer_threshold_v=linspace(param_grid(1,1),param_grid(1,3),param_grid(1,2));
    fprintf('    AER threshold: minimum:%.03f, maximun:%.03f, step number:%d\n',param_grid(1,1),param_grid(1,3),param_grid(1,2));
    aer_threshold_len=param_grid(1,2);
else
    aer_threshold_v=dataset.encoding.spike_threshold;
    aer_threshold_len=1;
end
if checkstate(2)==1
    small_world_radius_v=linspace(param_grid(2,1),param_grid(2,3),param_grid(2,2));
    fprintf('    Connection distance: minimum:%.03f, maximun:%.03f, step number:%d\n',param_grid(2,1),param_grid(2,3),param_grid(2,2));
else
    small_world_radius_v = neucube.small_world_radius;
end
if checkstate(3)==1
    STDP_rate_v=linspace(param_grid(3,1),param_grid(3,3),param_grid(3,2));
    fprintf('    STDP rate: minimum:%.03f, maximun:%.03f, step number:%d\n',param_grid(3,1),param_grid(3,3),param_grid(3,2));
else
    STDP_rate_v = neucube.STDP_rate;
end
if checkstate(4)==1
    neucube_threshold_v=linspace(param_grid(4,1),param_grid(4,3),param_grid(4,2));
    fprintf('    Neucube Threshold: minimum:%.03f, maximun:%.03f, step number:%d\n',param_grid(4,1),param_grid(4,3),param_grid(4,2));
else
    neucube_threshold_v = neucube.threshold_of_firing;
end
if checkstate(5)==1
    refactory_time_v=linspace(param_grid(5,1),param_grid(5,3),param_grid(5,2));
    fprintf('    Refractory time: minimum:%d, maximun:%d, step number:%d\n',param_grid(5,1),param_grid(5,3),param_grid(5,2));
else
    refactory_time_v = neucube.refactory_time;
end
if checkstate(6)==1
    time_to_train_v=linspace(param_grid(6,1),param_grid(6,3),param_grid(6,2));
    fprintf('    Times to train: minimum:%d, maximun:%d, step number:%d\n',param_grid(6,1),param_grid(6,3),param_grid(6,2));
else
    time_to_train_v = neucube.training_round;
end
if checkstate(7)==1
    deSNN_mod_v=linspace(param_grid(7,1),param_grid(7,3),param_grid(7,2));
    fprintf('    deSNN mod: minimum:%.03f, maximun:%.03f, step number:%d\n',param_grid(7,1),param_grid(7,3),param_grid(7,2));
else
    deSNN_mod_v = neucube.classifier.mod;
end
if checkstate(8)==1
    deSNN_drift_v=linspace(param_grid(8,1),param_grid(8,3),param_grid(8,2));
    fprintf('    deSNN drift: minimum:%.03f, maximun:%.03f, step number:%d\n',param_grid(8,1),param_grid(8,3),param_grid(8,2));
else
    deSNN_drift_v = neucube.classifier.drift;
end
fprintf('\n');