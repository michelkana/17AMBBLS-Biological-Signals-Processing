function varargout = BioProject1(varargin)
% BIOPROJECT1 MATLAB code for BioProject1.fig
%      BIOPROJECT1, by itself, creates a new BIOPROJECT1 or raises the existing
%      singleton*.
%
%      H = BIOPROJECT1 returns the handle to a new BIOPROJECT1 or the handle to
%      the existing singleton*.
%
%      BIOPROJECT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIOPROJECT1.M with the given input arguments.
%
%      BIOPROJECT1('Property','Value',...) creates a new BIOPROJECT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BioProject1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BioProject1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BioProject1

% Last Modified by GUIDE v2.5 02-Jun-2014 19:18:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BioProject1_OpeningFcn, ...
                   'gui_OutputFcn',  @BioProject1_OutputFcn, ...
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


% --- Executes just before BioProject1 is made visible.
function BioProject1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BioProject1 (see VARARGIN)

% Choose default command line output for BioProject1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BioProject1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BioProject1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% -------------------------------------------------------------------------
% --- Executes on button press in Load_EEG.
function Load_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Load_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject)
[filename,filepath]=uigetfile({'*.*','All Files'},'Select EEG File');
fullpathname=strcat(filepath, filename);
set(handles.text_path, 'String', fullpathname)
handles.rawdata1=load(fullpathname)
guidata(hObject, handles);


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function Logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate Logo
imshow ('Logo CVUT.png')


% -------------------------------------------------------------------------
function text_path_Callback(hObject, eventdata, handles)
% hObject    handle to text_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_path as text
%        str2double(get(hObject,'String')) returns contents of text_path as a double


% --- Executes during object creation, after setting all properties.
function text_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function in_col_Callback(hObject, eventdata, handles)
% hObject    handle to in_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of in_col as text
%        str2double(get(hObject,'String')) returns contents of in_col as a double
handles = guidata(hObject)
handles.column1 = str2double(get(hObject,'String'));
if isnan(handles.column1) || ~isreal(handles.column1)
    set(handles.compute,'String','Wrong Column')
    set(handles.compute,'Enable','off')
    uicontrol(hObject)
else 
    set(handles.compute,'String','COMPUTE')
    set(handles.compute,'Enable','on')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function in_col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to in_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function in_fre_Callback(hObject, eventdata, handles)
% hObject    handle to in_fre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of in_fre as text
%        str2double(get(hObject,'String')) returns contents of in_fre as a double
handles = guidata(hObject)
handles.fs1 = str2double(get(hObject,'String'));
if isnan(handles.fs1) || ~isreal(handles.fs1)
    set(handles.compute,'String','Wrong Frecuency')
    set(handles.compute,'Enable','off')
    uicontrol(hObject)
else 
    set(handles.compute,'String','COMPUTE')
    set(handles.compute,'Enable','on')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function in_fre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to in_fre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function in_sta_Callback(hObject, eventdata, handles)
% hObject    handle to in_sta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of in_sta as text
%        str2double(get(hObject,'String')) returns contents of in_sta as a double
handles = guidata(hObject)
handles.t11 = str2double(get(hObject,'String'));
if isnan(handles.t11) 
    set(handles.compute,'String','Wrong Start Time')
    set(handles.compute,'Enable','off')
    uicontrol(hObject)
else 
    set(handles.compute,'String','COMPUTE')
    set(handles.compute,'Enable','on')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function in_sta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to in_sta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function in_end_Callback(hObject, eventdata, handles)
% hObject    handle to in_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of in_end as text
%        str2double(get(hObject,'String')) returns contents of in_end as a double
handles = guidata(hObject)
handles.t21 = str2double(get(hObject,'String'));
if isnan(handles.t21) 
    set(handles.compute,'String','Wrong End Time')
    set(handles.compute,'Enable','off')
    uicontrol(hObject)
else 
    set(handles.compute,'String','COMPUTE')
    set(handles.compute,'Enable','on')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function in_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to in_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
% --- Executes on button press in Filter_Menu.
function Filter_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Filter_Menu
handles = guidata(hObject)
handles.Filter1 = (get(hObject,'Value'));
guidata(hObject, handles);


