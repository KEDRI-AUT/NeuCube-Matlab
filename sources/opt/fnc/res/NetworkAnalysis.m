function varargout = NetworkAnalysis(varargin)
% NETWORKANALYSIS MATLAB code for NetworkAnalysis.fig
%      NETWORKANALYSIS, by itself, creates a new NETWORKANALYSIS or raises the existing
%      singleton*.
%
%      H = NETWORKANALYSIS returns the handle to a new NETWORKANALYSIS or the handle to
%      the existing singleton*.
%
%      NETWORKANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NETWORKANALYSIS.M with the given input arguments.
%
%      NETWORKANALYSIS('Property','Value',...) creates a new NETWORKANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NetworkAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NetworkAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NetworkAnalysis

% Last Modified by GUIDE v2.5 13-Dec-2013 10:16:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NetworkAnalysis_OpeningFcn, ...
    'gui_OutputFcn',  @NetworkAnalysis_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NetworkAnalysis is made visible.
function NetworkAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NetworkAnalysis (see VARARGIN)

% Choose default command line output for NetworkAnalysis
global classcolor
neucube=varargin{1}.neucube;

number_of_input=neucube.number_of_input;
handles.number_of_input=neucube.number_of_input;

handles.remove_other_cluster=0;
handles.remove_other=0;
handles.output = hObject;
handles.ParentHandles=varargin{1};
set(handles.threshold_edit,'enable','off');

rng(1);
classcolor=colormap(jet(number_of_input));
ix=randperm(number_of_input);
classcolor=classcolor(ix,:);

% if exist('classcolor.mat','file')
%     load classcolor.mat
% end
% if ~exist('classcolor','var') || isempty(classcolor) || size(classcolor,1)~=number_of_input
%     classcolor=colormap(jet(number_of_input));
%     ix=randperm(number_of_input);
%     classcolor=classcolor(ix,:);
%     save('classcolor','classcolor');
% end
set(handles.display_with_popupmenu,'value',2);
set(handles.threshold_text,'string','Level number:');
set(handles.threshold_edit,'string',num2str(3));
set(handles.threshold_edit,'enable','on');
% classcolor=colormap(jet(number_of_input));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NetworkAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NetworkAnalysis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;


function weight_clustering_pushbutton_Callback(hObject, eventdata, handles)
% global length_per_sample number_of_class total_sample_number  class_labe class_label_for_training class_label_for_validation spike_state_for_training spike_state_for_validation;
% global show_visualization time_to_train STDP_rate neucube_threshold neucube_leak_per_tickt;
% global time_elapse neucube_potential neucube_last_spike_time neucube_weight neucube_spike_flag neucube_connection neucube_output neucube_output_for_training neucube_output_for_validation neucube_refactory;
% global spike_state former_neucube_weight track_sn potential_record weight_record_flag;
% global p;
% global state_flag;
% global feature_mapping spike_transmission_amount classcolor ClusterAnalysisW ClusterAnalysislabel
% global neuron_location neudistance neudistance_inv number_of_neucube_neural neuinput neumid number_of_input indices_of_input_neuron output_weight_edges edge_matrix

global classcolor
neucube=handles.ParentHandles.neucube;
number_of_input=neucube.number_of_input;
number_of_neucube_neural=neucube.number_of_neucube_neural;
neucube_weight=neucube.neucube_weight;
spike_transmission_amount=neucube.spike_transmission_amount;
indices_of_input_neuron=neucube.indices_of_input_neuron;
neuron_location=neucube.neuron_location;
neuinput=neucube.input_mapping{1};
neumid=neucube.neumid;
h=gcf;

set(h,'Pointer','watch');
pause(0.01);
input_neuron=str2num(get(handles.input_neuron_cluster_edit,'string'));
is_all_neuron=get(handles.all_input_cluster_checkbox,'value');
display_with=get(handles.display_with_cluster_popupmenu,'value');



