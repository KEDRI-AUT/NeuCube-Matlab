function [cube] = load_json_cube()
%LOAD_JSON_CUBE Summary of this function goes here
%   Detailed explanation goes here
cube=[];
[FileName,PathName] = uigetfile('*.json','Select the JSON cube file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
opt.ShowProgress=1;
opt.FastArrayParser=2;

%%load data from json file
cube=loadjson(strcat(PathName,FileName),opt);
%validate the data and transform into neucube-matlab format
%if(validate_json_cube(cube))
if(cube.filetype==3)
    cube=json2m_cube(cube);
else
    cube=[];
    msgbox('Error in file type detected. Please import a cube file!!');
end
%end

end

