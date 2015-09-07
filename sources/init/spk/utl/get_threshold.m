function variable_threshold=get_threshold(dataset,alpha)
data=dataset.data;
spk=diff(data,1,1);
variable_threshold=zeros(1,size(data,2));
for k=1:size(spk,3)
    spk1=spk(:,:,k);
    variable_threshold=variable_threshold+mean(abs(spk1),1)+std(abs(spk1),0,1)*alpha;
end
variable_threshold=variable_threshold'/size(spk,3);