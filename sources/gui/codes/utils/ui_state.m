function ui_state(handles, step, is_recall)
switch step
    case 0 
        set(handles.spike_encoding_btn,'enable','off');
        set(handles.initialize_cube_btn,'enable','off');
        set(handles.training_cube_btn,'enable','off');
        set(handles.training_classifier_btn,'enable','off');
        set(handles.verify_classifier_btn,'enable','off');
        
        set(handles.next_step_btn,'enable','off');
        set(handles.show_feature_toggle,'enable','off');
        set(handles.duplicate_figure_btn,'enable','off');
        
        set(handles.network_analysis_btn,'enable','off');
        set(handles.param_optimization_btn,'enable','off');
        set(handles.cross_validation_btn,'enable','off');
        

        set(handles.file_save_dataset,'enable','off');
        set(handles.file_save_parameters,'enable','off');
        set(handles.file_load_parameters,'enable','off');
        set(handles.file_save_neucube,'enable','off');
        set(handles.file_load_neucube,'enable','off');
        set(handles.view_show_connection,'enable','off');
        set(handles.view_activiation_level,'enable','off');
        set(handles.view_spikes_emitted,'enable','off');
        set(handles.view_neuron_weight,'enable','off');
        set(handles.options_set_parameters,'enable','off');
%         set(handles.options_export_parameters,'enable','off');
       

        set(handles.visual_type_pop,'enable','off');
        set(handles.visual_content_pop,'enable','off');
        set(handles.update_speed_edit,'enable','off');
        set(handles.show_threshold_edit,'enable','off');

    case 1

        set(handles.spike_encoding_btn,'enable','on');
        set(handles.initialize_cube_btn,'enable','off');
        set(handles.training_cube_btn,'enable','off');
        set(handles.training_classifier_btn,'enable','off');
        set(handles.verify_classifier_btn,'enable','off');
        
        set(handles.show_feature_toggle,'enable','off');
        set(handles.duplicate_figure_btn,'enable','off');
        
        set(handles.network_analysis_btn,'enable','off');
        set(handles.param_optimization_btn,'enable','off');
        set(handles.cross_validation_btn,'enable','off');
        

        set(handles.file_save_dataset,'enable','on');
        set(handles.file_save_parameters,'enable','off');
        set(handles.file_load_parameters,'enable','on');
        set(handles.file_save_neucube,'enable','off');
        set(handles.file_load_neucube,'enable','on');
         set(handles.view_show_connection,'enable','off');
        set(handles.view_activiation_level,'enable','off');
        set(handles.view_spikes_emitted,'enable','off');
        set(handles.view_neuron_weight,'enable','off');
        set(handles.options_set_parameters,'enable','on');
%         set(handles.options_export_parameters,'enable','on');
        

        set(handles.visual_type_pop,'enable','off');

        
    case 2 
        if is_recall==true
            set(handles.initialize_cube_btn,'enable','off');
            set(handles.training_cube_btn,'enable','off');
            set(handles.verify_classifier_btn,'enable','on');
        else
            set(handles.initialize_cube_btn,'enable','on');
            set(handles.training_cube_btn,'enable','off');
            set(handles.verify_classifier_btn,'enable','off');
        end
        set(handles.training_classifier_btn,'enable','off');
        
        set(handles.show_feature_toggle,'enable','off');
        set(handles.duplicate_figure_btn,'enable','off');
        

        set(handles.param_optimization_btn,'enable','off');
        set(handles.cross_validation_btn,'enable','off');
        set(handles.network_analysis_btn,'enable','off');


        set(handles.file_save_dataset,'enable','on');
        set(handles.file_save_parameters,'enable','off');
        set(handles.file_save_neucube,'enable','off');
        set(handles.view_show_connection,'enable','off');
        set(handles.view_activiation_level,'enable','off');
        set(handles.view_spikes_emitted,'enable','off');
        set(handles.view_neuron_weight,'enable','off');

        set(handles.visual_type_pop,'enable','off');
    case 3
        
        set(handles.training_cube_btn,'enable','on');
        set(handles.verify_classifier_btn,'enable','off');
        set(handles.training_classifier_btn,'enable','off');
        
        set(handles.show_feature_toggle,'enable','on');
        set(handles.duplicate_figure_btn,'enable','on');

         set(handles.param_optimization_btn,'enable','on');
         set(handles.cross_validation_btn,'enable','on');
        set(handles.network_analysis_btn,'enable','on');


        set(handles.file_save_dataset,'enable','on');
        set(handles.file_save_parameters,'enable','on');
        set(handles.file_save_neucube,'enable','on');
        set(handles.view_show_connection,'enable','on');
        set(handles.view_activiation_level,'enable','off');
        set(handles.view_spikes_emitted,'enable','off');
        set(handles.view_neuron_weight,'enable','off');

        set(handles.visual_type_pop,'enable','on');
    case 4

        set(handles.training_classifier_btn,'enable','on');
        set(handles.verify_classifier_btn,'enable','off');
        
        set(handles.show_feature_toggle,'enable','on');
        set(handles.duplicate_figure_btn,'enable','on');
        
        set(handles.network_analysis_btn,'enable','on');
        set(handles.param_optimization_btn,'enable','on');
        set(handles.cross_validation_btn,'enable','on');
        

        set(handles.file_save_dataset,'enable','on');
        set(handles.file_save_parameters,'enable','on');
        set(handles.file_save_neucube,'enable','on');
        set(handles.view_show_connection,'enable','on');
        set(handles.view_activiation_level,'enable','on');
        set(handles.view_spikes_emitted,'enable','on');
        set(handles.view_neuron_weight,'enable','on');

        set(handles.visual_type_pop,'enable','on');
    case 5 
        set(handles.verify_classifier_btn,'enable','on');
        
        set(handles.show_feature_toggle,'enable','on');
        set(handles.duplicate_figure_btn,'enable','on');
        
        set(handles.network_analysis_btn,'enable','on');
        set(handles.param_optimization_btn,'enable','on');
        set(handles.cross_validation_btn,'enable','on');

        set(handles.file_save_dataset,'enable','on');
        set(handles.file_save_parameters,'enable','on');
        set(handles.file_save_neucube,'enable','on');
        set(handles.view_show_connection,'enable','on');
        set(handles.view_activiation_level,'enable','on');
        set(handles.view_spikes_emitted,'enable','on');
        set(handles.view_neuron_weight,'enable','on');

        set(handles.visual_type_pop,'enable','on');
    case 6 
        set(handles.file_save_dataset,'enable','on');
        set(handles.file_save_parameters,'enable','on');
        set(handles.file_save_neucube,'enable','on');
        
        set(handles.view_show_connection,'enable','on');
        set(handles.view_activiation_level,'enable','on');
        set(handles.view_spikes_emitted,'enable','on');
        set(handles.view_neuron_weight,'enable','on');
    otherwise
end