function [parameter] = load_json_parameter()
%LOAD_JSON_PARAMETER Summary of this function goes here
%   Detailed explanation goes here
parameter=[];
[FileName,PathName] = uigetfile('*.json','Select the JSON parameter file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
opt.ShowProgress=1;

parameter=loadjson(strcat(PathName,FileName),opt);

if(parameter.filetype==2)
    if(iscell(parameter.init.mapping_coordinate))
        parameter.init.mapping_coordinate=cell2mat(parameter.init.mapping_coordinate);
    end
    if(iscell(parameter.init.neuron_location))
        parameter.init.neuron_location=cell2mat(parameter.init.neuron_location);
    end
    parameter=rmfield(parameter,'filetype');
else
    parameter=[];
    msgbox('Error in file type detected. Please import a parameter file!!');
end
%end
    


end

