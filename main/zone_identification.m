function [out] = zone_identification(handles)
%ZONE_IDENTIFICATION Summary of this function goes here
%   Detailed explanation goes here
potGet = handles.potGet;
[Height, Width] = size(potGet);
% out = cell(1,paper);
% for iPaper = 1:paper
D = bwdist(~potGet);
D = -D;
D(~potGet) = -Inf;
L = watershed(D,18);
% save('pot.mat')
nMedian = tabulate(L(:));
nMedian(nMedian(:,2)<10,:)=[];
nMedian(nMedian(:,1)<2,:)=[];
lMed = max(100,median(nMedian(:,2)));
lMax = 12*lMed;  %max(nMedian);
lMin = lMed/3;  %0;
delP = (nMedian(:,2)>lMin)&(nMedian(:,2)<lMax);
nMedian(~delP,:)=[];
num = length(nMedian(:,1));
out = cell(1,num);
l = ceil(sqrt(lMed));
set(handles.text1,'string','Finding particles,please wait...')
mywaitbar(0,handles.axes3,'');
for i = 1:num
    [a,b] = find(L==nMedian(i,1));
    a1 = fix(median(a));
    b1 = fix(median(b));
    if (a1>l&&a1<(Height-l))&&(b1>l&&b1<(Width-l))
        [out{i}(:,1),out{i}(:,2)] = find(L==nMedian(i,1));
    end
    plan = double(i)/double(num);
    mywaitbar(plan,handles.axes3,[num2str(floor(100*plan)),'%']);
end
[nrows, ~]= cellfun(@size, out);
id = nrows==0;
out(id) = [];
% end
dot = get(handles.dots,'String');
dots = str2double(dot);
if dots~=0
    word = ['Finding finished! Next to get ',dot,' Max dots!'];
else
    word = 'Finding finished! Next to get all dots!';
end
set(handles.text1,'string',word)
pause(eps)
% save('main/zone.mat');
end

