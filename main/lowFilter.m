function imgout = lowFilter(I1, d0)
%巴特沃斯低通滤波器
if nargin<2
    d0=50;
end
[M,N,num]=size(I1);%计算图像的高和宽
imgout = zeros(M,N,num);
for iframe = 1:num
    f=double(I1(:,:,iframe));
    g=fft2(f);%傅里叶变换
    g=fftshift(g);%直流分量移到频谱中心

    nn=2;%截止频率为50的二阶巴特沃斯低通滤波器
    m=round(M/2);
    n=round(N/2);%数据取整
    for i=1:M
        for j=1:N
            d=sqrt((i-m)^2+(j-n)^2);%计算频率平面原点到各点的距离
            h=1/(1+0.414*(d/d0)^(2*nn));%传递公式
            result(i,j)=h*g(i,j);%滤波公式
        end
    end
    result=ifftshift(result);%直流分量移回到左上角
    I2=ifft2(result);%傅里叶反变换
    imgout(:,:,iframe)=uint16(real(I2));%取幅值并转换成16位无符号整数
end
end