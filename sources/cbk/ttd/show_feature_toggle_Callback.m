function show_feature_toggle_Callback(hObject, eventdata, handles)
set(gcf,'Pointer','watch');
global texthandles circlehandles
neucube=handles.neucube;
neuinput=neucube.input_mapping{1};
Names=neucube.input_mapping{2};
axes(handles.cube);
hold on

rng(1);
classcolor=colormap(jet(size(neuinput,1)));
ix=randperm(size(neuinput,1));
classcolor=classcolor(ix,:);

if get(handles.show_feature_toggle,'value')==1
    for k=1:size(neuinput,1)
        texthandles{k}=text(neuinput(k,1)+1,neuinput(k,2)+1,neuinput(k,3)+1,Names{k},'color',classcolor(k,:),'FontSize',12,'FontWeight','bold');
        circlehandles{k}=plot3(neuinput(k,1),neuinput(k,2),neuinput(k,3),'o','MarkerFaceColor',classcolor(k,:),'MarkerSize',10);
    end
else
    for k=1:length(texthandles)
        if ishandle(texthandles{k})
            delete(texthandles{k});
        end
        if ishandle(circlehandles{k})
            delete(circlehandles{k});
        end
    end
    texthandles=[];
    circlehandles=[];
end
hold off
set(gcf,'Pointer','arrow');