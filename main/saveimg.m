function saveimg( handles )
%SAVEIMG Summary of this function goes here
%   Detailed explanation goes here

file_name = handles.file;
newfig2=figure;
set(newfig2,'Visible','off');%设置新建的figure为不可见
new_h2=copyobj(handles.axes2,newfig2);
set(new_h2,'Units','default','Position','default');
%saveas(newfig2,fullfile(pathname2,filename2));%可以保存坐标标题之类的
%下面代码不仅可以保存坐标标题，还可以保存figure中axes图像的背景
hp2=getframe(newfig2);
hp2= frame2im(hp2);
t=strfind(file_name,'.tif');
filebase=file_name(1:t-1);
fidopt = [filebase,'_dataget.png'];
imwrite(hp2,fidopt);
close(newfig2);
end

