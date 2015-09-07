function [] = save_json_cube( cube )
%SAVE_JSON_CUBE Summary of this function goes here
%   Detailed explanation goes here
[file,path] = uiputfile('*.json','Save Workspace As',strcat('cube_',datestr(now,30),'.json'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    opt.FileName=strcat(path,file);
    opt.ArrayIndent=1;
    opt.ArrayToStruct=0;
    %opt.opt.FloatFormat='%.2d';
    
    %%convert neucube-matlab format to json format
    json_cube=m2json_cube(cube);
    %%write json file
    savejson('',json_cube,opt);
end
end