Names=neucube.input_mapping{2};
if is_all_neuron==1
    input_neuron=1:number_of_input;
end




output_information('Performing clustering...',handles.ParentHandles);
pause(0.01);

N=number_of_neucube_neural-number_of_input;
if display_with==1 %graph edge weighted by network weight
    W=abs(neucube_weight(1:N,1:N));
elseif display_with==2%graph edge weighted by spikes communication
    W=spike_transmission_amount(1:N,1:N);
end
W=(W+W');
d=sum(W);
LL=d==0;

Dinv=diag(1./(sqrt(sum(W))+eps));
S=Dinv*W*Dinv;
Y=zeros(size(W,1),number_of_input);
for c=1:number_of_input
    Y(indices_of_input_neuron(c),c)=1;
end
F=(eye(size(W))-0.99*S)\Y;
[~,label]=max(F,[],2);

handles.ClusterAnalysisW=W;
handles.ClusterAnalysislabel=label;


axes(handles.ParentHandles.cube);
cla(handles.ParentHandles.cube,'reset')
if get(handles.remove_other_cluster_checkbox,'value')==0 || is_all_neuron==1
    plot3(neuron_location(:,1),neuron_location(:,2),neuron_location(:,3),'k.','markersize',15); %plot all neurons
else
    plot3(0,0,0);
end
hold on
for kk=input_neuron
    
    idx=indices_of_input_neuron(kk);
    plot3(neuron_location(idx,1),neuron_location(idx,2),neuron_location(idx,3),'o','markersize',15,'MarkerFaceColor',classcolor(kk,:),'Markeredgecolor',classcolor(kk,:)); %show input neuron
    text(neuinput(kk,1)+2,neuinput(kk,2)+2,neuinput(kk,3)+2,Names{kk},'color','k','FontSize',12,'FontWeight','bold'); %text feature name
    
    L=label==label(idx); % same cluster with this input neuron
    L(LL)=false;
    for k=1:N
        if L(k)==true
            plot3(neuron_location(k,1),neuron_location(k,2),neuron_location(k,3),'*','color',classcolor(kk,:),'markersize',15);
            plot3(neuron_location(k,1),neuron_location(k,2),neuron_location(k,3),'.','color',classcolor(kk,:),'markersize',15);
        end
    end
end
xlabel('X');
ylabel('Y');
zlabel('Z');
axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
box on
hold off
% set(handles.ParentHandles.tips,'string','Clustering finished.');
output_information('Clustering finished.', handles.ParentHandles);
figure(h);
guidata(hObject, handles);
% if get(handles.ParentHandles.grid_on_checkbox,'value')==0
%     grid(handles.ParentHandles.axes1,'off');
% else
%     grid(handles.ParentHandles.axes1,'on');
% end
set(h,'Pointer','arrow');
pause(0.01);

function update_pushbutton_Callback(hObject, eventdata, handles)
% global length_per_sample number_of_class total_sample_number  class_labe class_label_for_training class_label_for_validation spike_state_for_training spike_state_for_validation;
% global show_visualization time_to_train STDP_rate neucube_threshold neucube_leak_per_tickt;
% global time_elapse neucube_potential neucube_last_spike_time neucube_weight neucube_spike_flag neucube_connection neucube_output neucube_output_for_training neucube_output_for_validation neucube_refactory;
% global spike_state former_neucube_weight track_sn potential_record weight_record_flag;
% global p;
% global state_flag;
% global feature_mapping spike_transmission_amount classcolor ClusterAnalysisW ClusterAnalysislabel
% global neuron_location neudistance neudistance_inv number_of_neucube_neural neuinput neumid number_of_input indices_of_input_neuron output_weight_edges edge_matrix

global classcolor
neucube=handles.ParentHandles.neucube;
number_of_input=neucube.number_of_input;
number_of_neucube_neural=neucube.number_of_neucube_neural;
feature_mapping=neucube.input_mapping;
% neucube_weight=neucube.neucube_weight;
% spike_transmission_amount=neucube.spike_transmission_amount;
indices_of_input_neuron=neucube.indices_of_input_neuron;
neuron_location=neucube.neuron_location;
if ~isfield(handles,'ClusterAnalysisW')
    msgbox('Please perform clustering first!');
    return;
end
ClusterAnalysisW=handles.ClusterAnalysisW;
ClusterAnalysislabel=handles.ClusterAnalysislabel;
neuinput=neucube.input_mapping{1};

if isempty(ClusterAnalysisW) ||  isempty(ClusterAnalysislabel)
    msgbox('Please cluster vertex first');
    return;
end

h=gcf;

set(h,'Pointer','watch');
pause(0.01);

W=ClusterAnalysisW;
label=ClusterAnalysislabel;

axes(handles.ParentHandles.cube);
cla(handles.ParentHandles.cube,'reset')
Names=feature_mapping{2};
inputnueron=feature_mapping{1};

switch get(handles.analysisi_content_popupmenu,'value')
    case 1 % total cut between clusters
        Wcut=zeros(number_of_input);
        E=ones(size(W));
        for i=1:number_of_input
            for j=1:number_of_input
                %                 Li=double(label==i);
                %                 Lj=double(label==j);
                idxi=indices_of_input_neuron(i);
                idxj=indices_of_input_neuron(j);
                Li=label==label(idxi); % same cluster with this input neuron
                Lj=label==label(idxj); % same cluster with this input neuron
                Wcut(i,j)=Li'*W*Lj;
            end
        end
        Wcut(logical(eye(size(Wcut))))=0;
        Wcut=round(Wcut/max(Wcut(:))*min(7,number_of_input));
        
        hold on
        L = linspace(0,2.*pi,number_of_input+1);
        xv = 10*cos(L)';yv = 10*sin(L)';
        xt = 12*cos(L)';yt = 12*sin(L)';
        for i=1:number_of_input
            for j=1:number_of_input
                if Wcut(i,j)>0
                    plot([xv(i); xv(j)],[yv(i) yv(j)],'k','linewidth',Wcut(i,j));
                end
            end
        end
        
        % plot vertices
        for i=1:number_of_input
            plot(xv(i),yv(i),'o','markersize',15,'markerfacecolor',classcolor(i,:),'Markeredgecolor',classcolor(i,:));
            text(xt(i)-1.3,yt(i),Names{i},'FontSize',12,'FontWeight','bold')
        end
%         axis([-number_of_input number_of_input -number_of_input number_of_input]);
        axis off
        hold off
        title('Total interaction between input');
    case 2 % average cut between clusters
        Wcut=zeros(number_of_input);
        E=ones(size(W));
        for i=1:number_of_input
            for j=1:number_of_input
                %                 Li=double(label==i);
                %                 Lj=double(label==j);
                idxi=indices_of_input_neuron(i);
                idxj=indices_of_input_neuron(j);
                Li=label==label(idxi); % same cluster with this input neuron
                Lj=label==label(idxj); % same cluster with this input neuron
                Wcut(i,j)=Li'*W*Lj/sum(Li'*E*Lj);
            end
        end
        Wcut(logical(eye(size(Wcut))))=0;
        Wcut=Wcut/max(Wcut(:))*number_of_input;
        
        hold on
        L = linspace(0,2.*pi,number_of_input+1);
        xv = 10*cos(L)';yv = 10*sin(L)';
        xt = 12*cos(L)';yt = 12*sin(L)';
        for i=1:number_of_input
            for j=1:number_of_input
                if Wcut(i,j)>0
                    plot([xv(i); xv(j)],[yv(i) yv(j)],'k','linewidth',Wcut(i,j));
                end
            end
        end
        
        % plot vertices
        for i=1:number_of_input
            plot(xv(i),yv(i),'o','markersize',15,'markerfacecolor',classcolor(i,:),'Markeredgecolor',classcolor(i,:));
            text(xt(i)-1.3,yt(i),Names{i},'FontSize',12,'FontWeight','bold')
        end
        axis([-number_of_input number_of_input -number_of_input number_of_input]);
        axis off
        hold off
        title('Average interaction between input');
    case 3 % vertext number
        vertex_num=zeros(number_of_input,1);
        for c=1:number_of_input
            vertex_num(c)=sum(label==c);
        end
        colormap(classcolor)
        hPie=pie(vertex_num);
        hText = findobj(hPie,'Type','text');
        percentValues = get(hText,'String');
        customStrings = strcat('(',percentValues);
        customStrings = strcat(customStrings,')');
        if(size(Names,1)==1)
            Names=Names';
        end
        customStrings = strcat(Names,customStrings);
        set(hText,{'String'},customStrings);
    case 4 %plot clusters
        plot3(neuron_location(:,1),neuron_location(:,2),neuron_location(:,3),'k.','markersize',15); %plot all neurons
        hold on
        d=sum(W);
        LL=d==0;
        input_neuron=1:number_of_input;
        N=number_of_neucube_neural-number_of_input;
        for kk=input_neuron
            
            idx=indices_of_input_neuron(kk);
            plot3(neuron_location(idx,1),neuron_location(idx,2),neuron_location(idx,3),'o','markersize',15,'MarkerFaceColor',classcolor(kk,:),'Markeredgecolor',classcolor(kk,:)); %show input neuron
            text(neuinput(kk,1)+2,neuinput(kk,2)+2,neuinput(kk,3)+2,Names{kk},'color','k','FontSize',12,'FontWeight','bold'); %text feature name
            
            L=label==label(idx); % same cluster with this input neuron
            L(LL)=false;
            for k=1:N
                if L(k)==true
                    plot3(neuron_location(k,1),neuron_location(k,2),neuron_location(k,3),'*','color',classcolor(kk,:),'markersize',15);
                    plot3(neuron_location(k,1),neuron_location(k,2),neuron_location(k,3),'.','color',classcolor(kk,:),'markersize',15);
                end
            end
        end
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);
        box on
        hold off
