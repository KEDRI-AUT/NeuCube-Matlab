function view_activiation_level_Callback(hObject, eventdata, handles)
neucube=handles.neucube;
neuron_location=neucube.neuron_location;
number_of_neucube_neural=neucube.number_of_neucube_neural;
neucube_output=neucube.neucube_output;

set(gcf,'pointer','watch');
drawnow
pause(0.01);
axes(handles.cube);
cla(handles.cube,'reset') 

xyz = neuron_location(1,:); 
plot3(xyz(1),xyz(2),xyz(3));
hold on

activity_level = zeros(1,number_of_neucube_neural);
for i = 1:number_of_neucube_neural
    activity_level(i) = sum(abs(neucube_output(:,i))); 
end
L=activity_level>0;

cm=colormap(copper(sum(L)));
val=activity_level(L);
neucoord=neuron_location(L,:);
[~,ix]=sort(val);

for k=1:length(val)
    xyz=neucoord(ix(k),:);
    plot3(xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor',cm(k,:),'Color',cm(k,:));
end
plot3(neuron_location(~L,1),neuron_location(~L,2),neuron_location(~L,3),'k.','Markersize',15)

xlabel('X');
ylabel('Y');
zlabel('Z');
axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);

hold off
box on
pause(0.01);


str=sprintf('Activation level of each neuron. \n- The brighter the color is, the more spikes the neuron emitts during training or validation. \n- Black represents no firing.');
output_information(str, handles);

set(gcf,'pointer','arrow');
return