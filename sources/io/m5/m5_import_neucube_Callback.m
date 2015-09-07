function m5_import_neucube_Callback(hObject, eventdata, handles)
cube=load_json_cube;
handles.neucube=cube;
guidata(hObject, handles);