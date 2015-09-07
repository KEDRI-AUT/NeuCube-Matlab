function output_layer_ButtonDownFcn(hObject, eventdata, handles)

if handles.classifier_visual<=0
    return;
end
if ~isfield(handles, 'neucube') || handles.neucube.step<5
    return;
end

neucube=handles.neucube;
x=neucube.classifier.x;
y=neucube.classifier.y;
if isempty(x) || isempty(y)
    return;
end

xy=[x(:) y(:)];
dr=sqrt((x(1)-x(2))^2+(y(1)-y(2))^2);
pos=get(handles.output_layer,'currentpoint');
pos=pos(1,1:2);
if pos(1)<0
    pos=[1 1];
end
d=sum((xy-repmat(pos, size(xy,1),1)).^2,2);
if min(d)>dr/2
    return;
end
idx=find(d==min(d));


set(gcf, 'pointer','watch');
drawnow
dataset=handles.dataset;
if neucube.step==5
    sample_amount=dataset.sample_amount_for_training;
    target_value=dataset.target_value_for_training;
    plot_output_layer(handles.output_layer, sample_amount, target_value, dataset.type, idx);
    output_neurals_weight=neucube.classifier.output_neurals_train_weight;
elseif neucube.step==6
    sample_amount=dataset.sample_amount_for_validation;
    target_value=dataset.predict_value_for_validation;
    plot_output_layer(handles.output_layer, sample_amount, target_value, dataset.type, idx);
    output_neurals_weight=neucube.classifier.output_neurals_test_weight;
end
number_of_neucube_neural=neucube.number_of_neucube_neural;
neuron_location=neucube.neuron_location;

axes(handles.cube);
cla('reset')
plot3(0,0,0,'w');
hold on

if handles.classifier_visual==1
    
    W=output_neurals_weight(idx,:);
    weight_sum=W;

    L=weight_sum==min(weight_sum);
    for k=1:number_of_neucube_neural
        if L(k)==true
            xyz = neuron_location(k,:); 
            plot3( xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor','k','Color','k');
        end
    end
    
    neuronID=find(~L);
    weight_sum2=weight_sum(~L);
    [~,ix]=sort(weight_sum2);
    cm=colormap(copper(length(neuronID)));
    for k=1:length(neuronID)
        xyz = neuron_location(neuronID(ix(k)),:); 
        plot3( xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor',cm(k,:),'Color',cm(k,:));
    end
    
elseif handles.classifier_visual==2
    for k=1:number_of_neucube_neural
        xyz = neuron_location(k,:); 
        plot3( xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor','k','Color','k');
    end
    firing_order=neucube.classifier.firing_order;
    order=firing_order{idx}; 
    order=max(order)-order+1;
    cm=colormap(gray(length(order)));
    for k=1:length(order)
        xyz = neuron_location(order(k),:);
        plot3( xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor',cm(k,:),'Color',cm(k,:));
    end
    
elseif handles.classifier_visual==3
    dataset=handles.dataset;
    neucube=handles.neucube;
    if neucube.step==5
        sample_amount=dataset.sample_amount_for_training;
    elseif neucube.step==6
        sample_amount=dataset.sample_amount_for_validation;
    end
    target_value=handles.neucube.classifier.output_neurals_PSP;
    if isempty(target_value)
        return
    end
    plot_output_layer(handles.output_layer, sample_amount, target_value, 2, [], true);

    output_neurals_PSP=neucube.classifier.output_neurals_PSP;
    sample_amount=dataset.sample_amount_for_training;
    L=output_neurals_PSP==0;
    for k=1:sample_amount
        if L(k)==true
            xyz = neuron_location(k,:);
            plot3( xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor','k','Color','k');
        end
    end
    
    neuronID=find(~L);
    output_neurals_PSP2=output_neurals_PSP(~L);
    [~,ix]=sort(output_neurals_PSP2);
    cm=colormap(copper(length(neuronID)));
    for k=1:length(neuronID)
        xyz = neuron_location(neuronID(ix(k)),:);
        plot3( xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor',cm(k,:),'Color',cm(k,:));
    end
    output_information('Brighter neuron means larger post synaptic potential.', handles);
end
box on
xlabel('X');
ylabel('Y');
zlabel('Z');
axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
% axis([-60 60 -80 60 -40 60]);
hold off
set(gcf,'pointer','arrow');