function [ eeg_mapping ] = import_csv_eeg_mapping( num_features )
%IMPORT_CSV_EEG_MAPPING Summary of this function goes here
%   Detailed explanation goes here
[FileName,PathName] = uigetfile('*.csv','Select the CSV input mapping file');
if isempty(FileName) || isa(FileName,'double')==1
    msgbox('Cannot open the file!');
    return;
end
Filepath=strcat(PathName,FileName);
eeg_mapping=csvread(Filepath);
if(size(eeg_mapping,1)~=num_features)
    msgbox('Number of rows in the csv file does not match the number of features!!');
    return;
end

end

