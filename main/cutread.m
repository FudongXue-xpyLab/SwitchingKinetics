function [Image]=cutread(FileStr,idx,leth)
A=imread(FileStr,1);
[row,col,z]=size(A);
v=1:idx;
if leth~=0
    Image=uint16(zeros(leth,leth,idx));
else
    Image=uint16(zeros(row,col,idx));
end
set(findobj('Tag','text1'),'string','Reading images,please wait...')
mywaitbar(0,findobj('Tag','axes3'),'');
for j=1:idx

    if leth~=0
        iImage=imread(FileStr,v(j));
        arow = max(1,fix(row/2)-fix(leth/2)+1);
        brow = min(row,fix(row/2)+fix(leth/2));
        acol = max(1,fix(col/2)-fix(leth/2)+1);
        bcol = min(col,fix(col/2)+fix(leth/2));
        %     try
        if z ~= 3
            Image(:,:,j)=iImage(arow:brow,acol:bcol);
        else
            Image(:,:,j)=iImage(arow:brow,acol:bcol,3);
        end
        
        %save
    else
        Image(:,:,j)=imread(FileStr,v(j));
    end
    plan = j/idx;
    mywaitbar(plan,findobj('Tag','axes3'),[num2str(floor(100*plan)),'%']);
end
pause(eps)

end

