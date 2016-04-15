function [] = show_spike_visualization( neucube,neucube_output,handles)
%SHOW_SPIKE_VISUALIZATION Summary of this function goes here
%   Detailed explanation goes here
    %global legend_handle    
    neucube.neucube_output_visualization=neucube.neucube_output_visualization';
    neucube.neucube_output=neucube.neucube_output';
    neumid=neucube.neumid;
    neuinput=neucube.input_mapping{1};
    neuron_location=neucube.neuron_location;
    %simulation_time=size(neucube.neucube_output,2);
    
    %input_number=neucube.number_of_input;
    number_of_neucube_neural=neucube.number_of_neucube_neural;
    indices_of_input_neuon=neucube.indices_of_input_neuron;
   
    
    
    Linput=false(number_of_neucube_neural,1);
    Linput(indices_of_input_neuon)=true;
    
    %for t=1:simulation_time
        %t
        cla(handles.spike_axes,'reset')
        axes(handles.spike_axes);

        p=plot3(200,200,200,'r.',neumid(:,1),neumid(:,2),neumid(:,3),'b.',200,200,200,'ms',200,200,200,'cs',neuinput(:,1),neuinput(:,2),neuinput(:,3),'ys','EraseMode','normal');
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
        %drawnow
        %pause(0.1);
        
        
        neuron_state=neucube_output; %all neurons' state in this time tick
        Lpos=neuron_state==1 ;
        %Lpos(end-input_number+1:end)=0;
        Lneg=neuron_state==-1;
        %Lneg(end-input_number+1:end)=0;
        Lzero=neuron_state==0;
        %Lzero(end-input_number+1:end)=0;
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
            set(p(4),'XData',inputneuactive(:,1),'YData',inputneuactive(:,2),'ZData',inputneuactive(:,3)); %Magenta square, active input
        end
        if(inputnegativenum>0)
            set(p(3),'XData',inputneunegative(:,1),'YData',inputneunegative(:,2),'ZData',inputneunegative(:,3)); %Cyan square, negtive input
        end
        if(inputzeronum>0)
            set(p(5),'XData',inputneuzero(:,1),'YData',inputneuzero(:,2),'ZData',inputneuzero(:,3)); %Yellow square, zero input
        end
        drawnow;
        pause(0.1)


    


end

