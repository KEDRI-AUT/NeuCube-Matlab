function network_analysis_btn_Callback(hObject, eventdata, handles)
h=gcf;
if handles.neucube.step<4
    msgbox('Please train the NeuCube first');
    return
end
NetworkAnalysis(handles);
set(h,'Pointer','arrow');