end

figure(h);
% if get(handles.ParentHandles.grid_on_checkbox,'value')==0
%     grid(handles.ParentHandles.axes1,'off');
% else
%     grid(handles.ParentHandles.axes1,'on');
% end
set(h,'Pointer','arrow');
pause(0.01);








function Information_trace_pushbutton_Callback(hObject, eventdata, handles)
% global length_per_sample number_of_class total_sample_number  class_labe class_label_for_training class_label_for_validation spike_state_for_training spike_state_for_validation;
% global show_visualization time_to_train STDP_rate neucube_threshold neucube_leak_per_tickt;
% global time_elapse neucube_potential neucube_last_spike_time neucube_weight neucube_spike_flag neucube_connection neucube_output neucube_output_for_training neucube_output_for_validation neucube_refactory;
% global spike_state former_neucube_weight track_sn potential_record weight_record_flag;
% global p;
% global state_flag;
% global feature_mapping spike_transmission_amount classcolor
% global neuron_location neudistance neudistance_inv number_of_neucube_neural neuinput neumid number_of_input indices_of_input_neuron output_weight_edges edge_matrix

global classcolor
neucube=handles.ParentHandles.neucube;
number_of_input=neucube.number_of_input;
number_of_neucube_neural=neucube.number_of_neucube_neural;
feature_mapping=neucube.input_mapping;
% neucube_weight=neucube.neucube_weight;
spike_transmission_amount=neucube.spike_transmission_amount;
indices_of_input_neuron=neucube.indices_of_input_neuron;
neuron_location=neucube.neuron_location;
neuinput=neucube.input_mapping{1};
% ClusterAnalysisW=handles.ClusterAnalysisW;
% ClusterAnalysislabel=handles.ClusterAnalysislabel;

