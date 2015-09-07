function setbtn(hObject,handles)
if get(hObject,'value')==1
    set(handles.crossover_function_pop,'enable','off');
    set(handles.selection_function_pop,'enable','off');
    set(handles.population_size_edit,'enable','off');
    set(handles.crossover_fraction_edit,'enable','off');
    set(handles.generation_number_edit,'enable','off');
    set(handles.elite_count_edit,'enable','off');
elseif get(hObject,'value')==2
    set(handles.crossover_function_pop,'enable','on');
    set(handles.selection_function_pop,'enable','on');
    set(handles.population_size_edit,'enable','on');
    set(handles.crossover_fraction_edit,'enable','on');
    set(handles.generation_number_edit,'enable','on');
    set(handles.elite_count_edit,'enable','on');
elseif get(hObject,'value')==3
    set(handles.crossover_function_pop,'enable','off');
    set(handles.selection_function_pop,'enable','off');
    set(handles.population_size_edit,'enable','off');
    set(handles.crossover_fraction_edit,'enable','off');
    set(handles.generation_number_edit,'enable','off');
    set(handles.elite_count_edit,'enable','off');
    msgbox('Coming in the future!');
end