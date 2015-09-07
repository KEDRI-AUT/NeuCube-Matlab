function view_show_connection_Callback(hObject, eventdata, handles)

global linehandles

dataset=handles.dataset;
if isempty(dataset.data)
    msgbox('Please load you dataset!');
    return;
end
neucube=handles.neucube;
neucube_weight=neucube.neucube_weight;
neucube_connection=neucube.neucube_connection;
neuron_location=neucube.neuron_location;
number_of_neucube_neural=neucube.number_of_neucube_neural;
neumid=neucube.neumid;
neuinput=neucube.input_mapping{1};

if isempty(neucube_connection)
    msgbox('Please training the NeuCube!');
    return;
end

str=sprintf('Enter the weight threshold to be shown:');
prompt = {str};
dlg_title = 'NeuCube';
num_lines = 1;

def = {'0.08'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    return;
end
output_information('Please wait for plotting...', handles);
set(gcf,'Pointer','watch');
drawnow
pause(0.01);


pause(0.01);
cla(handles.cube,'reset')
axes(handles.cube);
plot3(0,0,0,'w');
hold on;

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
    for i = 1:number_of_neucube_neural
        for j = 1:number_of_neucube_neural
            if neucube_connection(i,j) == 1 && L(i,j)
                corrd1 = neuron_location(i,:);
                corrd2 = neuron_location(j,:);
                a = [corrd1(1) corrd2(1)];
                b = [corrd1(2) corrd2(2)];
                c = [corrd1(3) corrd2(3)];
                
                if neucube_weight(i,j) > 0  % the weight of neucube after unsupervised learning using the training data
                    n=n+1;
                    linehandles(n)=plot3(a,b,c,'b','linewidth',neucube_weight_scale(i,j));
                elseif neucube_weight(i,j) < 0
                    n=n+1;
                    linehandles(n)=plot3(a,b,c,'r','linewidth',neucube_weight_scale(i,j));
                end
            end
        end
    end
end
% else
%     for k=1:length(linehandles)
%         if ishandle(linehandles(k))
%             delete(linehandles(k));
%         end
%     end
%     linehandles=[];
% end


% set(handles.show_feature_toggle,'value',0);  % because this function always refresh everything, so input features will not displayed anymore.
% show_feature_toggle_Callback(handles.show_feature_toggle, eventdata, handles);

% color neurons according to their activity level
weight_sum=zeros(size(neumid,1),1);
for i=1:size(neumid,1)
    weight_sum(i) = sum(abs(neucube_weight(i,:))) + sum(abs(neucube_weight(:,i)));
end
[~,ix]=sort(weight_sum);
cm=colormap(copper(size(neumid,1)));
for k=1:size(neumid,1)
    xyz = neumid(ix(k),:); %active level from small to large
    plot3(xyz(1),xyz(2),xyz(3),'Marker','.','Markersize',15,'MarkerFaceColor',cm(k,:),'Color',cm(k,:));
end
box on
% scatter3(neumid(:,1),neumid(:,2),neumid(:,3),15,cm);
% for i = 1:size(neumid,1)
%
%     %通过权值矩阵计算该神经元的连接活动度
%     temp_sum_weight = sum(abs(neucube_weight(i,:))) + sum(abs(neucube_weight(:,i)));
%
%     %决定其颜色
%     co = min(fix(temp_sum_weight/(max_weight*10)*100)+1,100);
%
%     corrd = neumid(i,:);
%
%     %绘制该点
%
%     plot3(corrd(1),corrd(2),corrd(3),'Marker','.','Markersize',15,'MarkerFaceColor',colors(co,:),'Color',colors(co,:));
%
% end
xlabel('X');
ylabel('Y');
zlabel('Z');
axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
% axis([-60 60 -80 60 -40 60]);
hold off
output_information(sprintf('- Blue means positive connections and red means negative connections.\n- Line thickness represents weight value. \n- A brighter neuron has stronger connections with other neurons than a darker neuron'),handles);
% if get(handles.grid_on_checkbox,'value')==0
%     grid(handles.axes1,'off');
% else
%     grid(handles.axes1,'on');
% end
% set(gcf,'Pointer','arrow');
set(gcf,'Pointer','arrow');
pause(0.01);


% LL=false(number_of_neucube_neural,1);
% LL(indices_of_input_neuron)=true;
% InputNeuron=zeros(number_of_neucube_neural,1);
% neucube_weight_scale=abs(neucube_weight);
% for k=1:number_of_neucube_neural
%     input_number=k;
%
%     n=0;
%     while LL(input_number)~=true && n<number_of_neucube_neural
%         n=n+1;
%         w=neucube_weight_scale(:,input_number);
%         L=w==max(w);
%         input_number=find(L);
%         input_number=input_number(1);
%     end
%     if LL(input_number)==true
%         InputNeuron(k)=input_number;
%     else
%         InputNeuron(k)=0;
%     end
% end
%
% figure,
% plot3(neuron_location(1,1),neuron_location(1,2),neuron_location(1,3));
% hold on
%
% indices=unique(InputNeuron);
% cm=colormap(jet(length(indices)));
% if indices(1)==0
%     cm(1,:)=[0 0 0];
% end
% for k=1:number_of_neucube_neural
%     plot3(neuron_location(k,1),neuron_location(k,2),neuron_location(k,3),'.','Markersize',15,'color',cm(InputNeuron(k)==indices,:));
% end
% t=0;