h=gcf;
set(h,'Pointer','watch');
pause(0.01);

if isempty(spike_transmission_amount) || sum(spike_transmission_amount(:))==0
    msgbox('Please train Neucube first');
    return;
end

% set(handles.ParentHandles.tips,'string','Performing analysis...');
output_information('Performing analysis...',handles.ParentHandles);
% if exist('classcolor.mat','file')
%     load classcolor.mat
% end
% if ~exist('classcolor','var') || isempty(classcolor) || size(classcolor,1)~=number_of_input
%     classcolor=colormap(jet(number_of_input));
%     ix=randperm(number_of_input);
%     classcolor=classcolor(ix,:);
%     save('init\classcolor','classcolor');
% end

% if isempty(classcolor) || size(classcolor,1)~=number_of_input
%     classcolor=colormap(jet(number_of_input));
%     ix=randperm(number_of_input);
%     classcolor=classcolor(ix,:);
% end
Names=feature_mapping{2};

input_neuron=str2num(get(handles.input_neuron_edit,'string'));
is_all_neuron=get(handles.all_input_checkbox,'value');
display_threshold=str2num(get(handles.threshold_edit,'string'));
display_with=get(handles.display_with_popupmenu,'value');


if is_all_neuron==1
    input_neuron=1:number_of_input;
