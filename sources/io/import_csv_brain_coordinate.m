function [ brain_coordinate ] = import_csv_brain_coordinate
%IMPORT_CSV_BRAIN_COORDINATE Summary of this function goes here
%   Detailed explanation goes here
brain_coordinate=[];
[FileName,PathName] = uigetfile('*.csv','Select the CSV cube coordinate file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
Filepath=strcat(PathName,FileName);
coordinate=csvread(Filepath);
brain_coordinate=coordinate;


end

