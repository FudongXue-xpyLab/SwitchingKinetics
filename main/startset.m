function startset( handles )
%STARTSET Summary of this function goes here
%   Detailed explanation goes here

    step = 1.0/double(handles.bg);
    set(handles.sliderH,'max',handles.bg,'min',0,'SliderStep',[step 3*step],'value',handles.bg);
    set(handles.sliderL,'max',handles.bg,'min',0,'SliderStep',[step 3*step],'value',0);
    set(handles.sliderH,'Visible','on');
    set(handles.sliderL,'Visible','on');
    set(handles.text9,'Visible','on');
    set(handles.text10,'Visible','on');
    set(handles.totalbar,'Visible','off');
    set(handles.slider1,'Visible','on');
    set(handles.playback,'Visible','off');
    set(handles.edit7,'Visible','off');
    if length(handles.filestr) == 1
        set(handles.pushbutton1,'visible','on');
        set(handles.listbox1,'Visible','off');
        set(handles.autobutton,'visible','off');
        set(handles.text1,'string','Preparing finished! Push Run to begain!')
    else
        set(handles.pushbutton1,'visible','off');
        set(handles.listbox1,'Visible','on');
        set(handles.autobutton,'visible','on');
        set(handles.text1,'string','Preparing finished! Push Autorun to begain!')
    end
end

