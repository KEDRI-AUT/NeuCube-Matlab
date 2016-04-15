function view_spike_raster_Callback(hObject, eventdata, handles)

global linehandles

if(~isfield(handles,'neucube'))
    msgbox('SNNcube is not trained!!')
    return
else
    if(~isfield(handles.neucube,'neucube_output'))
        msgbox('SNNcube is not trained!!')
        return
    end
end

% if isempty(neucube_connection) || isempty(neucube.neucube_output)
%     msgbox('Please train the NeuCube first');
%     return;
% end



dataset=handles.dataset;
if isempty(dataset.data)
    msgbox('Please load a dataset first');
    return;
end
neucube=handles.neucube;
neucube_weight=neucube.neucube_weight;
neucube_connection=neucube.neucube_connection;
neuron_location=neucube.neuron_location;
number_of_neucube_neural=neucube.number_of_neucube_neural;
neumid=neucube.neumid;
neuinput=neucube.input_mapping{1};
feature_names=neucube.input_mapping{2};






str=sprintf('Which sample number to be displayed [1...%d]:',dataset.total_sample_number);
prompt = {str,'Display only feature neurons? (y/n)'};
dlg_title = 'Spike Raster Settings';
num_lines = 1;

def = {'1','n'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    return;
end

output_information('Please wait for plotting...', handles);
%set(gcf,'Pointer','watch');
%drawnow
%pause(0.01);

sample_no = str2double(answer{1});

if(isempty(find(dataset.training_sample_id == sample_no)))
    msgbox(sprintf('The cube was not trained for the sample you chose (%d)\nList of trained samples:\n%s',sample_no,sprintf('%d\n',dataset.training_sample_id)));
    return;
end

all_output = neucube.neucube_output;

sample_pos = find(dataset.training_sample_id == sample_no);

a = ((sample_pos-1)*dataset.length_per_sample)+1;
b = a + dataset.length_per_sample - 1;

sample_output = all_output(a+1:b,:);
sample_output = sample_output';

spike_times = cell(size(sample_output,1),1);

for i=1:size(sample_output,1)
    this_neuron = sample_output(i,:);
    idx = find(this_neuron == 1);
    spike_times{i} = idx;
end
figure;
if(~strcmp(answer{2},'n'))
    spike_times = spike_times(neucube.indices_of_input_neuron,:);
end

plotSpikeRaster(spike_times,'PlotType','vertline','XLimForCell',[1 dataset.length_per_sample]);
xlabel('time')
ylabel('neuron id')

inputs = neucube.indices_of_input_neuron;
for i = 1:numel(inputs)
    text(dataset.length_per_sample,inputs(i),feature_names{i})
end
end
