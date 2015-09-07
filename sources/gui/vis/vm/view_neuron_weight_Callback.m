function view_neuron_weight_Callback(hObject, eventdata, handles)
global neucube_weight_befor_training
neucube_weight=handles.neucube.neucube_weight;
number_of_neucube_neural=handles.neucube.number_of_neucube_neural;
str=sprintf('Enter the neuron ID to be shown:');
prompt = {str};
dlg_title = 'NeuCube';
num_lines = 1;

def = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    return;
end

neural_sn = str2double(answer{1}); 

axes(handles.cube);
cla(handles.cube,'reset')
val1=[];
if ~isempty(neucube_weight_befor_training)
    val1=neucube_weight_befor_training(:,neural_sn);
end
val2=neucube_weight(:,neural_sn);
if ~isempty(val1)
    plot(val1);
end
hold on
plot(val2,'r');
hold off
set(gca,'xlim',[0 number_of_neucube_neural]);
xlabel('Neuron ID');
legend('before training','after training');
str=sprintf('Connection weights before training and after training between neuron %d and other neurons.',neural_sn);
output_information(str,handles);