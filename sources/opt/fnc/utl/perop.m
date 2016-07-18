diary(strcat('optimization_log_',datestr(now,30), '.txt'));
if optool==1
    output_information('Optimization Algorithm: Grid Search',handles);
    fprintf('\nOptimization Algorithm: Grid Search\n');
    OptimizationParameters;
elseif optool==2
    output_information('Optimization Algorithm: Genetic Algorithm',handles);
    fprintf('\nOptimization Algorithm: Genetic Algorithm\n');
    set_bound;
    ga(@gaopt_process,size(param_grid,1),[],[],[],[],low_bound,up_bound,[],[],toolparams);
end
printinfo;
diary off;