%===================== signal to spike =======================%
function spike_train=signal2spike(signal,threshold)
inputnum=size(signal,2);
samplenum=size(signal,3);
timelength=size(signal,1);
spike_state_length=timelength*samplenum;


spike_train = zeros(spike_state_length,inputnum*2);   %用以计算脑电信号转换的脉冲

threshold=repmat(threshold',[timelength,1,samplenum]);

eegbase=[signal(1,:,:);signal(1:timelength-1,:,:)];
excspike=(signal-eegbase>threshold);            % increase more than AER_threshold in one time tick, emit a exciting spike
inhspike=(signal-eegbase<-threshold);           % decrease more than AER_threshold in one time tick, emit a inhbiting spike
eegspike=[excspike-inhspike,inhspike];

for i=1:samplenum
    spike_train((i-1)*timelength+1:i*timelength,:)=eegspike(:,:,i);
end