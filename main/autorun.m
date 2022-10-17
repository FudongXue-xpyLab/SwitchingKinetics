function [r, V, potGet,bg] = autorun(hObject,handles)
%AUTORUN Summary of this function goes here
%   Detailed explanation goes here
auNumber = length(handles.filestr);
for i = 1:auNumber
    handles.file = handles.filestr{i};
    
    if ~isempty(handles.file)
        Strfile = imfinfo(handles.file);
        x=Strfile.Height;
        y=Strfile.Width;
        leth=get(handles.leth,'String');
        leth = str2double(leth);
        handles.Height = min(leth,x);
        handles.Width = min(leth,y);
        handles.number = length(Strfile);
        handles.iUseData = cutread(handles);
        [handles.bg, handles.potGet] = getrdpot(handles.iUseData);
        [handles.lowI, handles.l1, handles.l2] = getdot(handles);
        [handles.r, handles.V] = rand2(handles);
        handles.iMean = getmean(handles);
        meansd(handles,1);
        guidata(hObject,handles);
    else
        continue
    end
V = handles.V;
r = handles.r;
potGet = handles.potGet;
bg = handles.bg;
end
end

