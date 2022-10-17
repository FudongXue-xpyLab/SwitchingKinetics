function [Image]=cutimg(img,leth)

if leth==0
    Image = img;
    return
else
    [row,col]=size(img(:,:,1));
    arow = max(1,fix(row/2)-fix(leth/2)+1);
    brow = min(row,fix(row/2)+fix(leth/2));
    acol = max(1,fix(col/2)-fix(leth/2)+1);
    bcol = min(col,fix(col/2)+fix(leth/2));
    Image=img(arow:brow,acol:bcol,:);
end
end



