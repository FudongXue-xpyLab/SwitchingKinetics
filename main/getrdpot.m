function [isMax, np, out] = getrdpot(A0, cal)
%%
if nargin == 0
    return
elseif nargin < 2
    cal = 0;
end

%%
therd = get(findobj('Tag','size'),'String');
therd = str2double(therd);
foscale = get(findobj('Tag','scale'),'String');
foscale = str2double(foscale);
highFr = str2double(get(findobj('Tag','hFrame'),'String'));
[~,~,paper]=size(A0);
if isnan(highFr)||highFr == 0
    bInter = zeros(1,paper);
    for ilarge = 1:paper
        A = A0(:,:,ilarge);
        bInter(ilarge) = std(double(A(:)));
    end
    np = find(bInter==max(bInter));
else
    np = min(highFr,paper);
end
set(findobj('Tag','text1'),'string','Getting images,please wait...')
if cal
    foscale = 1.2*foscale;
end
A1 = A0(:,:,np(1));
A2 = adapthisteq(A1, 'NumTiles', [15 15], 'ClipLimit', 0.005);
A1=ordfilt2(A2,3,ones(3),'symmetric');
A1 = uint16(A1);

J0 = A1;
J0(J0 < 0) = [];
if therd == 0
    bw=im2bw(A1,foscale*graythresh(J0));
    out=bwareaopen(bw,5);
else
    mywaitbar(0,findobj('Tag','axes3'),'');
    bw = locthershold(A1, therd);
    out=bwareaopen(bw,5);
end
isMax = max(A1(:));
%save
