function [calImg, clcbk] = precalbration(bk, img, Center, Radius, plotimg)

if nargin<=2
    Radius=926;
    Center=[926, 1282];
    plotimg = 0;
elseif nargin<=4
    plotimg = 0;
end
dbstop if error
w = 3;
img = double(img);
bk=ordfilt2(bk,9,ones(w,w),'symmetric');
h=ones(w,w)/(w*w);
bk=imfilter(bk,h,'replicate');
[clcbk, radialBk] = clc_mean(bk, Radius, Center);
img = double(img);
filtimg=ordfilt2(img,9,ones(w,w),'symmetric');
filtimg=imfilter(filtimg,h,'replicate');
subimg = imsubtract(filtimg,clcbk);
radialLine = radial_mean(subimg,Radius,Center);
radialLine(isnan(radialLine)) = [];
radialSmooth=smooth(radialLine,50,'rloess');
normRad = radialSmooth(1)./(radialSmooth - radialBk);
normRadSmooth=smooth(normRad,50,'rloess');
calImg = radial2img(subimg./subimg(Center(1), Center(2)),normRadSmooth,Radius,Center);
if plotimg
    x = 1:length(radialBk);
    radialSmoothBk=smooth(radialBk,50,'rloess');
    figure,plot(x,radialBk,'b.',x,radialSmoothBk,'r-')
    title('背景图旋转平均后的曲线')
    subbk = imsubtract(double(bk),clcbk);
    [~, recheckbk] = clc_mean(subbk, Radius, Center);
    recheckSmoothBk=smooth(recheckbk,50,'rloess');
    figure,plot(x,recheckbk,'b.',x,recheckSmoothBk,'r-')
    title('校准后背景图旋转平均后的曲线')
    figure,plot(x,radialLine,'b.',x,radialSmooth,'r-')
    title('去背景后校准图旋转平均后的曲线')
    test = subimg.*calImg;
    [~, radialPlot] = clc_mean(test, Radius, Center);
    recheckSmoothPlot=smooth(radialPlot,50,'rloess');
    figure,plot(x,radialPlot,'b.',x,recheckSmoothPlot,'r-')
    title('最终校准后旋转平均的曲线')
end

end

function radialAverage = radial_mean(img,RadiusM,center)
% Create the meshgrid to be used in resampling
img_size = size(img(:,:,1)); % Size of image
img = double(img);
[X,Y] = meshgrid(1:img_size(2),1:img_size(1));
% R_temp=sqrt((X-center(2)).^2+(Y-center(1)).^2);
R_temp=uint16(sqrt((X-center(2)).^2+(Y-center(1)).^2));

radialAverage = zeros(RadiusM,1);
hwait=waitbar(0,'请等待>>>>>>>>');
for radius = 1:RadiusM
    
    % To avoid redundancy, sample at roughly 1 px distances
    sampled_radial_slice = img(R_temp==radius);
    radialAverage(radius) = mean(sampled_radial_slice(~isnan(sampled_radial_slice)));
%     num_pxls = pi/(1+radius);
%     theta = num_pxls:num_pxls:2*pi;
%     
%     x = center(1) + radius*cos(theta);
%     y = center(2) + radius*sin(theta);
% 
%     sampled_radial_slice = interp2(X,Y,img,x,y,'nearest');
%     
%     radial_average(radius) = mean(sampled_radial_slice(~isnan(sampled_radial_slice)));
    str=['正在运行中',num2str(100*radius/RadiusM),'%'];
    waitbar(radius/RadiusM,hwait,str);
end
close(hwait)
end

function clcimg = radial2img(img,radial_smooth,RadiusM,center)

img_size = size(img(:,:,1)); % Size of image
img = double(img);
[X,Y] = meshgrid(1:img_size(2),1:img_size(1));
R_temp=uint16(sqrt((X-center(2)).^2+(Y-center(1)).^2));
hwait=waitbar(0,'请等待>>>>>>>>');
clcimg = zeros(img_size);
clcimg(926, 1282) = img(926, 1282);
for radius = 1:RadiusM
    clcimg(R_temp==radius) = radial_smooth(radius);
    str=['正在运行中',num2str(100*radius/RadiusM),'%'];
    waitbar(radius/RadiusM,hwait,str);
end
close(hwait)
radial_end = img(R_temp>RadiusM);
clcimg(R_temp>RadiusM) = mean(radial_end(~isnan(radial_end)));
end

function [clcimg, radial_smooth] = clc_mean(img, RadiusM, center)
%EXP_OTF Summary of this function goes here
%   Detailed explanation goes here
% default:
% Radius=926;
% center=[926, 1282];

if nargin<=1
    RadiusM=926;
    center=[926, 1282];
elseif nargin<=3
end
radialAverage = radial_mean(img,RadiusM,center);
radialAverage(isnan(radialAverage)) = [];
radial_smooth=smooth(radialAverage,50,'rloess');
clcimg = radial2img(img,radial_smooth,RadiusM,center);
end
