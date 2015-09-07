function [dataset] = import_csv_data(num_timepoint )
%IMPORT_CSV_DATA Summary of this function goes here
%   Detailed explanation goes here
dataset=[];
[FileName,PathName] = uigetfile('*.csv','Select the CSV dataset file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
Filepath=strcat(PathName,FileName);
dataset=csvread(Filepath);
num_feature=size(dataset,2);
num_sample=size(dataset,1)/num_timepoint;
dataset=permute(reshape(dataset,[num_timepoint num_sample num_feature]),[1 3 2]);
end

