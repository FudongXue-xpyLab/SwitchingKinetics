function optimum = dotsave(handles)
%DOTSAVE Summary of this function goes here
%   Detailed explanation goes here
iMean = handles.iMean;
num = handles.number;
file_name = handles.file;
A=imread(file_name,1);
[sH,sL,~]=size(A);
leth = handles.Width;
paper = length(iMean(:,1));
p = zeros(paper,2);
t = 0:2:2*(num-1);
for i = 1:paper
    p(i,:) = polyfit(t,iMean(i,:),1);
end
pos = find(abs(p(:,1))==max(abs(p(:,1))));
x = handles.V(pos,1);
y = handles.V(pos,2);
row = (sL - leth)/2 + y;
col = (sH - leth)/2 + x;
hInch = str2double(handles.Inch{1});
lInch = str2double(handles.Inch{2});
rInc = single(row*lInch/sH);
cInc = single(col*hInch/sL);
rInc = num2str(rInc);
cInc = num2str(cInc);
optimum = ['The optimum position is at ',rInc,'*',cInc,'inches!'];
t=strfind(file_name,'.tif');
filebase=file_name(1:t-1);
fidopt = [filebase,'_dataget.txt'];
fid = fopen(fidopt,'w');
fprintf(fid,'%s',optimum);
fclose(fid);
set(handles.text1,'string','The optimal dot is saved in dataget.txt!')
end

