function [ input ] = load_json_input()
%LOAD_JSON_INPUT Summary of this function goes here
%   Detailed explanation goes here
input=[];
[FileName,PathName] = uigetfile('*.json','Select the JSON input file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
opt.ShowProgress=1;
input=loadjson(strcat(PathName,FileName),opt);
if(input.filetype==1)
    if(isfield(input,'feature_name'))
        input.feature_name=input.feature_name{1}';
    end
    input=rmfield(input,'filetype');
else
    input=[];
    msgbox('Error in file type detected. Please import an input file!!')
end

end