end


axes(handles.ParentHandles.cube);
cla(handles.ParentHandles.cube,'reset')
if get(handles.remove_other_checkbox,'value')==0 || is_all_neuron==1
    plot3(neuron_location(:,1),neuron_location(:,2),neuron_location(:,3),'k.','markersize',15); %plot all neurons
else
    plot3(0,0,0);
end




if display_with==1 % max spike gradient
    N=number_of_neucube_neural-number_of_input;
    
    pathes=cell(N,1);
    rootID=zeros(N,1);
    W=spike_transmission_amount(1:N,1:N);
    
    %find path and root neuron of each one
    for k=1:N
        
        receiverID=k;

        
        path=[];
        loop=0;
        while ~any(receiverID==indices_of_input_neuron) && loop<=N %walk towards its max sender
            received_spikes=W(:,receiverID);
            M=max(received_spikes);
            if M==0
                break;
            end
            path(end+1)=receiverID;
            receiverID=find(received_spikes==M);
            receiverID=receiverID(1);
            loop=loop+1;
        end

        if length(path)>=1 && loop<=N
            path(end+1)=receiverID;
            pathes{k}=path;
            rootID(k)=receiverID;
        end
    end
    
    %plot the path
    hold on
    for kk=input_neuron
        inputID=indices_of_input_neuron(kk);
        plot3(neuron_location(inputID,1),neuron_location(inputID,2),neuron_location(inputID,3),'o','markersize',15,'MarkerFaceColor',classcolor(kk,:),'Markeredgecolor',classcolor(kk,:)); %show input neuron
        text(neuinput(kk,1)+2,neuinput(kk,2)+2,neuinput(kk,3)+2,Names{kk},'color','k','FontSize',12,'FontWeight','bold'); %text feature name
        LL=rootID==inputID;
        for k=1:N
            if LL(k)==false
                continue;
            end
            path=pathes{k};
            width=3;
            for i=length(path):-1:2
                senderID=path(i); receiverID=path(i-1);
                sender=neuron_location(senderID,:);
                receiver=neuron_location(receiverID,:);
                if width<1
                    width=1;
                end
                plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'linewidth',width,'color',classcolor(kk,:),'markersize',15); % show edge
                plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'*','color',classcolor(kk,:),'markersize',15); % show neuron by '*'
                plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'.','color',classcolor(kk,:),'markersize',15); % show neuron by '.'
                width=width-1;
            end
            
        end
    end
    
