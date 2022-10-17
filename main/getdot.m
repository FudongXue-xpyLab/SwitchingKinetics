function [n, x, y] = getdot(handles)
%%
if nargin == 0
    return
end
%%
A0 = handles.potGet;
paper = handles.number;
n = zeros(paper,1);
x=cell(1,paper);
y=cell(1,paper);
set(handles.text1,'string','Getting dots,please wait...')
mywaitbar(0,handles.axes3,'');
% if (handles.defaultbg ~=0)
%     n = handles.defaultbg;
% 
%     for iPaper = 1:paper,
%         A1 = single(A0(:,:,iPaper));
%         A = gauss2D(A1,1);
%         mask=[5 5];
%         fImg = ordfilt2(A,prod(mask),ones(mask));
%         fImg2 = ordfilt2(A,prod(mask)-1,ones(mask));
%         fImg(fImg2==fImg)=0;
%         
%         % take only those positions where the max filter and the original image value
%         % are equal -> this is a local maximum
%         fImg(~(fImg == A)) = 0;
%         [x{iPaper}, y{iPaper}]=find(fImg>n(iPaper));
%         plan = iPaper/paper;
%         mywaitbar(plan,handles.axes3,[num2str(floor(plan)),'%']);
%     end
% else
    for iPaper = 1:paper,
        A1 = single(A0(:,:,iPaper));
        mask=[5 5];
        A1 = medfilt2(A1);
%         meanA = mean(mean(A1))*30;
%         A1(A1>meanA) = meanA;
        A = gauss2D(A1,1);
        fImg = ordfilt2(A,prod(mask),ones(mask));
        fImg2 = ordfilt2(A,prod(mask)-1,ones(mask));
        fImg(fImg2==fImg)=0;
        
        % take only those positions where the max filter and the original image value
        % are equal -> this is a local maximum
        fImg(~(fImg == A)) = 0;
        
        % set image border to zero
        %     isMax = max(A1);
        isMax = max(fImg);
        n(iPaper) = round(max(isMax)/4);        %the backgroud
        [x{iPaper}, y{iPaper}]=find(fImg>n(iPaper));
        
        %     for i = 1:length(x)
        %         dataOut(x(i),y(i),iPaper) = A1(x(i),y(i));
        %     end
        %     dataOut(:,:,1) = A(x,y,iPaper);
        plan = iPaper/paper;
        
        mywaitbar(plan,handles.axes3,[num2str(floor(100*plan)),'%']);
    end
% end
set(handles.text1,'string','Comparing finished!')
pause(eps)

% out = dataOut;