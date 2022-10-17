function imgout = lowFilter(I1, d0)
%������˹��ͨ�˲���
if nargin<2
    d0=50;
end
[M,N,num]=size(I1);%����ͼ��ĸߺͿ�
imgout = zeros(M,N,num);
for iframe = 1:num
    f=double(I1(:,:,iframe));
    g=fft2(f);%����Ҷ�任
    g=fftshift(g);%ֱ�������Ƶ�Ƶ������

    nn=2;%��ֹƵ��Ϊ50�Ķ��װ�����˹��ͨ�˲���
    m=round(M/2);
    n=round(N/2);%����ȡ��
    for i=1:M
        for j=1:N
            d=sqrt((i-m)^2+(j-n)^2);%����Ƶ��ƽ��ԭ�㵽����ľ���
            h=1/(1+0.414*(d/d0)^(2*nn));%���ݹ�ʽ
            result(i,j)=h*g(i,j);%�˲���ʽ
        end
    end
    result=ifftshift(result);%ֱ�������ƻص����Ͻ�
    I2=ifft2(result);%����Ҷ���任
    imgout(:,:,iframe)=uint16(real(I2));%ȡ��ֵ��ת����16λ�޷�������
end
end