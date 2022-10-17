function varargout = index(varargin)
% INDEX MATLAB code for index.fig
%      INDEX, by itself, creates a new INDEX or raises the existing
%      singleton*.
%
%      H = INDEX returns the handle to a new INDEX or the handle to
%      the existing singleton*.
%
%      INDEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEX.M with the given input arguments.
%
%      INDEX('Property','Value',...) creates a new INDEX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before index_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to index_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help index

% Last Modified by GUIDE v2.5 22-Dec-2018 18:03:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @index_OpeningFcn, ...
                   'gui_OutputFcn',  @index_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before index is made visible.
function index_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to index (see VARARGIN)

% Choose default command line output for index
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes index wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = index_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Filelist_Callback(hObject, eventdata, handles)
% hObject    handle to Filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function editlist_Callback(hObject, eventdata, handles)
% hObject    handle to editlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mean_save_Callback(hObject, eventdata, handles)
% hObject    handle to mean_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
meansd(handles.iMean,handles.bg,handles.number,handles.file,handles.text1,handles.axes3,1);
set(handles.text1,'string','File is saved!')
set(handles.axes1,'visible','off');

% --------------------------------------------------------------------
function open_tif_Callback(hObject, eventdata, handles)
% hObject    handle to open_tif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
functiondir=cd;
addpath([functiondir '/main'])
[filename, pathname] = uigetfile( ...
    {'*.tif;*.tiff', 'All TIF-Files (*.tif,*.tiff)'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Image File','MultiSelect','on');
if isequal([filename,pathname],[0,0])
    return                          %if have no file return
else
    if ~iscell(filename)
        filename = {filename};
    end
    Num = length(filename);
    set(handles.axes1,'visible','on');
    if Num == 1
        filename = filename{1};
        handles.filestr{1} = fullfile(pathname,filename);
        handles.file = handles.filestr{1};
        Strfile = imfinfo(handles.file);
        x=Strfile.Height;
        y=Strfile.Width;
        leth=get(handles.leth,'String');
        leth = str2double(leth);
        if leth ~= 0
            handles.Height = min(leth,x);
            handles.Width = min(leth,y);
        else
            handles.Height = x;
            handles.Width = y;
        end
        handles.number = length(Strfile);
        handles.unCalData = cutread(handles.file,handles.number,leth);
        handles.bg = max(max(handles.unCalData(:,:,1)));
        axes(handles.axes1);
        cla reset;
        imshow(handles.unCalData(:,:,1),[]);
    else
        set(handles.listbox1,'string',filename);
        for f = 1:Num
            handles.filestr{f} = strcat(pathname,'\',filename{f});
        end
        handles.file = handles.filestr{1};
        Strfile = imfinfo(handles.file);
        x=Strfile.Height;
        y=Strfile.Width;
        leth=get(handles.leth,'String');
        leth = str2double(leth);
        if leth ~= 0
            handles.Height = min(leth,x);
            handles.Width = min(leth,y);
        else
            handles.Height = x;
            handles.Width = y;
        end
        handles.number = length(Strfile);
        handles.unCalData = cutread(handles.file,handles.number,leth);
        handles.bg = max(max(handles.unCalData(:,:,1)));
        axes(handles.axes1);
        cla reset;
        imshow(handles.unCalData(:,:,1),[]);
    end
end
startset( handles );
guidata(hObject, handles);

% --------------------------------------------------------------------
function open_file_Callback(hObject, eventdata, handles)
% hObject    handle to open_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
functiondir=cd;
addpath([functiondir '/main'])
path=uigetdir();
if path~=0
    num = 0;
    m = 1;
    files=dir(path);
    files = files(3:end);
    n=length(files);
    str=strcat(path,'\','*.tif');
    tFiles = dir(str);
    if ~isempty(tFiles)
        num = length(tFiles);
        filestr = cell(1,num);
        filename = cell(1,num);
        for iTh=1:num
            filename{iTh}=tFiles(iTh).name;
            filestr{iTh}=strcat(path,'\',filename{iTh});
        end
    else
        filestr=cell(1,m*n);
        filename = cell(1,m*n);
    end
    filedir = cell(1,n);
    for iDir=1:n
        filestr1 = strcat(path,'\',files(iDir).name,'\','*.tif');
        filedir{iDir} = dir(filestr1);
        m = max(m,length(filedir{iDir}));
    end
    [nrows, ~]= cellfun(@size, filedir);
    id = find(nrows==0);
    filedir(:,id) = [];
    files(id) =[];
    nFile = length(filedir);
    for iFile = 1:nFile
        for j = 1:m
            name = filedir{iFile}(j).name;
            filestr{iFile+num} = strcat(path,'\',files(iFile).name,'\',name);
            filename{iFile+num} = name;
            num = num +1;
            if j>length(filedir{iFile})
                break
            end
        end
        num = num -1;
    end
    set(handles.listbox1,'string',filename);
end
handles.filestr = filestr;           %get the all files
if ~iscell(filename)
    filename = {filename};
end
Num = length(filename);
set(handles.axes1,'visible','on');
if Num == 1
    filename = filename{1};
    handles.filestr{1} = fullfile(pathname,filename);
    handles.file = handles.filestr{1};
    Strfile = imfinfo(handles.file);
    x=Strfile.Height;
    y=Strfile.Width;
    leth=get(handles.leth,'String');
    leth = str2double(leth);
    if leth ~= 0
        handles.Height = min(leth,x);
        handles.Width = min(leth,y);
    else
        handles.Height = x;
        handles.Width = y;
    end
    handles.number = length(Strfile);
    handles.unCalData = cutread(handles.file,handles.number,leth);
    handles.bg = max(max(handles.unCalData(:,:,1)));
    axes(handles.axes1);
    
    imshow(handles.unCalData(:,:,1),[]);
else
    handles.file = handles.filestr{1};
    Strfile = imfinfo(handles.file);
    x=Strfile.Height;
    y=Strfile.Width;
    leth=get(handles.leth,'String');
    leth = str2double(leth);
    if leth ~= 0
        handles.Height = min(leth,x);
        handles.Width = min(leth,y);
    else
        handles.Height = x;
        handles.Width = y;
    end
    handles.number = length(Strfile);
    handles.unCalData = cutread(handles.file,handles.number,leth);
    handles.bg = max(max(handles.unCalData(:,:,1)));
    axes(handles.axes1);
    cla reset;
    imshow(handles.unCalData(:,:,1),[]);
end
startset( handles );
guidata(hObject,handles)

% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
meansd(handles,1);
close(gcf);



function background_Callback(hObject, eventdata, handles)
% hObject    handle to background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of background as text
%        str2double(get(hObject,'String')) returns contents of background as a double


% --- Executes during object creation, after setting all properties.
function background_CreateFcn(hObject, eventdata, handles)
% hObject    handle to background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function leth_Callback(hObject, eventdata, handles)
% hObject    handle to leth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
leth=str2double(get(hObject,'String'));
if (isempty(leth))
    set(hObject,'String','0')
end
if isfield(handles,'unCalData')
    Strfile = imfinfo(handles.file);
    x=Strfile.Height;
    y=Strfile.Width;
    if leth ~= 0
        handles.Height = min(leth,x);
        handles.Width = min(leth,y);
    else
        handles.Height = x;
        handles.Width = y;
    end
    handles.unCalData = cutread(handles.file,handles.number,leth);
    axes(handles.axes1);
    cla reset;
    imshow(handles.unCalData(:,:,1),[]);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of leth as text
%        str2double(get(hObject,'String')) returns contents of leth as a double


% --- Executes during object creation, after setting all properties.
function leth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dots_Callback(hObject, eventdata, handles)
% hObject    handle to dots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=str2double(get(hObject,'String'));
if (isempty(input))
    set(hObject,'String','0')
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of dots as text
%        str2double(get(hObject,'String')) returns contents of dots as a double


% --- Executes during object creation, after setting all properties.
function dots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.totalbar,'Visible','off');
if get(handles.optDot,'value')
    prompt = {'Enter the length:(inch)','Enter the width:(inch)'};
    dlg_title = 'Input tif inches';
    num_lines = 1;
    def = {'7.95','5.3'};
    handles.Inch = inputdlg(prompt,dlg_title,num_lines,def);
end
if isfield(handles,'defaultbg')&&~isempty(handles.defaultbg)
    leth=get(handles.leth,'String');
    leth = str2double(leth);
    clcbk = cutimg(handles.defaultbg.clcbk,leth);
    calhigh = cutimg(handles.defaultbg.calImg,leth);
    Radius = handles.defaultbg.Radius;
    Center = handles.defaultbg.Center;
    handles.iUseData = cali_process( handles.unCalData, clcbk, calhigh, Radius, Center);
    cal = 1;
else
    handles.iUseData = handles.unCalData;
    cal = 0;
end
[handles.bg, handles.np, handles.potGet] = getrdpot(handles.iUseData, cal);
handles.loc = zone_identification(handles);
[handles.r, handles.V, handles.locRd] = getMax(handles);
% [handles.r, handles.V, handles.locRd] = rand2(handles);
[handles.iMean, dist2center] = getmean(handles);
meansd(handles.iMean, handles.bg, handles.number, handles.file, dist2center, 1);
if get(handles.optDot,'value')
    dotsave(handles);
end
file_name = handles.file;
t=strfind(file_name,'.tif');
filebase=file_name(1:t-1);
matname = [filebase,'_result.mat'];
matsave(matname,handles);
guidata(hObject, handles);
endpocess(handles);


% --- Executes on button press in autobutton.
function autobutton_Callback(hObject, eventdata, handles)
% hObject    handle to autobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(handles.listbox1,'Visible','off');
    set(handles.slider1,'Visible','off');
    auNumber = length(handles.filestr);
    if get(handles.optDot,'value')
        prompt = {'Enter the length:(inch)','Enter the width:(inch)'};
        dlg_title = 'Input tif inches';
        num_lines = 1;
        def = {'7.95','5.3'};
        handles.Inch = inputdlg(prompt,dlg_title,num_lines,def);
    end
    set(handles.totalbar,'Visible','on');
    % mywaitbar(0,handles.totalbar,'');
    set(handles.totalbar,'String','Totalbar 0%');
    leth = get(handles.leth,'String');
    leth = str2double(leth);
    for iNum = 1:auNumber
        handles.file = handles.filestr{iNum};
        if ~isempty(handles.file)
            Strfile = imfinfo(handles.file);
            x=Strfile.Height;
            y=Strfile.Width;
            if leth ~= 0
                handles.Height = min(leth,x);
                handles.Width = min(leth,y);
            else
                handles.Height = x;
                handles.Width = y;
            end
            handles.number = length(Strfile);
            if isfield(handles,'defaultbg')&&~isempty(handles.defaultbg)
                handles.unCalData = cutread(handles.file,handles.number,leth);
                clcbk = cutimg(handles.defaultbg.clcbk,leth);
                calhigh = cutimg(handles.defaultbg.calImg,leth);
                Radius = handles.defaultbg.Radius;
                Center = handles.defaultbg.Center;
                handles.iUseData = cali_process( handles.unCalData, clcbk, calhigh, Radius, Center);
                cal = 1;
            else
                handles.iUseData = cutread(handles.file,handles.number,leth);
                cal = 0;
            end
            [handles.bg, handles.np, handles.potGet] = getrdpot(handles.iUseData, cal);
            
            handles.loc = zone_identification(handles);
            [handles.r, handles.V, handles.locRd] = getMax(handles);
            %  [handles.r, handles.V, handles.locRd] = rand2(handles);
            [handles.iMean,dist2center] = getmean(handles);
            saveimg(handels);
            meansd(handles.iMean,handles.bg,handles.number,handles.file,dist2center, 1);
            if get(handles.optDot,'value')
            	dotsave(handles);
            end
            file_name = handles.file;
            t=strfind(file_name,'.tif');
            filebase=file_name(1:t-1);
            matname = [filebase,'_result.mat'];
            matsave(matname,handles);
            handles.numberi{iNum} = handles.number;
            handles.iUseDatai{iNum} = handles.iUseData;
            handles.bgi{iNum} = handles.bg;
            handles.potGeti{iNum} = handles.potGet;
            handles.ri{iNum} = handles.r;
            handles.Vi{iNum} = handles.V;
        else
            continue
        end
        plan = iNum/auNumber;
        set(handles.listbox1,'value',iNum);
        %
        set(handles.totalbar,'String',['Totalbar ',num2str(floor(100*plan)),'%']);
    end
    % [handles.r, handles.V, handles.iUseData, handles.bg] = autorun(hObject,handles);
    guidata(hObject,handles);
    endpocess(handles);
catch err
    h=errordlg(err.message);
    waitfor(h);
end


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.message,'visible','on')
set(handles.text1,'string','Submit finished!')


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
book = get(handles.listbox1,'Value');
book=uint16(book);
handles.V = handles.Vi{book};
handles.r = handles.ri{book};
handles.bg = handles.bgi{book};
handles.number = handles.numberi{book};
handles.iUseData = handles.iUseDatai{book};
handles.file = handles.filestr{book};
guidata(hObject,handles);
slider1_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in debakgd.
function debakgd_Callback(hObject, eventdata, handles)
% hObject    handle to debakgd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
functiondir=cd;
addpath([functiondir '/main'])
handles.defaultbg = [];
handles.defaultbg = calibration_file(handles.defaultbg);
set(handles.background,'string','loaded!');
guidata(hObject,handles);


% --------------------------------------------------------------------
function dot_save_Callback(hObject, eventdata, handles)
% hObject    handle to dot_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter the length:','Enter the width:'};
dlg_title = 'Input tif inches';
num_lines = 1;
def = {'7.95','5.3'};
handles.Inch = inputdlg(prompt,dlg_title,num_lines,def);
optimum = dotsave(handles);
title = 'The best bacterial position.';
msgbox(optimum,title);
set(handles.text1,'string','The optimal dot is saved in dataget.txt!')


function size_Callback(hObject, eventdata, handles)
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=str2double(get(hObject,'String'));
if (isempty(input))
    set(hObject,'String','0')
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of size as text
%        str2double(get(hObject,'String')) returns contents of size as a double


% --- Executes during object creation, after setting all properties.
function size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optDot.
function optDot_Callback(hObject, eventdata, handles)
% hObject    handle to optDot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optDot



function scale_Callback(hObject, eventdata, handles)
% hObject    handle to scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=str2double(get(hObject,'String'));
if (isempty(input))
    set(hObject,'String','0.7')
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of scale as text
%        str2double(get(hObject,'String')) returns contents of scale as a double


% --- Executes during object creation, after setting all properties.
function scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function save_view_Callback(hObject, eventdata, handles)
% hObject    handle to save_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
functiondir=cd;
addpath([functiondir '/main'])
[filename, pathname] = uigetfile( ...
    {'*.mat', 'mat-Files'; ...
        '*.*','All Files (*.*)'}, ...
    'Select text File');
if isequal([filename,pathname],[0,0])
    return                          %if have no file return
else
    file = fullfile(pathname,filename);
    loadData = load(file);
    if isfield(loadData,'result')
        handles.iUseData = loadData.result.iUseData;
        handles.V = loadData.result.V;
        handles.r = loadData.result.r;
        handles.bg = loadData.result.bg;
        handles.number = loadData.result.number;
        handles.file = loadData.result.file;
        handles.Vi = {handles.V};
        paper = handles.number;
    else
        handles.iUseData = loadData.handles.iUseData;
        handles.V = loadData.handles.V;
        handles.r = loadData.handles.r;
        handles.bg = loadData.handles.bg;
        handles.number = loadData.handles.number;
        handles.file = loadData.handles.file;
        handles.Vi = {handles.V};
        paper = handles.number;
    end
    cla reset;
    imshow(handles.iUseData(:,:,1),[]);
    step=1.0/(paper-1);
    set(handles.slider1,'max',1.0,'min',0,'SliderStep',[step 3*step],'value',0);
    guidata(hObject,handles);
    set(handles.axes1,'visible','on');
    set(handles.slider1,'Visible','on');
    set(handles.listbox1,'Visible','off');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in playback.
function playback_Callback(hObject, eventdata, handles)
% hObject    handle to playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.edit7,'String');
t = strfind(val,':');
if length(t) == 1
    sel = str2double(val(t-1)):str2double(val(t+1));
elseif (length(t) == 2)&&(t(1)+1 == t(2)-1)
    sel = str2double(val(t(1)-1)):str2double(val(t(1)+1)):str2double(val(t(2)+1));
elseif isempty(t)
    s = textscan(val,'%d','delimiter',',');
    sel = s{1};
end
sel(sel == 0) = [];
handles.sel = sel;
if ~isfield(handles,'bgL')
    handles.bgL = 0;
end
if ~isfield(handles,'bgH')
    handles.bgH = handles.bg;
end
guidata(hObject,handles);
findbacteral(handles.iUseData, handles.V, handles.r, [handles.bgL handles.bgH], handles.file, sel);



function hFrame_Callback(hObject, eventdata, handles)
% hObject    handle to hFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of hFrame as text
%        str2double(get(hObject,'String')) returns contents of hFrame as a double


% --- Executes during object creation, after setting all properties.
function hFrame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
j=get(handles.slider1,'Value')*(handles.number-1)+1;
j=uint16(j);
handles.j = j;
axes(handles.axes1);
cla;
if isfield(handles,'iUseData')
    showImg = handles.iUseData(:,:,j);
else
    showImg = handles.unCalData(:,:,j);
end
if ~isfield(handles,'bgL')
    handles.bgL = 0;
end
if ~isfield(handles,'bgH')
    handles.bgH = handles.bg;
end
imshow(showImg,[handles.bgL handles.bgH]);
if isfield(handles,'V')
    V = handles.V;
else
    V = [];
end
FileStr = handles.file;
theta=0:0.01*pi:2*pi;
hold on
if ~isempty(V)
    r = handles.r;
    if ~isfield(handles, 'sel')
        for i = 1:length(V(:,1))
            x=r(i)*cos(theta)+V(i,2);
            y=r(i)*sin(theta)+V(i,1);
            line(x, y,'color','b');
            no = num2str(i);
            text(V(i,2)+r(i),V(i,1),no,'Color','y');
        end
    else
        sel = handles.sel;
        if sel == 0
            sel = 1:length(V(:,1));
        end

        mn = length(sel);
        for i = 1:mn
            x=r(sel(i))*cos(theta)+V(sel(i),2);
            y=r(sel(i))*sin(theta)+V(sel(i),1);
            line(x, y,'color','b');
            no = num2str(sel(i));
            text(V(sel(i),2)+r(sel(i)),V(sel(i),1),no,'Color','y');
        end
    end
end
hold off
fstr=strcat(FileStr,'. Image #:',int2str(j),'/',num2str(handles.number));
set(findobj('Tag','image_number'),'String',fstr);
set(findobj('Tag','image_number'),'Visible','on');
guidata(hObject,handles);  


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function sliderH_Callback(hObject, eventdata, handles)
% hObject    handle to sliderH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(hObject,'Value');
j=uint16(j);

handles.bgH = j;
if ~isfield(handles,'bgL')
    handles.bgL = 0;
elseif handles.bgL > j
    handles.bgL = j;
    set(handles.sliderL,'value',j);
    set(handles.text10,'String',num2str(handles.bgH));
end
if ~isfield(handles,'j')
    handles.j = 1;
end
axes(handles.axes1);
cla;
if isfield(handles,'iUseData')
    showImg = handles.iUseData(:,:,handles.j);
else
    showImg = handles.unCalData(:,:,handles.j);
end
imshow(showImg,[handles.bgL handles.bgH]);
if isfield(handles,'V')
    V = handles.V;
else
    V = [];
end
theta=0:0.01*pi:2*pi;
hold on
if ~isempty(V)
    r = handles.r;
    if ~isfield(handles, 'sel')
        for i = 1:length(V(:,1))
            x=r(i)*cos(theta)+V(i,2);
            y=r(i)*sin(theta)+V(i,1);
            line(x, y,'color','b');
            no = num2str(i);
            text(V(i,2)+r(i),V(i,1),no,'Color','y');
        end
    else
        sel = handles.sel;
        if sel == 0
            sel = 1:length(V(:,1));
        end

        mn = length(sel);
        for i = 1:mn
            x=r(sel(i))*cos(theta)+V(sel(i),2);
            y=r(sel(i))*sin(theta)+V(sel(i),1);
            line(x, y,'color','b');
            no = num2str(sel(i));
            text(V(sel(i),2)+r(sel(i)),V(sel(i),1),no,'Color','y');
        end
    end
end
hold off
set(handles.text9,'String',num2str(handles.bgH))
guidata(hObject,handles);  
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderL_Callback(hObject, eventdata, handles)
% hObject    handle to sliderL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(hObject,'Value');
j=uint16(j);
handles.bgL = j;
if ~isfield(handles,'bgH')
    handles.bgH = handles.bg;
elseif handles.bgH < j
    handles.bgH = j;
    set(handles.sliderH,'value',j);
    set(handles.text9,'String',num2str(handles.bgL));
end
if ~isfield(handles,'j')
    handles.j = 1;
end
axes(handles.axes1);
cla;
if isfield(handles,'iUseData')
    showImg = handles.iUseData(:,:,handles.j);
else
    showImg = handles.unCalData(:,:,handles.j);
end
imshow(showImg,[handles.bgL handles.bgH]);
if isfield(handles,'V')
    V = handles.V;
else
    V = [];
end
theta=0:0.01*pi:2*pi;
hold on
if ~isempty(V)
    r = handles.r;
    if ~isfield(handles, 'sel')
        for i = 1:length(V(:,1))
            x=r(i)*cos(theta)+V(i,2);
            y=r(i)*sin(theta)+V(i,1);
            line(x, y,'color','b');
            no = num2str(i);
            text(V(i,2)+r(i),V(i,1),no,'Color','y');
        end
    else
        sel = handles.sel;
        if sel == 0
            sel = 1:length(V(:,1));
        end

        mn = length(sel);
        for i = 1:mn
            x=r(sel(i))*cos(theta)+V(sel(i),2);
            y=r(sel(i))*sin(theta)+V(sel(i),1);
            line(x, y,'color','b');
            no = num2str(sel(i));
            text(V(sel(i),2)+r(sel(i)),V(sel(i),1),no,'Color','y');
        end
    end
end
hold off
set(handles.text10,'String',num2str(handles.bgL))
guidata(hObject,handles);  
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
