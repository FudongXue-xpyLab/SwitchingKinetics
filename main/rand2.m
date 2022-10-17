function [r, V, locB] = rand2(handles)
%RAND2 Summary of this function goes here
%   Detailed explanation goes here
potGet = handles.potGet;
loc = handles.loc;
[~,~,paper] = size(potGet);
iL=length(loc{paper});
rdDot=randperm(iL);
% handles.rdDot = rdDot;
dot = get(handles.dots,'String');
dots = str2double(dot);
if dots == 0
    big = iL;
else
    big = min(iL,dots);
end
r = cell(1,paper);
V = zeros(big,2);
locB = cell(1,big);
word = ['Getting for the ',dot,' random dots! please wait...'];
set(handles.text1,'string',word)
mywaitbar(0,handles.axes3,'');
for i = 1:big
    locB{i} = loc{paper}{rdDot(i)};
    for iPaper = 1:paper
    V(i,:) = fix(median(locB{i}));
    r{iPaper}(i) = min(max(locB{i}(:,1))-min(locB{i}(:,1)),...
        max(locB{i}(:,2))-min(locB{i}(:,2)))/2;
%     save('main/zrand2.mat');
%     r{iPaper}(i) = min(r,11);
    end
    plan = i/big;
    
    mywaitbar(plan,handles.axes3,[num2str(floor(100*plan)),'%']);

end
%save
save('main/zrand2.mat');
end


% function r=gtR(row,col,potGet, big)
% theta=0:0.1*pi:2*pi;
% [Height,Width,paper] = size(potGet);
% r=zeros(big,1);
% for i=1:big
%     for iR=1:11
%         x=r(i)*cos(theta)+row(i);
%         y=r(i)*sin(theta)+col(i);
%         x = min(Height,max(1,fix(x)));
%         y = min(Width,max(1,fix(y)));
%         iM = potGet(x,y,paper);
%         imin=min(iM(:));
%         if imin ~= 0
%             r(i) = r(i) + 1;
%         else
%             break
%         end
%     end
%     r(i) = r(i) - 1;
% end
% end
