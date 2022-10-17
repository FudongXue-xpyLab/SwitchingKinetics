function [ calImg ] = cali_process( img, clcbk, calhigh, Radius, Center)
%CALIPOISE Summary of this function goes here
%   Detailed explanation goes here

num = length(img(1,1,:));
if all(size(clcbk) == size(img(:,:,1)))&&all(size(calhigh) == size(clcbk))
    clcbk = repmat(clcbk,[1 1 num]);
    calhigh(calhigh<1) = 1;
    calhigh = repmat(calhigh,[1 1 num]);

    subimg = imsubtract(double(img),clcbk);
    subimg(subimg<0) = 0;
    calImg = subimg.*calhigh;
%     radialAverage = radial_mean(calImg(:,:,1), Radius, Center);
%     normRad = radialAverage(1)./radialAverage;
%     normRadSmooth=smooth(normRad,50,'rloess');
%     rcalhigh = radial2img(calImg./calImg(Center(1), Center(2), 1),normRadSmooth,Radius,Center);
%     rcalhigh(calhigh<1) = 1;
%     rcalhigh = repmat(rcalhigh,[1 1 num]);
%     calImg = calImg.*rcalhigh;
%     A1 = lowFilter(calImg);
    if 1
        % figure,imshow(calImg(:,:,1),[])
        radialAverage = radial_mean(calImg(:,:,1), Radius, Center);
        figure,plot(radialAverage)
    end
else
    calImg = img;
    disp('Subscripted assignment dimension mismatch.');
    return
end

end

function radialAverage = radial_mean(img,RadiusM,center)
% Create the meshgrid to be used in resampling
img_size = size(img(:,:,1)); % Size of image
img = double(img);
[X,Y] = meshgrid(1:img_size(2),1:img_size(1));
R_temp=uint16(sqrt((X-center(2)).^2+(Y-center(1)).^2));

radialAverage = zeros(RadiusM,1);
hwait=waitbar(0,'请等待>>>>>>>>');
for radius = 1:RadiusM
    
    % To avoid redundancy, sample at roughly 1 px distances
    sampled_radial_slice = img(R_temp==radius);
    radialAverage(radius) = mean(sampled_radial_slice(~isnan(sampled_radial_slice)));
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