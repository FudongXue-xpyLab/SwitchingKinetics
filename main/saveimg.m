function saveimg( handles )
%SAVEIMG Summary of this function goes here
%   Detailed explanation goes here

file_name = handles.file;
newfig2=figure;
set(newfig2,'Visible','off');%�����½���figureΪ���ɼ�
new_h2=copyobj(handles.axes2,newfig2);
set(new_h2,'Units','default','Position','default');
%saveas(newfig2,fullfile(pathname2,filename2));%���Ա����������֮���
%������벻�����Ա���������⣬�����Ա���figure��axesͼ��ı���
hp2=getframe(newfig2);
hp2= frame2im(hp2);
t=strfind(file_name,'.tif');
filebase=file_name(1:t-1);
fidopt = [filebase,'_dataget.png'];
imwrite(hp2,fidopt);
close(newfig2);
end

