function varargout = firstgui(varargin)
% FIRSTGUI M-file for firstgui.fig
%      FIRSTGUI, by itself, creates a new FIRSTGUI or raises the existing
%      singleton*.
%
%      H = FIRSTGUI returns the handle to a new FIRSTGUI or the handle to
%      the existing singleton*.
%
%      FIRSTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTGUI.M with the given input arguments.
%
%      FIRSTGUI('Property','Value',...) creates a new FIRSTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firstgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firstgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firstgui

% Last Modified by GUIDE v2.5 21-May-2013 00:53:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @firstgui_OpeningFcn, ...
                   'gui_OutputFcn',  @firstgui_OutputFcn, ...
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


% --- Executes just before firstgui is made visible.
function firstgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firstgui (see VARARGIN)
handles.counter=0;
% Choose default command line output for firstgui
handles.output = hObject;
handles.y2=0;
handles.x2=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes firstgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = firstgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadfile.
function loadfile_Callback(hObject, eventdata, handles)
% hObject    handle to loadfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=uigetfile('.txt');
data=importdata(filename);
handles.xaxis=data.data(:,1);
handles.yaxis=data.data(:,2);
handles.fa=round(length(handles.xaxis)/handles.xaxis(length(handles.xaxis)));
handles.fa2=handles.fa;
handles.T=length(handles.yaxis)/handles.fa2;
set(handles.samplingr,'string',handles.fa);
plot(handles.axes1,handles.xaxis,handles.yaxis);
plot(handles.axes1,handles.xaxis,handles.yaxis);
title(handles.axes1,'Rohdaten EMG');
xlabel(handles.axes1,'Zeit/s');
ylabel(handles.axes1,'Amplitude');
guidata(hObject,handles);




% --- Executes on button press in filter.
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wu=30/handles.fa;
wo=250/handles.fa;
[b1,a1]=butter(2,2*wu,'high');
y=filtfilt(b1,a1,handles.yaxis);
set(handles.samplingr,'string',handles.fa);
handles.fa2=handles.fa;

%250 Hz lowpass only necessary if the sampling rate is higher
if handles.fa>=250 && handles.counter==0
        [b3,a3]=butter(2,2*wo,'low');
        y3=filtfilt(b3,a3,y);
        [b2,a2]=butter(2,[59/handles.fa,61/handles.fa],'stop');
        handles.y2=filtfilt(b2,a2,y3);
    
else 
    [b2,a2]=butter(2,[59/handles.fa,61/handles.fa],'stop');
    handles.y2=filtfilt(b2,a2,y);
end
handles.x2=handles.xaxis;
plot(handles.axes2,handles.x2,handles.y2);
title(handles.axes2,'Filtered EMG');
xlabel(handles.axes2,'Zeit/s');
ylabel(handles.axes2,'Amplitude');
guidata(hObject,handles);





% --- Executes on button press in resample.
function resample_Callback(hObject, eventdata, handles)
% hObject    handle to resample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.y2==0
    yaxisnew=resample(handles.yaxis,handles.fanew,handles.fa2);
    new=0:1/handles.fanew:30-1/handles.fanew;
    plot(handles.axes2,new,yaxisnew);
    title(handles.axes2,'Resampled EMG');
    xlabel(handles.axes2,'Zeit/s');
    ylabel(handles.axes2,'Amplitude');
    handles.y2=yaxisnew;
    handles.fa2=handles.fanew;
    handles.x2=new;
else
yaxisnew=resample(handles.y2,handles.fanew,handles.fa2);
new=0:1/handles.fanew:30-1/handles.fanew;
plot(handles.axes2,new,yaxisnew);
title(handles.axes2,'Resampled EMG');
xlabel(handles.axes2,'Zeit/s');
ylabel(handles.axes2,'Amplitude');
handles.y2=yaxisnew;
handles.fa2=handles.fanew;
handles.x2=new;
end
handles.counter=1;
guidata(hObject,handles);




function samplingr_Callback(hObject, eventdata, handles)
% hObject    handle to samplingr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingr as text
%        str2double(get(hObject,'String')) returns contents of samplingr as a double

handles.fanew=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function samplingr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rectify.
function rectify_Callback(hObject, eventdata, handles)
% hObject    handle to rectify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.y2=abs(handles.y2);
plot(handles.axes2,handles.x2,handles.y2);
title(handles.axes2,'Rectified EMG');
xlabel(handles.axes2,'Zeit/s');
ylabel(handles.axes2,'Amplitude');
guidata(hObject,handles);



% --- Executes on button press in fft.
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start1=handles.fa2*handles.startpoint;
end1=handles.fa2*handles.endpoint;
ytransform=handles.y2(start1:end1);
T=length(ytransform)/handles.fa2;
xfft=-handles.fa2/2:1/T:handles.fa2/2-1/T;
yfft=fft(ytransform);
plot(handles.axes2,xfft,fftshift(abs(yfft)));
title(handles.axes2,'FFT Plot');
xlabel(handles.axes2,'Frequency/Hz');
ylabel(handles.axes2,'Amplitude');



function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start as text
%        str2double(get(hObject,'String')) returns contents of start as a double
handles.startpoint=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end2_Callback(hObject, eventdata, handles)
% hObject    handle to end2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of end2 as text
%        str2double(get(hObject,'String')) returns contents of end2 as a double
handles.endpoint=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function end2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rms_Callback(hObject, eventdata, handles)
% hObject    handle to rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rms as text
%        str2double(get(hObject,'String')) returns contents of rms as a double


% --- Executes during object creation, after setting all properties.
function rms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RMS.
function RMS_Callback(hObject, eventdata, handles)
% hObject    handle to RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yrms=handles.yaxis(handles.fa*handles.startpoint:handles.fa*handles.endpoint);
rms=sqrt(mean(yrms.^2));
set(handles.rms,'string',rms);


% --- Executes on button press in AVR.
function AVR_Callback(hObject, eventdata, handles)
% hObject    handle to AVR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yavr=handles.y2(handles.fa2*handles.startpoint:handles.fa2*handles.endpoint);
avr=sum(yavr);
set(handles.avr,'string',avr);



function avr_Callback(hObject, eventdata, handles)
% hObject    handle to avr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avr as text
%        str2double(get(hObject,'String')) returns contents of avr as a double


% --- Executes during object creation, after setting all properties.
function avr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
