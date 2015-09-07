function [ class_label ] = import_csv_class_label( num_sample )
%IMPORT_CSV_CLASS_LABEL Summary of this function goes here
%   Detailed explanation goes here
class_label=[];
[FileName,PathName] = uigetfile('*.csv','Select the CSV class label file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
Filepath=strcat(PathName,FileName);
label=csvread(Filepath);
label=label(:);
if(size(label,1)~=num_sample)
    class_label=[];
    msgbox('data entry in row/column does not match the number of samples');
    return;

else
    class_label=label';
end


end

