function varargout = Browserfile(varargin)
% BROWSERFILE MATLAB code for Browserfile.fig
%      BROWSERFILE, by itself, creates a new BROWSERFILE or raises the existing
%      singleton*.
%
%      H = BROWSERFILE returns the handle to a new BROWSERFILE or the handle to
%      the existing singleton*.
%
%      BROWSERFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BROWSERFILE.M with the given input arguments.
%
%      BROWSERFILE('Property','Value',...) creates a new BROWSERFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Browserfile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Browserfile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Browserfile

% Last Modified by GUIDE v2.5 19-May-2013 15:10:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Browserfile_OpeningFcn, ...
                   'gui_OutputFcn',  @Browserfile_OutputFcn, ...
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


% --- Executes just before Browserfile is made visible.
function Browserfile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Browserfile (see VARARGIN)

% Choose default command line output for Browserfile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Browserfile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Browserfile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.txt'},'File Selector'); 
fullpathname = strcat(pathname, filename);
text = fileread(fullpathname); 
set(handles.text2, 'String', fullpathname) % showing FullPathName

column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;

x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest
plot(data); 

s = std(data); % Find standard deviation
set(handles.text12, 'String', s) % Write standard deviation
mean_amplitude = mean(data); % Find mean amplitude
set(handles.text13, 'String', mean_amplitude); % Write mean amplitude

function column_value_Callback(hObject, eventdata, handles)
% hObject    handle to column_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of column_value as text
%        str2double(get(hObject,'String')) returns contents of column_value as a double
fullpathname = get(handles.text2, 'string');

column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;

x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest
plot(data);

s = std(data); % Find standard deviation
set(handles.text12, 'String', s) % Write standard deviation
mean_amplitude = mean(data); % Find mean amplitude
set(handles.text13, 'String', mean_amplitude); % Write mean amplitude

% --- Executes during object creation, after setting all properties.
function column_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to column_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullpathname = get(handles.text2, 'string');
column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;
x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest

N = 1000; % Order

        Fstop1 = 0.1; % First Stopband Frequency
        Fpass1 = 0.3; % First Passband Frequency
        Fpass2 = 35; % Second Passband Frequency
        Fstop2 = 40; % Second Stopband Frequency
        Wstop1 = 10; % First Stopband Weight
        Wpass = 1; % Passband Weight
        Wstop2 = 10; % Second Stopband Weight
        dens = 20; % Density Factor

        % Calculate the coefficients using the FIRPM function.
        b = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
        0], [Wstop1 Wpass Wstop2], {dens});
        DataFilt = filtfilt(b,1,data);
        
        plot(DataFilt);
        s = std(DataFilt); % Find standard deviation
        set(handles.text12, 'String', s) % Write standard deviation
        mean_amplitude = mean(DataFilt); % Find mean amplitude
        set(handles.text13, 'String', mean_amplitude); % Write mean amplitude

function freq_value_Callback(hObject, eventdata, handles)
% hObject    handle to freq_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq_value as text
%        str2double(get(hObject,'String')) returns contents of freq_value as a double
fullpathname = get(handles.text2, 'string');

column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;

x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest
plot(data);

s = std(data); % Find standard deviation
set(handles.text12, 'String', s) % Write standard deviation
mean_amplitude = mean(data); % Find mean amplitude
set(handles.text13, 'String', mean_amplitude); % Write mean amplitude


% --- Executes during object creation, after setting all properties.
function freq_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

fullpathname = get(handles.text2, 'string');
column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;
x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest

N = 1000; % Order
a = get(handles.popupmenu2, 'value'); 

