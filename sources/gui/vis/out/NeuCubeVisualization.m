
plot_content=get(handles.visual_content_pop, 'value');
show_weight_threshold=str2double(get(handles.show_threshold_edit,'string'));
if last_content~=plot_content || ~exist('p','var') || ~ishandle(p(1))
    if plot_content==1 || plot_content==2;
        cla(handles.cube,'reset')
        axes(handles.cube);
        
        p=plot3(200,200,200,'r.',neumid(:,1),neumid(:,2),neumid(:,3),'b.',200,200,200,'ms',200,200,200,'cs',neuinput(:,1),neuinput(:,2),neuinput(:,3),'ys','EraseMode','normal');
        %    p=plot3(200,200,200,'r.',200,200,200,'b.',200,200,200,'ms',200,200,200,'cs',200,200,200,'ys','EraseMode','normal');
        set(p(1),'MarkerSize',20);
        set(p(2),'MarkerSize',5);
        set(p(3),'MarkerFaceColor','m','MarkerSize',10);
        set(p(4),'MarkerFaceColor','c','MarkerSize',10);
        set(p(5),'MarkerFaceColor','y','MarkerSize',10);
        set(gcf,'Renderer','Painters','RendererMode','manual');
        set(gca,'DrawMode','fast','nextplot','add');
        set(text,'Interpreter','none')
        % grid on
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
        box on
        drawnow
        pause(0.1);
        
        if plot_content==2 % plot all existed edges
            hold on
            Ledges=abs(neucube_weight)>show_weight_threshold;
            [vR,vC]=find(Ledges);
            
            for k=1:length(vR)
                ii=vR(k); jj=vC(k);
                corrd1 = neuron_location(ii,:);
                corrd2 = neuron_location(jj,:);
                a = [corrd1(1) corrd2(1)];
                b = [corrd1(2) corrd2(2)];
                c = [corrd1(3) corrd2(3)];
                
                if neucube_weight(ii,jj) > 0
                    plot3(a,b,c,'b');
                end
                if neucube_weight(ii,jj) < 0
                    plot3(a,b,c,'r');
                end
            end
            hold off
            drawnow
        end
        
    end
    pause(0.1);
end

if plot_content==1   %spike
    
    neuron_state=neucube_output(m,:)'; %all neurons' state in this time tick
    Lpos=neuron_state==1; Lpos(end-input_number+1:end)=0;
    Lneg=neuron_state==-1;Lneg(end-input_number+1:end)=0;
    Lzero=neuron_state==0;Lzero(end-input_number+1:end)=0;
    
    Lpos_input=Lpos & Linput;   inputactivenum=sum(Lpos_input);   inputneuactive=neuron_location(Lpos_input,:);
    Lneg_input=Lneg & Linput ;  inputnegativenum=sum(Lneg_input); inputneunegative=neuron_location(Lneg_input,:);
    Lzero_input=Lzero & Linput; inputzeronum=sum(Lzero_input);    inputneuzero=neuron_location(Lzero_input,:);
    
    Lpos_mid=Lpos & (~Linput);              activenum=sum(Lpos_mid);          neuactive=neuron_location(Lpos_mid,:);
    Lneg_mid=(Lneg | Lzero ) & (~Linput);   negativenum=sum(Lneg_mid);        neunegative=neuron_location(Lneg_mid,:);
    if(negativenum>0)
        set(p(2),'XData',neunegative(:,1),'YData',neunegative(:,2),'ZData',neunegative(:,3));  %Blue dot, negtive or unactive neurons
    end
    
    if(activenum>0)
        set(p(1),'XData',neuactive(:,1),'YData',neuactive(:,2),'ZData',neuactive(:,3)); % Red dot, active neurons
    end
    
    if(inputactivenum>0)
        set(p(3),'XData',inputneuactive(:,1),'YData',inputneuactive(:,2),'ZData',inputneuactive(:,3)); %Magenta square, active input
    end
    if(inputnegativenum>0)
        set(p(4),'XData',inputneunegative(:,1),'YData',inputneunegative(:,2),'ZData',inputneunegative(:,3)); %Cyan square, negtive input
    end
    if(inputzeronum>0)
        set(p(5),'XData',inputneuzero(:,1),'YData',inputneuzero(:,2),'ZData',inputneuzero(:,3)); %Yellow square, zero input
    end
    
    % add legend
    if get(handles.neuron_legend_check,'value')==1 && (isempty(legend_handle) || ~ishandle(legend_handle))
        legend_handle=legend(handles.cube,'active neurons','inactive neurons','active input', 'negative input','zero input','orientation','horizontal','location','NorthOutside');
    elseif get(handles.neuron_legend_check,'value')==0 && ~isempty(legend_handle) && ishandle(legend_handle)
        delete(legend_handle);
    end
    drawnow;
    
    slowness=str2num(get(handles.update_speed_edit,'string'));
    if visual_type==1 && slowness>0
        pause(slowness)
    end
    
    if visual_type==2 %stepwise show, so block the excution. wait for click Next step buttion which calls the uiresume
        uiwait
    end
