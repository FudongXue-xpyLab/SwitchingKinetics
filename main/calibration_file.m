function varargout = calibration_file(varargin)
% CALIBRATION_FILE MATLAB code for calibration_file.fig
%      CALIBRATION_FILE, by itself, creates a new CALIBRATION_FILE or raises the existing
%      singleton*.
%
%      H = CALIBRATION_FILE returns the handle to a new CALIBRATION_FILE or the handle to
%      the existing singleton*.
%
%      CALIBRATION_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATION_FILE.M with the given input arguments.
%
%      CALIBRATION_FILE('Property','Value',...) creates a new CALIBRATION_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calibration_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calibration_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calibration_file

% Last Modified by GUIDE v2.5 14-Dec-2018 11:59:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calibration_file_OpeningFcn, ...
                   'gui_OutputFcn',  @calibration_file_OutputFcn, ...
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


% --- Executes just before calibration_file is made visible.
function calibration_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calibration_file (see VARARGIN)

% Choose default command line output for calibration_file
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
uiwait(gcf);

% UIWAIT makes calibration_file wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calibration_file_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(gcf)


function bkedit_Callback(hObject, eventdata, handles)
% hObject    handle to bkedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bkedit as text
%        str2double(get(hObject,'String')) returns contents of bkedit as a double


% --- Executes during object creation, after setting all properties.
function bkedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bkedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ctrledit_Callback(hObject, eventdata, handles)
% hObject    handle to ctrledit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ctrledit as text
%        str2double(get(hObject,'String')) returns contents of ctrledit as a double


% --- Executes during object creation, after setting all properties.
function ctrledit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ctrledit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function matedit_Callback(hObject, eventdata, handles)
% hObject    handle to matedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of matedit as text
%        str2double(get(hObject,'String')) returns contents of matedit as a double


% --- Executes during object creation, after setting all properties.
function matedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bkbutton.
function bkbutton_Callback(hObject, eventdata, handles)
% hObject    handle to bkbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.tif', 'TIFF Files'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Image File');
if isequal([filename,pathname],[0,0])
    return                          %if have no file return
else
    file = fullfile(pathname,filename);
    handles.bk = imread(file);
    set(handles.bkedit,'string',file);
    if isfield(handles,'img')
        [calImg, clcbk] = precalbration(handles.bk, handles.img, handles.Center, handles.Radius);
        save('calibration.mat','calImg','clcbk')
        handles.defaultbg.calImg = calImg;
        handles.defaultbg.clcbk = clcbk;
    end
    guidata(hObject,handles);
end

% --- Executes on button press in ctrlbutton.
function ctrlbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ctrlbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.tif', 'TIFF Files'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Image File');
if isequal([filename,pathname],[0,0])
    return                          %if have no file return
else
    file = fullfile(pathname,filename);
    handles.img = imread(file);
    set(handles.ctrledit,'string',file);
    if isfield(handles,'bk')
        [calImg, clcbk] = precalbration(handles.bk, handles.img, handles.Center, handles.Radius, 1);
        save('calibration.mat','calImg','clcbk')
        handles.defaultbg.calImg = calImg;
        handles.defaultbg.clcbk = clcbk;
    end
    guidata(hObject,handles);
end

% --- Executes on button press in selbutton.
function selbutton_Callback(hObject, eventdata, handles)
% hObject    handle to selbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.mat', 'MAT-Files'; ...
        '*.*','All Files (*.*)'}, ...
    'Select mat File');
if isequal([filename,pathname],[0,0])
    return                          %if have no file return
else
    file = fullfile(pathname,filename);
    handles.defaultbg = load(file);
    set(handles.matedit,'string',file);
    guidata(hObject,handles);
end

% --- Executes on selection change in popup.
function popup_Callback(hObject, eventdata, handles)
% hObject    handle to popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.sel=get(hObject,'value');
if handles.sel == 1
    set(handles.selbutton,'Visible','off');
    set(handles.ctrlbutton,'Visible','on');
    set(handles.bkbutton,'Visible','on');
    set(handles.matedit,'Visible','off');
    set(handles.ctrledit,'Visible','on');
    set(handles.bkedit,'Visible','on');
else
    set(handles.selbutton,'Visible','on');
    set(handles.ctrlbutton,'Visible','off');
    set(handles.bkbutton,'Visible','off');
    set(handles.matedit,'Visible','on');
    set(handles.ctrledit,'Visible','off');
    set(handles.bkedit,'Visible','off');
end
guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup


% --- Executes during object creation, after setting all properties.
function popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okbutton.
function okbutton_Callback(hObject, eventdata, handles)
% hObject    handle to okbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = handles.defaultbg;
handles.output.Center = handles.Center;
handles.output.Radius = handles.Radius;
guidata(hObject, handles);
uiresume;

% --- Executes on button press in ccbutton.
function ccbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ccbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = [];
guidata(hObject, handles);
uiresume;



function photonPosion_Callback(hObject, eventdata, handles)
% hObject    handle to photonPosion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'String');
s = textscan(val,'%d','delimiter',',');
Center = s{1};
handles.Center = Center;
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of photonPosion as text
%        str2double(get(hObject,'String')) returns contents of photonPosion as a double


% --- Executes during object creation, after setting all properties.
function photonPosion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to photonPosion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','926,1282');
handles.Center = [926, 1282];
guidata(hObject, handles);


function photonR_Callback(hObject, eventdata, handles)
% hObject    handle to photonR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'String');
handles.Radius = str2double(val);
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of photonR as text
%        str2double(get(hObject,'String')) returns contents of photonR as a double


% --- Executes during object creation, after setting all properties.
function photonR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to photonR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','926');
handles.Radius = 926;
guidata(hObject, handles);