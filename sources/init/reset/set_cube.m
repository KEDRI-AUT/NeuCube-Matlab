function [ground_truth_label, predicted_label]=set_cube(neucube, handles, dataset, gui_params,cv_number)
neucube=Neucube_initialization(neucube);
[ground_truth_label, predicted_label]=cross_validation(handles, dataset, neucube, gui_params, cv_number);