elseif plot_content==2
    
    Ledges_new=abs(neucube_weight)>show_weight_threshold;
    Ledges_new=xor(Ledges_new,Ledges) & Ledges_new;
    [vR,vC]=find(Ledges_new);
    Ledges = Ledges | Ledges_new;
    if ~isempty(vR)>0
        hold on
        for k=1:length(vR)
            ii=vR(k); jj=vC(k);
            corrd1 = neuron_location(ii,:);
            corrd2 = neuron_location(jj,:);
            a = [corrd1(1) corrd2(1)];
            b = [corrd1(2) corrd2(2)];
            c = [corrd1(3) corrd2(3)];
            
            if neucube_weight(ii,jj) > 0
                plot3(a,b,c,'b');
            end
            if neucube_weight(ii,jj) < 0
                plot3(a,b,c,'r');
            end
        end
        hold off
        drawnow
        
        slowness=str2num(get(handles.update_speed_edit,'string'));
        if visual_type==1 && slowness>0
            pause(slowness)
        end
        
        if visual_type==2 %stepwise show, so block the excution. wait for click Next step buttion which calls the uiresume
            uiwait
        end
    end
    
    %             end
elseif plot_content==3 %weight
    cla(handles.cube,'reset')
    %             axes(handles.axes1);
    diff_weight=neucube_weight-prev_weight;
    L1=(diff_weight>0); L1([indices_of_input_neuron indices_of_input_neuron+1],1:5)=1; L1([indices_of_input_neuron indices_of_input_neuron+1],end-4:end)=1; %indicate input position
    L2=(diff_weight<0); L2([indices_of_input_neuron indices_of_input_neuron+1],1:5)=1; L2([indices_of_input_neuron indices_of_input_neuron+1],end-4:end)=1;
    L0=(size(L1));       L0([indices_of_input_neuron indices_of_input_neuron+1],1:5)=1; L0([indices_of_input_neuron indices_of_input_neuron+1],end-4:end)=1;
    
    I1=ones(size(L1));I1(L1)=0; I1(L2)=1;
    I2=ones(size(L1));I2(L1)=0; I2(L2)=0;
    I3=ones(size(L1));I3(L1)=1; I3(L2)=0;

    Image=cat(3,I1,I2,I3);
    
    imshow(Image);
    drawnow
    
    prev_weight=neucube_weight;
    slowness=str2num(get(handles.update_speed_edit,'string'));
    if visual_type==1 && slowness>0
        pause(slowness)
    end
    
    if visual_type==2 %stepwise show, so block the excution. wait for click Next step buttion which calls the uiresume
        uiwait
    end
end


if visual_type==3
    %related with visual_type_pop_Callback
    if ~isobject(vidObj)
        slowness=str2num(get(handles.visualization_speed_edit,'string'));
        if slowness<0
            slowness=0;
        end
        [file,path] = uiputfile('*.avi','Save Workspace As',strcat('movie_',datestr(now,30),'.avi'));
        if isa(file,'double')==1
            msgbox('Cannot create video file');
            return;
        else
            vidObj = VideoWriter(strcat(path,file));
            vidObj.FrameRate=min(30,1/(slowness+eps));
            open(vidObj);
            frame_size=[];
        end
    end
    Frame = getframe(handles.cube);
    if isempty(frame_size)
        frame_size=size(Frame.cdata);
        frame_size=frame_size(1:2);
        first_time=0;
    elseif ~isequal(size(Frame.cdata),frame_size)  % while showing legend, frame size may change,so resize to the same
        Frame.cdata=imresize(Frame.cdata,frame_size);
    end
    if isobject(vidObj) && isvalid(vidObj)
        writeVideo(vidObj,Frame);
    end
elseif isobject(vidObj) && isvalid(vidObj)
    close(vidObj);
    delete(vidObj);
end
%         drawnow
last_content=plot_content;
plot_content=get(handles.visual_content_pop,'value');
