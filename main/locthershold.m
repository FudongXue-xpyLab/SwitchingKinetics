function dataOut = locthershold(useData, therd)
%LOCTHERSHOLD Summary of this function goes here
%   Detailed explanation goes here

    bf = 0.05;
    therd = round(therd./2);
    [nCol, nRow] = size(useData);
    fithsh = 0;
    for iC = (1+therd):(nCol-therd)
        for iR = (1+therd):(nRow-therd)
            cutdata = useData(iC-therd:iC+therd,iR-therd:iR+therd);
            tem = graythresh(cutdata);
            if tem > fithsh
                fithsh = tem;
            end
        end
        if iC>bf*nCol
            plan = (iC)/(nCol-therd);
            mywaitbar(plan,findobj('Tag','axes3'),[num2str(floor(100*plan)),'%']);
            bf = bf + 0.05;
        end
    end
    dataOut = im2bw(useData,fithsh);

end

