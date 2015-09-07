function plots(handles,len)

cube_pos=handles.cube_pos;
cube_pos(4)=cube_pos(4)/7*3;
cla(handles.cube,'reset');
set(handles.cube,'Position',cube_pos);
stem(handles.cube,1:len,handles.spike(1:len),'.');
set(handles.cube,'ylim',[-1.5 1.5]);
set(handles.cube,'ytick',[-1 1]);
xlabel('Time Points');
% rt=get(ax1,'Position');
% [AX,H1,H2]=plotyy(1:length(signal),signal, 1:length(spike), spike);
cla(handles.Axes_signal,'reset');
set(handles.Axes_signal,'visible','on');
plot(handles.Axes_signal , 1:len,handles.signal(1:len));