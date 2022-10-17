function [r, V, locB] = getMax(handles)
%RAND2 Summary of this function goes here
%   Detailed explanation goes here
np = handles.np;
potGet = handles.iUseData(:,:,np);
loc = handles.loc;
iL=length(loc);
mDot = zeros(1,iL);
idata = cell(1,iL);
for iDot = 1:iL
%     bNum = length(loc{iDot}(:,1));
    idata{iDot} = potGet(loc{iDot}(:,1),loc{iDot}(:,2));
%     for iNum = 1:bNum
%     idata(iNum) = potGet(loc{iDot}(iNum,1),loc{iDot}(iNum,2));
%     end
    mDot(iDot) = meant0(idata{iDot});
end
[~, rdDot] =sort(mDot,'descend');
% rdDot=randperm(iL);
% handles.rdDot = rdDot;
dot = get(handles.dots,'String');
dots = str2double(dot);
if dots == 0
    big = iL;
else
    big = min(iL,dots);
end
r = zeros(big,1);
V = zeros(big,2);
locB = cell(1,big);
if dots~=0
    word = ['Getting for the maximun ',dot,' dots! please wait...'];
else
    word = 'Getting for all dots! please wait...';
end
set(handles.text1,'string',word)
mywaitbar(0,handles.axes3,'');
for i = 1:big
    locB{i} = loc{rdDot(i)};
%     for iPaper = 1:paper
    V(i,:) = fix(median(locB{i}));
    r(i) = min(max(locB{i}(:,1))-min(locB{i}(:,1)),...
        max(locB{i}(:,2))-min(locB{i}(:,2)))/2;
%     end
    plan = i/big;
    mywaitbar(plan,handles.axes3,[num2str(floor(100*plan)),'%']);

end
%save
% save('main/getmax.mat');
end


function out = meant0(dt)
%%
dt=dt(:);
if any(dt)~=0
    dt(dt==0)=[];
    out = mean(dt);
else
    out = 0;
end
end
