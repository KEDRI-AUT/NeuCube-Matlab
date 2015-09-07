function visual_type_pop_Callback(hObject, eventdata, handles)
%related with updating function
content=get(hObject, 'value');
global vidObj frame_size
if content==1 %no visualization
    set(handles.visual_content_pop,'enable','off');
    set(handles.update_speed_edit,'enable','off');
    set(handles.save_to_movie_check,'enable','off');
    set(handles.neuron_legend_check,'enable','off');
    set(handles.next_step_btn,'enable','off');
    set(handles.show_threshold_edit,'enable','off');
    if isequal(get(gcf,'waitstatus'),'waiting')
        uiresume(gcf);
    end
elseif content==4 %save movie
    slowness=str2num(get(handles.update_speed_edit,'string'));
    if slowness<0
        slowness=0;
    end
    [file,path] = uiputfile('*.avi','Save Workspace As',strcat('movie_',datestr(now,30),'.avi'));
    if isa(file,'double')==1
        msgbox('Cannot create video file');
        set(hObject,'value',1);
        set(handles.visual_content_pop,'enable','off');
        set(handles.update_speed_edit,'enable','off');
        set(handles.save_to_movie_check,'enable','off');
        set(handles.neuron_legend_check,'enable','off');
        set(handles.next_step_btn,'enable','off');
        set(handles.show_threshold_edit,'enable','off');
        if isequal(get(gcf,'waitstatus'),'waiting')
            uiresume(gcf);
        end
        return;
    else
        vidObj = VideoWriter(strcat(path,file));
        vidObj.FrameRate=min(30,1/(slowness+eps));
        open(vidObj);
        frame_size=[];
    end
    output_information('Video in recording...',handles);
    
    set(handles.visual_content_pop,'enable','on');
    set(handles.update_speed_edit,'enable','on');
    set(handles.save_to_movie_check,'enable','on');
    set(handles.neuron_legend_check,'enable','on');
    set(handles.next_step_btn,'enable','on');
    set(handles.show_threshold_edit,'enable','on');
else
    set(handles.visual_content_pop,'enable','on');
    set(handles.update_speed_edit,'enable','on');
    set(handles.save_to_movie_check,'enable','on');
    set(handles.neuron_legend_check,'enable','on');
    set(handles.next_step_btn,'enable','on');
    set(handles.show_threshold_edit,'enable','on');
end
if content~=4 && isobject(vidObj) && isvalid(vidObj)
    close(vidObj);
    delete(vidObj);
    output_information('Video recording finished!',handles);
end