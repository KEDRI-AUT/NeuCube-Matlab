function view_graph_Callback(hObject, eventdata, handles)

global linehandles

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

if isempty(neucube_connection)
    msgbox('Please train the NeuCube first');
    return;
end

str=sprintf('Enter the weight threshold to be shown:');
prompt = {str,'Display directional connections? (y/n)'};
dlg_title = 'Graph Settings';
num_lines = 1;

def = {'0.08','y'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    return;
end

output_information('Please wait for plotting...', handles);
set(gcf,'Pointer','watch');
drawnow
pause(0.01);

w_t=str2double(answer{1});
if w_t<0
    for k=1:length(linehandles)
        if ishandle(linehandles(k))
            delete(linehandles(k));
        end
    end
    linehandles=[];
else
    % load neural_coordinate;
    L=isinf(neucube_weight);
    neucube_weight(L)=0;
    
    %生成颜色表
    for i = 1:100
        colors(i,3) = max (0,(100-(i-1)*2)/100);
        if i <=50
            colors(i,2) = i/50;
        else
            colors(i,2) = (100-i)/50;
        end
        colors(i,1) = min(1,(i*2/100));
    end
    
    L=abs(neucube_weight)>w_t;
    if sum(L(:))==0
        msgbox('Threshold might be to large!No connection weight beyond this threshold!');
        return;
    elseif sum(L(:))>numel(L)/2
        msgbox('Number of ddges seems to be too much! Please use box render mode for quick rotation','warn');
    end
    
    % axis([-60 60 -80 60 -40 60]);
    
    % if get(handles.pushbutton18, 'value')==1 % check the button state, on or off
    % scale the survived weights between (0,1)
    neucube_weight_scale=abs(neucube_weight);
    m=min(min(neucube_weight_scale(L)));
    neucube_weight_scale=neucube_weight_scale-m;
    neucube_weight_scale(~L)=0;
    M=max(max(neucube_weight(L)));
    neucube_weight_scale=neucube_weight_scale/M;
    neucube_weight_scale(~L)=0;
    
    % discretize to scaled weights into four rank 0.25,0.5, 0.75 and 1 and maps to linewidth 1,2,2.5 and 3
    L1=L& neucube_weight_scale<0.25;
    L2=L& neucube_weight_scale>=0.25 & neucube_weight_scale<0.5;
    L3=L& neucube_weight_scale>=0.5 & neucube_weight_scale<0.75;
    L4=L& neucube_weight_scale>=0.75;
    neucube_weight_scale(L1)=1;
    neucube_weight_scale(L2)=2;
    neucube_weight_scale(L3)=2.5;
    neucube_weight_scale(L4)=3;
    
    for k=1:length(linehandles)
        if ishandle(linehandles(k))
            delete(linehandles(k));
        end
    end
    linehandles=zeros(number_of_neucube_neural*number_of_neucube_neural,1)*inf;
    n=0;
    %draw weights using different linewidth

    %This section produces the graph JSON
    actual_number_of_neurons = number_of_neucube_neural-size(neuinput,1);
    nodes = {};
    counter = 1;
    for i = 1:actual_number_of_neurons
        %for j = 1:number_of_neucube_neural
            node.id  = strcat('n',num2str(i));
            node.label = node.id;
            node.x = 100 * cos(2 * i * pi / actual_number_of_neurons);
            node.y = 100 * sin(2 * i * pi / actual_number_of_neurons);
            if(size(find(neucube.indices_of_input_neuron==i)) > 0)
                node.size = 5;
                node.color = '#00f';
                node.label = feature_names{counter};
                counter = counter + 1;
            else
                node.size = 3;
                node.color = '#000';
            end
            nodes = [nodes node];
        %end
    end
    edges = {};
    counter = 1;
    for i = 1:number_of_neucube_neural
        for j = 1:number_of_neucube_neural
            if neucube_connection(i,j) == 1 && L(i,j)
                edge.id = strcat('e',num2str(counter));
                edge.source = strcat('n',num2str(i));
                edge.target = strcat('n',num2str(j));
                edge.type = 'arrow';
                edge.size = neucube_weight_scale(i,j);
                
                if neucube_weight(i,j) > 0  % the weight of neucube after unsupervised learning using the training data
                    edge.color = '#00f';
                elseif neucube_weight(i,j) < 0
                    edge.color = '#f00';
                end
                
                edges = [edges edge];
                counter = counter + 1;
            end
        end
    end
    
    %export the graph JSON here
    opt.FileName='test.json';
    opt.ArrayIndent=1;
    opt.ArrayToStruct=0;
    %opt.opt.FloatFormat='%.2d';
    
    json_graph.nodes = nodes;
    json_graph.edges = edges;
    %json_graph.edges = {edge1,edge2};
    %%write json file
    savejson('',json_graph,opt);
    
    %This section works with graphViz4matlab
    names = {};
    nodeColors = [];
    counter = 1;
    for i = 1:actual_number_of_neurons
        %for j = 1:number_of_neucube_neural
            name  = strcat('n',num2str(i));
            if(size(find(neucube.indices_of_input_neuron==i)) > 0)
                name = feature_names{counter};
                nodeColor = [1 0.7 0];
                counter = counter + 1;
            else
                nodeColor = [0 0.5 1];
            end
            names = [names name];
            nodeColors = [nodeColors; nodeColor];
        %end
    end
    
    
    counter = 1;
    neucube_weight_abs = abs(neucube_weight);
    normA = neucube_weight_abs - min(neucube_weight_abs(:));
    neucube_weight_norm = normA ./ max(normA(:));
    for i = 1:actual_number_of_neurons
        if(size(find(neucube.indices_of_input_neuron==i)) > 0)
            from  = feature_names{counter};
            counter = counter + 1;
        else
            from  = strcat('n',num2str(i));
        end
        for j = 1:actual_number_of_neurons
            if neucube_connection(i,j) == 1 && L(i,j)
                to = strcat('n',num2str(j));
                if neucube_weight(i,j) > 0  % the weight of neucube after unsupervised learning using the training data
                    color = [neucube_weight_norm(i,j) neucube_weight_norm(i,j) 0.8];
                elseif neucube_weight(i,j) < 0
                    color = [0.8 neucube_weight_norm(i,j) neucube_weight_norm(i,j)];
                end
                temp = {from,to,color};
                if(exist('edgeColors','var'))
                    edgeColors = [edgeColors; temp];
                else
                    edgeColors = temp;
                end
            end
        end
    end
    
    adj = neucube_connection(1:actual_number_of_neurons,1:actual_number_of_neurons);
    adj = times(adj,L(1:actual_number_of_neurons,1:actual_number_of_neurons));
    graphViz4Matlab('-adjMat',adj,'-nodeLabels',names,'-layout',Treelayout,'-nodeColors',nodeColors,'-edgeColors',edgeColors);
    return;
    %copyfile('test.json','C:\Users\rhartono\Desktop\sigma.js-master\sigma.js-master\examples\data\test.json')
end
