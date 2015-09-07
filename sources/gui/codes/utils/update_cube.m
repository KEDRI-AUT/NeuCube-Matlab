function update_cube(neucube, handles)
step=neucube.step;
neuron_location=neucube.neuron_location;
switch step
    case 2
        axes(handles.cube);
        cla('reset');
        
    case 3 % initialization
        axes(handles.cube);
        cla('reset');
        plot3(neuron_location(:,1),neuron_location(:,2),neuron_location(:,3),'k.','markersize',15);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
        box on
    case {4, 5,6} % training cube
        neumid=neucube.neumid;
        neuinput=neucube.input_mapping{1};
        axes(handles.cube);
        %     figure('color','white');
        p=plot3(200,200,200,'r.',neumid(:,1),neumid(:,2),neumid(:,3),'b.',200,200,200,'ms',200,200,200,'cs',neuinput(:,1),neuinput(:,2),neuinput(:,3),'ys','EraseMode','normal');
        %    p=plot3(200,200,200,'r.',200,200,200,'b.',200,200,200,'ms',200,200,200,'cs',200,200,200,'ys','EraseMode','normal');
        set(p(1),'MarkerSize',20); %firing neuron
        set(p(2),'MarkerSize',10); %non-firing neuron
        set(p(3),'MarkerFaceColor','m','MarkerSize',10); %positive input neuron
        set(p(4),'MarkerFaceColor','c','MarkerSize',10); %negative input neuron
        set(p(5),'MarkerFaceColor','y','MarkerSize',10); %zeros input neuron
        set(gcf,'Renderer','Painters','RendererMode','manual');
        set(gca,'DrawMode','fast','nextplot','add');
        set(text,'Interpreter','none')
        % grid on
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
        %axis([-60 60 -80 60 -40 60]);
        box on
    otherwise
        
        
        
end