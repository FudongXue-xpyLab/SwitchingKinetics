function endpocess( handles )
%ENDPOCESS Summary of this function goes here
%   Detailed explanation goes here

    step = 1.0/double(handles.bg);
    if ~isfield(handles,'bgL')
        handles.bgL = 0;
    end
    if ~isfield(handles,'bgH')
        handles.bgH = handles.bg;
    end
    set(handles.sliderH,'max',handles.bg,'min',0,'SliderStep',[step 3*step],'value',handles.bgH);
    set(handles.sliderL,'max',handles.bg,'min',0,'SliderStep',[step 3*step],'value',handles.bgL);
    set(handles.sliderH,'Visible','on');
    set(handles.sliderL,'Visible','on');
    set(handles.text9,'Visible','on');
    set(handles.text10,'Visible','on');
    set(handles.mean_save,'enable','on');
    set(handles.dot_save,'enable','on');
    set(handles.slider1,'Visible','on');
    set(handles.playback,'Visible','on');
    set(handles.edit7,'Visible','on');
    if length(handles.filestr) == 1
        set(handles.text1,'string','File is saved!')
    else
        set(handles.text1,'string','All tif images are scanned!')
        set(handles.totalbar,'Visible','off');
        set(handles.listbox1,'Visible','on');
    end

end

