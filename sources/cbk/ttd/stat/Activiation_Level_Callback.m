function Activiation_Level_Callback(hObject, eventdata, handles)
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

h=gcf;
neucube=handles.neucube;
[file,path] = uiputfile('*.csv','Save Workspace As','ActiviationLevel.csv');
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    set(h,'Pointer','watch');
    csvwrite(strcat(path,file),activity_level)
    set(h,'Pointer','arrow');
end
