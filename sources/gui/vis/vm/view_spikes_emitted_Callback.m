function view_spikes_emitted_Callback(hObject, eventdata, handles)
neucube=handles.neucube;
neucube_output=neucube.neucube_output;
number_of_neucube_neural=neucube.number_of_neucube_neural;
activity_level_pos = zeros(1,number_of_neucube_neural);
activity_level_neg = zeros(1,number_of_neucube_neural);
for i = 1:number_of_neucube_neural
    activity_level_pos(i) = sum(neucube_output(:,i)>0); 
    activity_level_neg(i) = sum(neucube_output(:,i)<0);
end

axes(handles.cube);
cla(handles.cube,'reset') 
L=activity_level_pos==0;
activity_level_pos(L)=nan;
stem(activity_level_pos,'b.');
hold on
L=activity_level_neg==0;
activity_level_neg(L)=nan;
stem(-activity_level_neg,'r.');
hold off
legend('Positive spikes','Negative spikes');
xlabel('Neuron ID');
ylabel('Spikes number');
grid on
set(gca,'xlim',[0 number_of_neucube_neural]);
str=sprintf('Positive spike and negative spike amount emitted by each neuron.');
output_information(str,handles);