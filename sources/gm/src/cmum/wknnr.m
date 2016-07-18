function val_U=wknnr(X_T,lab_T,X_U,K, sigma)
if nargin<5
    sigma=1;
    if nargin<4
        K=5;
    end
end
if ~isvector(lab_T)
    msgbox('labels must be a one dimension vector');
end
labels=lab_T(:);
if size(X_T,2) ~= length(labels)
    X_T=X_T';
    X_U=X_U';
end

[IDX,D] = knnsearch(X_T',X_U','K',K+1);
IDX=IDX(:,1:end-1); % the 
D=D(:,1:end-1)./repmat(D(:,end)+eps,1,K);
Kd=exp(-D/(2*sigma^2)); 
Kd=Kd./repmat(sum(Kd,2),1,K);


Nu=size(X_U,2);
NNVal=zeros(size(IDX));
for k=1:Nu
    NNVal(k,:)=lab_T(IDX(k,:));
end

val_U=sum(NNVal.*Kd,2);   