%     for k=1:N
%         if rootID(k)==0
%             
%             path=pathes{k};
%             for i=1:length(path)-1
%                 senderID=path(i); receiverID=path(i+1);
%                 sender=neuron_location(senderID,:);
%                 receiver=neuron_location(receiverID,:);
%                 plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'color','k','markersize',15); % show edge
%                 plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'*','color','k','markersize',15); % show neuron by '*'
%                 plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'.','color','k','markersize',15); % show neuron by '.'
%             end
%         end
%         
%     end
    
    
    hold off
else  % information amount or spreading level
    hold on
    N=number_of_neucube_neural-number_of_input;

    W=spike_transmission_amount(1:N,1:N);
    for kk=input_neuron
        idx=indices_of_input_neuron(kk);
        plot3(neuron_location(idx,1),neuron_location(idx,2),neuron_location(idx,3),'o','markersize',15,'MarkerFaceColor',classcolor(kk,:),'Markeredgecolor',classcolor(kk,:)); %show input neuron
        text(neuinput(kk,1)+2,neuinput(kk,2)+2,neuinput(kk,3)+2,Names{kk},'color','k','FontSize',12,'FontWeight','bold'); %text feature name
        
        n=0;
        id_queue=[];
        rank_queue=[];
        percent_queue=[];
        pairs=[]; % record index pair of a parent node and its kid node
        
        id_queue(end+1)=idx;    %start in root node, the input neuron
        rank_queue(end+1)=1;    %root rank 1
        percent_queue(end+1)=1; %has 100% information
        
        
        while n<length(id_queue)
            n=n+1; %sender's location in queue
            senderID=id_queue(n);
            
            receivers=find(W(senderID,:)>0); % all receivers
            
            for k=1:length(receivers)
                receiverID=receivers(k);
                ratio=W(senderID,receiverID)/sum(W(:,receiverID)); % percentage of the spikes received from this sender over the spikes received from all other senders
                %             ratio=spike_transmission_amount(receiverID,senderID)/sum(spike_transmission_amount(:,senderID)); % percentage of the spikes received from this sender over the spikes received from all other senders
                if ~any(receiverID==id_queue)% this receiver not in the queue
                    id_queue(end+1)=receivers(k);
                    rank_queue(end+1)=rank_queue(n)+1; % sender's level +1
                    percent_queue(end+1)=percent_queue(n)*ratio; %percent of spike information received from this input neuron
                    pairs(:,end+1)=[senderID;receiverID];
                    %                 if (display_with==1 && percent_queue(end)>display_threshold) || (display_with==2 && rank_queue(end)<=display_threshold)% info amount
                    %                     sender=neuron_location(senderID,:);
                    %                     receiver=neuron_location(receiverID,:);
                    %                     plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'color',classcolor(kk,:),'linewidth',2,'markersize',15); % show edge
                    %                     plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'*','color',classcolor(kk,:),'markersize',15); % show neuron
                    %                     plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'.','color',classcolor(kk,:),'markersize',15); % show neuron
                    %                 end
                elseif rank_queue(receiverID==id_queue)==max(rank_queue) % no recycle considered, i.e. no percentage is added to its parents or older...
                    ii=receiverID==id_queue;
                    percent_queue(ii)=percent_queue(ii)+percent_queue(n)*ratio;
                end
                
            end
        end
        
        
        linewidth=max(rank_queue)+1-rank_queue;
        
        minwidth=max(linewidth);
        for k=1:length(pairs)
            if (display_with==3 && percent_queue(k)>display_threshold) || (display_with==2 && rank_queue(k)<=display_threshold)% info amount
                if linewidth(k)<minwidth;
                    minwidth=linewidth(k);
                end
            end
        end
        linewidth=(linewidth-minwidth+1);
        for k=1:length(pairs)
            senderID=pairs(1,k);
            receiverID=pairs(2,k);
            if (display_with==3 && percent_queue(k)>display_threshold) || (display_with==2 && rank_queue(k)<=display_threshold)% info amount
                sender=neuron_location(senderID,:);
                receiver=neuron_location(receiverID,:);
                plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'color',classcolor(kk,:),'linewidth',linewidth(k),'markersize',15); % show edge
                plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'*','color',classcolor(kk,:),'markersize',15); % show neuron
                plot3([receiver(1);sender(1)],[receiver(2);sender(2)],[receiver(3);sender(3)],'.','color',classcolor(kk,:),'markersize',15); % show neuron
            end
        end
        
    end
    hold off
