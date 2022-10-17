function [outData, dist2center]=getmean(handles)
%%
%POTMEAN Summary of this function goes here
%   Detailed explanation goes here
% iPaper = 1;
% paper = 1;
if ~isfield(handles,'bgL')
    handles.bgL = 0;
end
if ~isfield(handles,'bgH')
    handles.bgH = handles.bg;
end
inpot = handles.iUseData;
locB =handles.locRd;
paper = handles.number;
FileStr = handles.file;
r = handles.r;
a = handles.V(:,1);
b = handles.V(:,2);
mn = length(a);
iMean=zeros(mn,paper);
theta=0:0.01*pi:2*pi;
set(findobj('Tag','image_number'),'Visible','on');    
if paper ~= 1
    step=1.0/(paper-1);
    set(findobj('Tag','slider1'),'max',1.0,'min',0,'SliderStep',[step 3*step],'value',0);
    set(findobj('Tag','text1'),'string','Getting mean value,please wait...')
    mywaitbar(0,findobj('Tag','axes3'),'');
    axes(handles.axes1);
    cla reset;
    for iPaper = 1:paper
        imshow(inpot(:,:,iPaper),[handles.bgL handles.bgH]);
        for i = 1:mn
            x=r(i)*cos(theta)+b(i);
            y=r(i)*sin(theta)+a(i);
            line(x, y,'color','b');
            no = num2str(i);
            text(b(i)+r(i),a(i),no,'Color','y');
            id = locB{i};
            dt = inpot(id(:,1),id(:,2),iPaper);
            iMean(i,iPaper)=meant0(dt);
        end
        plan = iPaper/paper;
        set(handles.slider1,'value',plan);
        fstr=strcat(FileStr,'. Image #:',int2str(iPaper),'/',num2str(paper));
        set(findobj('Tag','image_number'),'String',fstr);
        mywaitbar(plan,findobj('Tag','axes3'),[num2str(floor(100*plan)),'%']);
    end
    if isfield(handles,'defaultbg')&&~isempty(handles.defaultbg)
        Center = handles.defaultbg.Center;
    else
        Center = [926, 1282];
    end
    dist2center = sqrt((handles.V(:,1)-Center(1)).^2 + (handles.V(:,2)-Center(2)).^2);
    t=strfind(FileStr,'.tif');
    name=FileStr(1:t-1);
    pix=getframe(handles.axes1);
    imwrite(pix.cdata,[name,'.jpg'])
else
    h=errordlg('This image have not goten enough frames! Please submit tiffs more than one frame!');
    waitfor(h);
end

pause(5)
set(handles.text1,'string','Getting mean finished! Data is sving...')
%save
outData=iMean;
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
