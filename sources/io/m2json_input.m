function [ json_input ] = m2json_input( input )
%M2JSON_INPUT Summary of this function goes here
%   Detailed explanation goes here

% if(isfield(input,'data'))
%     if(isempty(input.data))
%         json_input.data={};
%     else
%         json_input.data=input.data;
%     end
% end
% if(isfield(input,'target_value'))
%     if(isempty(input.target_value))
%         json_input.target_value={};
%     else
%         json_input.target_value=input.target_value;
%     end
% end
json_input=input;
json_input.filetype=1;
end
