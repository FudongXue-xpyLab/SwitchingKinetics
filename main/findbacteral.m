function findbacteral(inpot, V, r, bg, FileStr, sel)
%FINDBACTERAL Summary of this function goes here
%   Detailed explanation goes here

paper = length(inpot(1,1,:));
a = V(:,1);
b = V(:,2);
if sel == 0
    sel = 1:length(a);
end
if length(bg) == 1
    bg(2) = bg;
    bg(1) = 0;
end
mn = length(sel);
theta=0:0.01*pi:2*pi;
set(findobj('Tag','image_number'),'Visible','on');    
if paper ~= 1
    step=1.0/(paper-1);
    set(findobj('Tag','slider1'),'max',1.0,'min',0,'SliderStep',[step 3*step],'value',0);
    set(findobj('Tag','text1'),'string','Finding...')
    mywaitbar(0,findobj('Tag','axes3'),'');
    for iPaper = 1:paper
        imshow(inpot(:,:,iPaper),[bg(1) bg(2)]);
        if mn == 1
            x=r(sel)*cos(theta)+b(sel);
            y=r(sel)*sin(theta)+a(sel);
            line(x, y,'color','b');
            no = num2str(sel);
            text(b(sel)+r(sel),a(sel),no,'Color','y');
        else
            for i = 1:mn
                x=r(sel(i))*cos(theta)+b(sel(i));
                y=r(sel(i))*sin(theta)+a(sel(i));
                line(x, y,'color','b');
                no = num2str(sel(i));
                text(b(sel(i))+r(sel(i)),a(sel(i)),no,'Color','y');
            end
        end
        plan = iPaper/paper;
        set(findobj('Tag','slider1'),'value',plan);
        fstr=strcat(FileStr,'. Image #:',int2str(iPaper),'/',num2str(paper));
        set(findobj('Tag','image_number'),'String',fstr);
        mywaitbar(plan,findobj('Tag','axes3'),[num2str(floor(100*plan)),'%']);
    end
else
    h=errordlg('This image have not goten enough frames! Please submit tiffs more than one frame!');
    waitfor(h);
end

pause(1)
set(findobj('Tag','text1'),'string','Find the selected dot!')
% save('fi.mat')
end