end
xlabel('X');
ylabel('Y');
zlabel('Z');
axis([min(neuron_location(:,1)) max(neuron_location(:,1)) min(neuron_location(:,2)) max(neuron_location(:,2)) min(neuron_location(:,3)) max(neuron_location(:,3))]);

box on

% set(handles.ParentHandles.tips,'string','Analysis finished.');
output_information('Analysis finished.', handles.ParentHandles);
figure(h);
% if get(handles.ParentHandles.grid_on_checkbox,'value')==0
%     grid(handles.ParentHandles.axes1,'off');
% else
%     grid(handles.ParentHandles.axes1,'on');
% end

set(h,'Pointer','arrow');
pause(0.01);

function input_neuron_edit_Callback(hObject, eventdata, handles)


function input_neuron_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threshold_edit_Callback(hObject, eventdata, handles)


function threshold_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function all_input_checkbox_Callback(hObject, eventdata, handles)
if get(hObject,'value')==1
    set(handles.remove_other_checkbox,'enable','off');
    set(handles.input_neuron_edit,'enable','off');
else
    set(handles.remove_other_checkbox,'enable','on');
    set(handles.input_neuron_edit,'enable','on');
end


function neuron_id_edit_Callback(hObject, eventdata, handles)


function neuron_id_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton3_Callback(hObject, eventdata, handles)


function display_with_popupmenu_Callback(hObject, eventdata, handles)

if get(hObject,'value')==1 % max spike gradient
    set(handles.threshold_edit,'enable','off');
elseif get(hObject,'value')==3 % info amount
    set(handles.threshold_text,'string','Information amount(%):');
    set(handles.threshold_edit,'string',num2str(0.1));
    set(handles.threshold_edit,'enable','on');
elseif get(hObject,'value')==2
    set(handles.threshold_text,'string','Level number:');
    set(handles.threshold_edit,'string',num2str(3));
    set(handles.threshold_edit,'enable','on');
end


function display_with_popupmenu_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function display_with_cluster_popupmenu_Callback(hObject, eventdata, handles)


function display_with_cluster_popupmenu_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function all_input_cluster_checkbox_Callback(hObject, eventdata, handles)

if get(hObject,'value')==1
    set(handles.remove_other_cluster_checkbox,'enable','off');
    set(handles.input_neuron_cluster_edit,'enable','off');
else
    set(handles.remove_other_cluster_checkbox,'enable','on');
    set(handles.input_neuron_cluster_edit,'enable','on');
end

function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function input_neuron_cluster_edit_Callback(hObject, eventdata, handles)


function input_neuron_cluster_edit_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function remove_other_cluster_checkbox_Callback(hObject, eventdata, handles)
handles.remove_other_cluster=get(hObject,'value');
% weight_clustering_pushbutton_Callback(handles.weight_clustering_pushbutton, eventdata, handles);

function remove_other_checkbox_Callback(hObject, eventdata, handles)

% Information_trace_pushbutton_Callback(handles.Information_trace_pushbutton, eventdata, handles);


function analysisi_content_popupmenu_Callback(hObject, eventdata, handles)


function analysisi_content_popupmenu_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function figure1_CloseRequestFcn(hObject, eventdata, handles)

% Hint: delete(hObject) closes the figure
delete(hObject);
