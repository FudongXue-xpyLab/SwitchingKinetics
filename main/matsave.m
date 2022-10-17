function matsave(matname,handles)
%MATSAVE Summary of this function goes here
%   Detailed explanation goes here

result.iUseData = handles.iUseData;
result.V = handles.V;
result.r = handles.r;
result.bg = handles.bg;
result.number = handles.number;
result.file = handles.file;
save(matname,'result')
end