% -------------------------------------------------------------------------
% --- Executes on selection change in Wave_Menu.
function Wave_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Wave_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns Wave_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Wave_Menu
handles = guidata(hObject)
handles.Wave1 = (get(hObject,'Value'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Wave_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Wave_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function STD1_Callback(hObject, eventdata, handles)
% hObject    handle to STD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of STD1 as text
%        str2double(get(hObject,'String')) returns contents of STD1 as a double


% --- Executes during object creation, after setting all properties.
function STD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to STD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function AVG1_Callback(hObject, eventdata, handles)
% hObject    handle to AVG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AVG1 as text
%        str2double(get(hObject,'String')) returns contents of AVG1 as a double


% --- Executes during object creation, after setting all properties.
function AVG1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AVG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
function CC1_Callback(hObject, eventdata, handles)
% hObject    handle to CC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC1 as text
%        str2double(get(hObject,'String')) returns contents of CC1 as a double


% --- Executes during object creation, after setting all properties.
function CC1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------
% --- Executes on button press in compute.
function compute_Callback(hObject, eventdata, handles)
% hObject    handle to compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject); 

% INPUT FROM USER
vector=handles.rawdata1 % ARRAY WITH EEG DATA
column=handles.column1  % COLUMN WHERE EEG DATA IS STORED
fs=handles.fs1          % SAMPLING FRECUENCY
t1=handles.t11          % START TIME
t2=handles.t21          % END TIME
filtro=handles.Filter1  % IF 1 FILTER, IF 0 DONT FILTER
wave=handles.Wave1      % 1=DELTA, 2=THETA, 3=ALPHA, 4=BETA, 5=GAMMA 

Data=vector(:,column);
t=t1:1/fs:t2;
data1=Data(fs*t1+1:fs*t2+1)

% FILTERING

if filtro == 1;
  
k = 0.003;
f1n = (50/(fs/2)) - k;
f2n = (50/(fs/2)) + k;
f1l = (90/(fs/2)) - k;
f2l = (90/(fs/2)) + k;
f1h = (0.5/(fs/2)) - k;
f2h = (0.5/(fs/2)) + k;

%FIR FILTERS
a = fir1(100,[f1n f2n], 'stop'); %50hz notch filter
y = filter(a,1,data1);
b = fir1(100,[f1l f2l], 'low'); %90Hz lowpass filter
x0 = filter(b,1,y);
c = fir1(100,[f1h f2h], 'high'); %0.5Hz highpass filter
x = filter(c,1,x0);

else
    x = data1;
end

% COMPUTING
fur=real(fftshift(fft(x)))
m=length(x)
B=zeros(m);

switch wave

case 1
    curve='Delta'
    B(round(m/2-0.5*m/fs):round(m/2-4*m/fs))=fur(round(m/2-0.5*m/fs):round(m/2-4*m/fs))        
    B(round(m/2+0.5*m/fs):round(m/2+4*m/fs))=fur(round(m/2+0.5*m/fs):round(m/2+4*m/fs))

case 2
    curve='Theta'
    B(round(m/2-4*m/fs):round(m/2-8*m/fs))=fur(round(m/2-4*m/fs):round(m/2-8*m/fs))        
    B(round(m/2+4*m/fs):round(m/2+8*m/fs))=fur(round(m/2+4*m/fs):round(m/2+8*m/fs))

case 3
    curve='Alpha'
    B(round(m/2-8*m/fs):round(m/2-16*m/fs))=fur(round(m/2-8*m/fs):round(m/2-16*m/fs))        
    B(round(m/2+8*m/fs):round(m/2+16*m/fs))=fur(round(m/2+8*m/fs):round(m/2+16*m/fs))

case 4
    curve='Beta'
    B(round(m/2-32*m/fs):round(m/2-16*m/fs))=fur(round(m/2-32*m/fs):round(m/2-16*m/fs))        
    B(round(m/2+16*m/fs):round(m/2+32*m/fs))=fur(round(m/2+16*m/fs):round(m/2+32*m/fs))

case 5
    curve='Gamma'
    B(round(m/2-32*m/fs):0)=fur(round(m/2-32*m/fs):0)        
    B(round(m/2+32*m/fs):m)=fur(round(m/2+32*m/fs):m)
end
if (0<wave)&&(wave<6)
z=rot90(real(sum(rot90(ifft(fftshift(B))))),3);

else
    z=x
end

     
Sdev=std(z)
Avg=mean(z)
Cc=0
tr=0
for F = 2:m
    E=F-1;
    if tr==1
        if z(F)<z(E)
            Cc=Cc+1
            tr=-1
        end
    end
    if z(F)<z(E)
        tr=-1
    else
        tr=1
    end
end

STD=Sdev;
AVG=Avg;
CC=Cc;


% OUTPUT TO DISPLAY
plot(handles.plot1,t,data1)
plot(handles.plot2,t,z)

set(handles.Sel_wave,'String',curve)
set(handles.STD1, 'String', STD)
set(handles.AVG1, 'String', AVG)
set(handles.CC1, 'String', CC)
guidata(hObject, handles)
