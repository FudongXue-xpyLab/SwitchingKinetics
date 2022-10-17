function meansd(iMean,lowI,number,file_name,dist2center, n)
%MEANSD Summary of this function goes here
%   Detailed explanation goes here
% iMean = handles.iMean;
% lowI = handles.bg;
% number = handles.number;
% file_name = handles.file;
switch n
    case 1
        dot10mean = zeros(number,1);
        sd = zeros(number,1);
        for i = 1:number
            iMn = iMean(:,i);
            if any(iMn)~=0
                iMn(iMn==0) = [];
                dot10mean(i) = mean(iMn);
                sd(i) = std(iMn,0,1);
            else
                dot10mean(i) = lowI;
                sd(i) = lowI/8;
            end
        end
    otherwise
        dot10mean = mean(iMean);
        sd = std(iMean,0,1);
end
[cNum, rNum] = size(iMean);
set(findobj('Tag','text1'),'string','Saving datas, please wait...')
mywaitbar(0,findobj('Tag','axes3'),'');
% iRatio = zeros(cNum, rNum);
% for iNum = 1:cNum
%     for jNum = 1:rNum
%         iRatio(iNum, jNum) = iMean(iNum, jNum)/iMean(iNum, 1);
%     end
% end
if mod(rNum,2) == 0
    rNum = rNum - 1;
end
specificValue = zeros(cNum, floor(rNum/2));
for iNum = 1:cNum
    for jNum = 2:2:rNum
        specificValue(iNum, jNum/2) = (iMean(iNum, jNum+1)-iMean(iNum, jNum))/iMean(iNum, jNum);
    end
    plan = iNum/cNum;
    mywaitbar(plan,findobj('Tag','axes3'),[num2str(floor(100*plan)),'%']);
end
specificValue(:, end+1) = mean(specificValue,2);
clear plan cNum rNum
t=strfind(file_name,'.tif');
filebase=file_name(1:t-1);
fidsd = [filebase,'_sd.txt'];
fid = fopen(fidsd,'w');
fprintf(fid,'%.4f\r\n',sd);
fclose(fid);
fidmean = [filebase,'_mean.txt'];
fid = fopen(fidmean,'w');
fprintf(fid,'%.4f\r\n',dot10mean);
fclose(fid);
clear sd dot10mean
t = 1:number;
temlegh = length(iMean(:,1));
limlegh = 200;
il = 1;
if temlegh<limlegh
    til = 1:temlegh;
    iMean = [t; iMean];
    iMean = [[0, til]', iMean, [0; dist2center]];
    fidm = [filebase,'_imean.xls'];
    xlswrite(fidm, iMean);
    iValue = [til', specificValue];
    xlswrite(fidm, iValue, 2);
%     iRatio = [t', iRatio'];
%     iRatio = [[0 til];  iRatio];
%     fidm = [filebase,'_ratio.xls'];
%     xlswrite(fidm, iRatio);
else
    while temlegh>=limlegh
        til = limlegh*(il-1)+(1:limlegh);
        iMean2 = [t; iMean(1:limlegh,:)];
        dist2center2 = dist2center(1:limlegh);
        iMean1 = [[0, til]', iMean2, [0; dist2center2]];
%         iRatio2 = [t',iRatio(1:limlegh,:)'];
%         iRatio1 = [[0 til];  iRatio2];
        iValue1 = [til', specificValue(1:limlegh,:)];
        fidm = [filebase,'_imean',num2str(il),'.xls'];
        xlswrite(fidm,iMean1,1);
        xlswrite(fidm,iValue1,2);
%         fidm = [filebase,'_ratio',num2str(il),'.xls'];
%         xlswrite(fidm,iRatio1);
        iMean = iMean(limlegh+1:end,:);
        dist2center = dist2center(limlegh+1:end);
%         iRatio = iRatio(limlegh+1:end,:);
        specificValue = specificValue(limlegh+1:end,:);
        temlegh = temlegh -limlegh;
        il = il + 1;
    end
    til = 1:temlegh;
    iMean = [t; iMean];
    iMean = [[0, til]', iMean, [0; dist2center]];
    fidm = [filebase,'_imean',num2str(il),'.xls'];
    xlswrite(fidm, iMean, 'sheet1');
    iValue = [til', specificValue];
    xlswrite(fidm, iValue, 'sheet2');
%     iRatio = [t', iRatio'];
%     iRatio = [[0 til]; iRatio];
%     fidm = [filebase,'_ratio',num2str(il),'.xls'];
%     xlswrite(fidm, iRatio);
end

end

