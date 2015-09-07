function [ output_args ] = save_json_input( input )
%SAVE_JSON_INPUT Summary of this function goes here
%   Detailed explanation goes here
[file,path] = uiputfile('*.json','Save Workspace As',strcat('input_',datestr(now,30),'.json'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    
    opt.FileName=strcat(path,file);
    opt.ArrayIndent=1;
    opt.ArrayToStruct=0;
    json_input=m2json_input(input);
    savejson('',json_input,opt);
    
end

