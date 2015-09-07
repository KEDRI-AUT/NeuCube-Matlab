function [] = save_json_parameter( parameter )
%SAVE_JSON_PARAMETER Summary of this function goes here
%   Detailed explanation goes here

[file,path] = uiputfile('*.json','Save Workspace As',strcat('parameters_',datestr(now,30),'.json'));
if isa(file,'double')==1
    msgbox('Cannot save the file!');
    return
else
    
    opt.FileName=strcat(path,file);
    opt.ArrayIndent=1;
    opt.ArrayToStruct=0;
    json_param=m2json_parameter(parameter);
    savejson('',json_param,opt);
end

end