switch a 
    case 1 % basic wave
        plot(data);
        s = std(data); % Find standard deviation
        set(handles.text12, 'String', s) % Write standard deviation
        mean_amplitude = mean(data); % Find mean amplitude
        set(handles.text13, 'String', mean_amplitude); % Write mean amplitude
        
    case 2 % delta wave (0.5-4 Hz)
        Fstop1 = 0.2; % First Stopband Frequency
        Fpass1 = 0.5; % First Passband Frequency
        Fpass2 = 4; % Second Passband Frequency
        Fstop2 = 4.5; % Second Stopband Frequency
        Wstop1 = 10; % First Stopband Weight
        Wpass = 1; % Passband Weight
        Wstop2 = 10; % Second Stopband Weight
        dens = 20; % Density Factor

        % Calculate the coefficients using the FIRPM function.
        b = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
        0], [Wstop1 Wpass Wstop2], {dens});
        DataFilt = filtfilt(b,1,data);
        
        plot(DataFilt);
        s = std(DataFilt); % Find standard deviation
        set(handles.text12, 'String', s) % Write standard deviation
        mean_amplitude = mean(DataFilt); % Find mean amplitude
        set(handles.text13, 'String', mean_amplitude); % Write mean amplitude
        
    case 3 % theta wave (4-8 Hz)
        Fstop1 = 3.5; % First Stopband Frequency
        Fpass1 = 4; % First Passband Frequency
        Fpass2 = 8; % Second Passband Frequency
        Fstop2 = 8.5; % Second Stopband Frequency
        Wstop1 = 10; % First Stopband Weight
        Wpass = 1; % Passband Weight
        Wstop2 = 10; % Second Stopband Weight
        dens = 20; % Density Factor

        % Calculate the coefficients using the FIRPM function.
        b = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
        0], [Wstop1 Wpass Wstop2], {dens});
        DataFilt = filtfilt(b,1,data);
        
        plot(DataFilt);
        s = std(DataFilt); % Find standard deviation
        set(handles.text12, 'String', s) % Write standard deviation
        mean_amplitude = mean(DataFilt); % Find mean amplitude
        set(handles.text13, 'String', mean_amplitude); % Write mean amplitude
        
    case 4 % alfa wave (8-13 Hz)
        Fstop1 = 7.5; % First Stopband Frequency
        Fpass1 = 8; % First Passband Frequency
        Fpass2 = 13; % Second Passband Frequency
        Fstop2 = 13.5; % Second Stopband Frequency
        Wstop1 = 10; % First Stopband Weight
        Wpass = 1; % Passband Weight
        Wstop2 = 10; % Second Stopband Weight
        dens = 20; % Density Factor

        % Calculate the coefficients using the FIRPM function.
        b = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
        0], [Wstop1 Wpass Wstop2], {dens});
        DataFilt = filtfilt(b,1,data);
        
        plot(DataFilt);
        s = std(DataFilt); % Find standard deviation
        set(handles.text12, 'String', s) % Write standard deviation
        mean_amplitude = mean(DataFilt); % Find mean amplitude
        set(handles.text13, 'String', mean_amplitude); % Write mean amplitude
        
    case 5 % beta wave (13-30 Hz)
        Fstop1 = 12.5; % First Stopband Frequency
        Fpass1 = 13; % First Passband Frequency
        Fpass2 = 30; % Second Passband Frequency
        Fstop2 = 30.5; % Second Stopband Frequency
        Wstop1 = 10; % First Stopband Weight
        Wpass = 1; % Passband Weight
        Wstop2 = 10; % Second Stopband Weight
        dens = 20; % Density Factor

        % Calculate the coefficients using the FIRPM function.
        b = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
        0], [Wstop1 Wpass Wstop2], {dens});
        DataFilt = filtfilt(b,1,data);
        
        plot(DataFilt);
        s = std(DataFilt); % Find standard deviation
        set(handles.text12, 'String', s) % Write standard deviation
        mean_amplitude = mean(DataFilt); % Find mean amplitude
        set(handles.text13, 'String', mean_amplitude); % Write mean amplitude
end  

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


function t1_value_Callback(hObject, eventdata, handles)
% hObject    handle to t1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1_value as text
%        str2double(get(hObject,'String')) returns contents of t1_value as a double
fullpathname = get(handles.text2, 'string');

column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;

x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest
plot(data);

s = std(data); % Find standard deviation
set(handles.text12, 'String', s) % Write standard deviation
mean_amplitude = mean(data); % Find mean amplitude
set(handles.text13, 'String', mean_amplitude); % Write mean amplitude


% --- Executes during object creation, after setting all properties.
function t1_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_value_Callback(hObject, eventdata, handles)
% hObject    handle to t2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2_value as text
%        str2double(get(hObject,'String')) returns contents of t2_value as a double
fullpathname = get(handles.text2, 'string');

column = str2num(get(handles.column_value, 'string')); % get the column number and convert to number

Fs = str2num(get(handles.freq_value, 'string'));
t1_value = str2num(get(handles.t1_value, 'string')); 
t2_value = str2num(get(handles.t2_value, 'string')); 
t1 = t1_value*Fs+1;
t2 = t2_value*Fs;

x = importdata(fullpathname); % all data imported from file
data = x(t1:1/Fs:t2,column); % take only data from column of interest
plot(data);

s = std(data); % Find standard deviation
set(handles.text12, 'String', s) % Write standard deviation
mean_amplitude = mean(data); % Find mean amplitude
set(handles.text13, 'String', mean_amplitude); % Write mean amplitude

% --- Executes during object creation, after setting all properties.
function t2_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sptool
