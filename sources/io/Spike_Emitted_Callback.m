function Spike_Emitted_Callback(hObject, eventdata, handles)
neucube=handles.neucube;
neucube_output=neucube.neucube_output;
number_of_neucube_neural=neucube.number_of_neucube_neural;
activity_level_pos = zeros(1,number_of_neucube_neural);
activity_level_neg = zeros(1,number_of_neucube_neural);
for i = 1:number_of_neucube_neural
    activity_level_pos(i) = sum(neucube_output(:,i)>0); 
    activity_level_neg(i) = sum(neucube_output(:,i)<0);
end

h=gcf;
neucube=handles.neucube;
[file,path] = uiputfile('*.csv','Save Workspace As','SpikeEmitted.csv');
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    set(h,'Pointer','watch');
    csvwrite(strcat(path,file),[activity_level_pos;activity_level_neg])
    set(h,'Pointer','arrow');
end