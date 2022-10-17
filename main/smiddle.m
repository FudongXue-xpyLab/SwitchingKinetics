function [num, aMin, outA] = smiddle(A,foscale)
%SMIDDLE Summary of this function goes here
%   Detailed explanation goes here
[y, x] = size(A);
num = max(A(:))+1;
H = zeros(1,num);
for w = 1:x
    for h = 1:y
        i = A(h,w)+1;
        H(i) = H(i) +1;
    end
end
for i =2:num
    H(i) = H(i) + H(i-1);
end
iMax = 0;
iMin = 0;
for i = 1:num
    while (iMax == 0)
        if H(num-i+1)<H(num)*0.999
            aMax = num-i+1;
            iMax = iMax + 1;
        else
            break
        end
    end
    while (iMin == 0)
        if H(i)>H(num)*foscale
            aMin = i;
            iMin = iMin + 1;
        else
            break
        end
    end
    if iMax~=0 && iMin~=0
        break
    end
end
A(A>aMax) = aMax;
% aMin = min(0.9*num,find(H==max(H(2:end)))*foscale);
A(A<aMin) = aMin;
outP = A;
outA = medfilt2(outP);
end

