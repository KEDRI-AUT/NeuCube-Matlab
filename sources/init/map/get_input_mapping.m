function [name_ind, input_ind, An,Af]=get_input_mapping(Vn, Vf,KNN)
% Wn and Wf are the similarity matrices of input neuron graph and feature
% graph
% Vn and Vf are the vertices of the neuron graph and feature graph


%compute Wn, Wf
if nargin==2
    Wn=L2_distance(Vn',Vn');
    Wn=1./Wn; % distance matrix between input neurons
    Wn(logical(eye(size(Wn))))=0;
    An=Wn;
    
    Wf=corr(Vf,Vf);
    Wf(logical(eye(size(Wf))))=0;
    Af=Wf;
    
    number_of_input=size(Wn,1);
    
    %find two most nearest neurons
    L=Wn==max(Wn(:));
    [r,c]=find(L);
    input_ind=[r(1),c(1)];
    Wn(input_ind,input_ind)=0;
    
    %find two most correlated variables
    L=Wf==max(Wf(:));
    [r,c]=find(L);
    name_ind=[r(1),c(1)];
    Wf(name_ind,name_ind)=0;
    
    
    for k=3:number_of_input-1
        
        %find third variable which is most correlated to one of the first two
        Wf2=Wf(name_ind,:);
        L=Wf2==max(Wf2(:));
        [r,c]=find(L);
        name_ind(k)=c(1);
        Wf(name_ind,name_ind)=0;
        
        Wn2=Wn(name_ind(r(1)),:);
        L=Wn2==max(Wn2(:));
        [r,c]=find(L);
        
        while ismember(c(1),input_ind) && sum(Wn2)>0
            Wn2(c)=0;
            L=Wn2==max(Wn2(:));
            [r,c]=find(L);
        end
        input_ind(k)=c(1);
        Wn(input_ind,input_ind)=0;
    end
    L=true(number_of_input,1);
    L(name_ind)=false;
    idx=find(L);
    name_ind(number_of_input)=idx(1);
    
    L=true(number_of_input,1);
    L(input_ind)=false; idx=find(L);
    input_ind(number_of_input)=idx(1);
elseif nargin==3
    [IDX,Dist] = knnsearch(Vn,Vn, 'K',KNN+1);
    IDX=IDX(:,2:end);
    Dist=Dist(:,2:end);
    Wn=NN2W(IDX,Dist);
    Wn=(Wn+Wn')/2;
    An=Wn;
    
    
    [IDX,Dist] = knnsearch(Vf',Vf', 'K',KNN+1,'distance','correlation');
    IDX=IDX(:,2:end);
    Dist=Dist(:,2:end);
    Wf=NN2W(IDX,Dist);
    Wf=(Wf+Wf')/2;
    Af=Wf;
    
    %%%%% compute node affinity matrix %%%%
    n1=size(Wn,1);
    n2=size(Wf,1);
    Ln=Wn>0;
    Lf=Wf>0;

    Kp=ones(n1,n2);%node affinity matrix
    for i=1:n1
        for j=1:n2
            Kp(i,j)=abs(sum(Ln(:,i))-sum(Lf(:,j))); % how many connections their have
        end
    end
    Kp=max(Kp(:))-Kp;
    
    
    %%%%% compute edge affinity matrix %%%%
    [vRn,vCn]=find(triu(Ln,1));
    [vRf,vCf]=find(triu(Lf,1));
    m1=length(vRn);
    m2=length(vRf);
    
    Kq=zeros(m1,m2);%egde affinity matrix
    Wn=normalize(Wn);
    Wf=normalize(Wf);
    for i=1:m1
        for j=1:m2
            Kq(i,j)=abs(Wn(vRn(i),vCn(i))-Wf(vRf(j),vCf(j))); %normalized weight difference
        end
    end
    Kq=max(Kq(:))-Kq;
    
    Ct=ones(n1,n2);
    
    G1=zeros(n1,m1);
    for k=1:length(vRn)
        G1([vRn(k) vCn(k)],k)=1;
    end
    G2=zeros(n2,m2);
    for k=1:length(vRf)
        G2([vRf(k) vCf(k)],k)=1;
    end
    H1=[G1,eye(n1)];
    H2=[G2, eye(n2)];
    
    gphs{1}.G=G1;
    gphs{1}.H=H1;
    gphs{2}.G=G2;
    gphs{2}.H=H2;
    asg = fgmU(Kp, Kq, Ct, gphs, [],[]);
    
    [input_ind,name_ind]=find(asg.X);
end


function W=NN2W(IDX,Dist)
Dist=Dist-min(Dist(:));
Dist=1-Dist/max(Dist(:));

W=zeros(size(IDX,1));
for i=1:size(IDX,1)
    for j=1:size(IDX,2)
        W(i,IDX(i,j))=Dist(i,j);
    end
end

function W=normalize(W)
W=W-min(W(:));
W=W/max(W(:));