function duplicate_figure_btn_Callback(hObject, eventdata, handles)
h=gcf;
set(h,'Pointer','watch');
pause(0.01);

hgsave(handles.cube,'temp');
hfig=figure;
haxe=hgload('temp.fig');

unit=get(hfig,'Units');
set(hfig,'Units','pixels');
pos=get(hfig,'position');


% unit2=get(haxe,'units');
set(haxe,'units','pixels');
% rect=get(haxe,'OuterPosition');

pos(1)=1;
pos(2)=1;
% pos(3)=rect1(3);
% pos(4)=rect1(4);
% set(hfig,'Position',pos);
set(haxe,'outerposition',pos);
set(haxe,'units','normalized');
set(hfig,'Units',unit);
set(h,'Pointer','arrow');
pause(0.01);
delete('temp.fig')