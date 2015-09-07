function ButtonDownFcn_callback(hObject, eventdata, handles)
global xx yy hcube
xy=[xx(:) yy(:)];
pos=get(ancestor(hObject,'axes'), 'CurrentPoint' );
d=sum((xy-repmat(pos(1,1:2), size(xy,1),1)).^2,2);
idx=find(d==min(d));


plot(hcube)
