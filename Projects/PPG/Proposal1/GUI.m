function varargout = GUI(varargin)
% Last Modified by GUIDE v2.5 11-May-2014 01:26:12
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% beginning of the project
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

handles.signal = load(uigetfile('*.txt','Select your data text file'));
% handles.sam_frq = 200;
% handles.L=length(handles.signal);
% for i=1:handles.L
%     if handles.signal(i)<(-0.2) 
%         handles.signal(i)=-0.2; 
%     end
% end

guidata(hObject, handles);

% --- Executes on button press in checkboxes.
function checkbox1_Callback(hObject, eventdata, handles)
    handles.checkbox1=get(hObject, 'Value');
guidata(hObject, handles);

function checkbox2_Callback(hObject, eventdata, handles)
    handles.checkbox2=get(hObject, 'Value');
guidata(hObject, handles);

function checkbox3_Callback(hObject, eventdata, handles)
    handles.checkbox3=get(hObject, 'Value');
guidata(hObject, handles);

function checkbox4_Callback(hObject, eventdata, handles)
    handles.checkbox4=get(hObject, 'Value');
guidata(hObject, handles);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
    handles.x_beg=fix(get(hObject, 'Value'));
    set(handles.edit1, 'String', num2str(handles.x_beg) );
%     if handles.x_beg+1 < fix(get(slider2, 'Min')) 
    set(handles.slider2, 'Min', handles.x_beg+1);
%     end
    
    axes(handles.axes1);
    cla;
    hold on
    plot(handles.time, handles.signal);
    ylim(handles.amp_lim);
    handles.xx_beg=linspace(handles.x_beg,handles.x_beg,100);
    plot(handles.xx_beg, handles.yy,'r');
    plot(handles.xx_end, handles.yy,'r');
guidata(hObject, handles);

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
function slider2_Callback(hObject, eventdata, handles)

   handles.x_end=fix(get(hObject, 'Value'));
    set(handles.edit2, 'String', num2str(handles.x_end) );
% if handles.x_end-1 > fix(get(slider1, 'Max'))
    set(handles.slider1, 'Max', handles.x_end-1);
% else
%     set(handles.slider1, 'Max', handles.x_end-1);
% end

    axes(handles.axes1);
    cla;
    hold on
    plot(handles.time, handles.signal);
    ylim(handles.amp_lim);
    handles.xx_end=linspace(handles.x_end,handles.x_end,100);
    plot(handles.xx_beg, handles.yy,'r');
    plot(handles.xx_end, handles.yy,'r');
    
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
handles.sam_frq = str2double(get(hObject,'String'));
if isnan(handles.sam_frq) || handles.sam_frq<=0
  errordlg('You must enter a pozitive nonzero numeric value for sampling frequency','Bad Input','modal')
  uicontrol(hObject)
 return

end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

handles.sam_frq = str2double(get(handles.edit3,'String'));
if isnan(handles.sam_frq) || handles.sam_frq<=0
  errordlg('You must enter a pozitive nonzero numeric value for sampling frequency','Bad Input','modal')
  uicontrol(handles.edit3)
 return
end
% handles.sam_frq =200;
handles.L=length(handles.signal);
% calculating actual time of a signal in seconds and making time time-vector for x-axis 
handles.time = linspace(0, handles.L/handles.sam_frq, handles.L);

%setting minimum and maximum values of sliders and with respect to timescale of original signal
set(handles.slider1, 'Min', handles.time(1));
set(handles.slider1, 'Max', handles.time(end)-1);
set(handles.slider1, 'Value', handles.time(1));

set(handles.slider2, 'Min', handles.time(1)+1);
set(handles.slider2, 'Max', handles.time(end));
set(handles.slider2, 'Value', handles.time(end));

set(handles.edit2, 'String', num2str(handles.time(end)));
set(handles.edit1, 'String', num2str(handles.time(1)));

handles.amp_lim=[-0.2,0.3];
handles.xx_beg=zeros(100,1);
handles.xx_end=ones(100,1);
handles.xx_end=ones(100,1).*(handles.L/handles.sam_frq);
handles.yy=linspace(handles.amp_lim(1),handles.amp_lim(2),100);

% finding values of peaks' amplitudes and their locations with help of Matlab function findpeaks
[handles.pks_end,handles.lcs_end] = findpeaks(handles.signal, 'MINPEAKDISTANCE', 100, 'MINPEAKHEIGHT', 0.1);
[handles.pks_beg,handles.lcs_beg] = findpeaks(-handles.signal, 'MINPEAKDISTANCE', 100, 'MINPEAKHEIGHT', 0.05);

%finding peaks for better HRV acquisition.
% [handles.pks_end,handles.lcs_end] = findpeaks(handles.signal, 'MINPEAKDISTANCE', 100);
% [handles.pks_beg,handles.lcs_beg] = findpeaks(-handles.signal, 'MINPEAKDISTANCE', 100);

% calculating Mean Arterial Pressure with given coefficients
if length(handles.lcs_beg)<length(handles.lcs_end) 
amp=zeros(size(handles.lcs_beg));
else
amp=zeros(size(handles.lcs_end));    
end
for i=1:length(amp)-1
    amp(i)=handles.pks_beg(i+1)+handles.pks_end(i);
end

% calculating Mean Arterial Pressure with given coefficients
p1=105; 
p2=-4;
p3=0.2;
p4=18;
handles.AP=zeros(size(amp));
for i=1:length(amp)
    handles.AP(i)=p1*exp(p2*amp(i))+p3*exp(p4*amp(i));
end
sum_of_AP=0;
for i=1:length(amp)
    sum_of_AP=sum_of_AP+handles.AP(i);
end
handles.MAP=sum_of_AP/length(amp);

% plotting original signal all over whole time period
axes(handles.axes1);
cla;
hold on
plot(handles.time, handles.signal);
ylim(handles.amp_lim);
guidata(hObject, handles);

% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

hF = figure('Name', 'Modified signal', 'NumberTitle', 'off');
set(hF, 'OuterPosition', [1, 1, 1200, 800]); 
hA = axes('Position', [0.05 0.15 0.9 0.7]);

xstart=fix(str2num(get(handles.edit1, 'String')));
xfinish=fix(str2num(get(handles.edit2, 'String')));
start=(str2num(get(handles.edit1, 'String')))*handles.sam_frq;
finish=(str2num(get(handles.edit2, 'String')))*handles.sam_frq;
% we know that despite time starts from 0, our vector starts from index 1.
if start==0
    start=1;
end

% small include in case of 4th feature is selected
if handles.checkbox4==1
    
    subplot(3,1,1); %     subplot(2,2,1); 
end

plot(handles.time( start:finish),handles.signal( start:finish));
% ylim([min(handles.signal) max(handles.signal)+0.2]);
ylim([-0.2 0.45]);
xlim([xstart,xfinish]);
hold on

% if show amplitude checked showing peaks beginning and ends.
if handles.checkbox1==1
    plot(handles.lcs_end/handles.sam_frq, handles.pks_end, 'or');
    plot(handles.lcs_beg/handles.sam_frq, -handles.pks_beg, 'og');
end

% showing peak-to-peak intervals
if handles.checkbox2==1
plot(handles.time, .3, '-k');
plot(handles.lcs_end/handles.sam_frq, .3, '+k');
%     plot(handles.time, max(handles.signal)+0.1, '-k');
%     plot(handles.lcs_end/handles.sam_frq, max(handles.signal)+0.1, '+k');
end

%if option "show MAP is marked"
if handles.checkbox3==1
    phrase='  Mean arterial pressure is: ';
phrase=horzcat(phrase, int2str(handles.MAP)); 
text(handles.xx_beg(1), .5, phrase, 'FontSize', 18);


%         text(handles.lcs_end(i)/handles.sam_frq, max(handles.signal)+.15, int2str(handles.AP(i)), 'FontSize', 6);

% Display peaks' pressure values if it is necessary.
% 	for i=1:length(handles.lcs_end)
%             text(handles.lcs_end(i)/handles.sam_frq, 0.315, int2str(handles.AP(i)), 'FontSize', 6);
%     end 
    
end

if handles.checkbox4==1
    %creating single column vector for RR interfals timemarks
RR_loc=zeros(length(handles.lcs_end)-1, 1);
% same length vector for values of RR intervals
RR_val=zeros(length(RR_loc), 1);
%computing RR time in seconds and RR timemarks
for i=1:length(RR_loc);
    RR_val(i)=handles.lcs_end(i+1)-handles.lcs_end(i);
    RR_loc(i)=handles.lcs_end(i)/handles.sam_frq;
end

% RTnew = min(RR_loc):1/4:max(RR_loc)-1/4;
RTnew = min(RR_loc):1/4:handles.time(end)-1/4;
RRnew = interp1(RR_loc,RR_val,RTnew,'spline');

    subplot(3, 1, 2) %     subplot(2,2,2);
plot(RR_loc,RR_val, '*b');
hold on
plot(RR_loc,RR_val,'o',RTnew,RRnew);
xlim([RR_loc(1) RR_loc(end)]);
% ylim([min(RR_val)-5 max(RR_val)+5]);
ylabel('RR intervals duration (ms)')
xlabel('RR interval timestamps (s)')
title('{\bf RR variability}')
hold off

fs = 4;
m = length(RRnew);
n = pow2(nextpow2(m));
y = fft(RRnew,n);

% f = (0:n-1)*(fs/n);
% power = y.*conj(y)/n;

y0 = fftshift(y);
f0 = (-n/2:n/2-1)*(fs/n);
power0 = y0.*conj(y0)/n;

start = length(y0)/2+round((0.04*length(y0))/fs);
fin = length(y0)/2+round((0.5*length(y0))/fs);

    subplot(3,1,3)%     subplot(2,2,3);
plot(f0(start:fin),power0(start:fin));  % plot(f0,power0);
xlim([f0(start) f0(fin)]);
xlabel('Frequency (Hz)')
ylabel('Power')
title('PSD')

%     NFFT = 2^nextpow2(handles.L); % Next power of 2 from length of y
%     Y = fft(handles.signal,NFFT);%/L;
%     f = handles.sam_frq/2*linspace(0,1,NFFT/2+1);

%       subplot(2,2,4);
%     Plot single-sided amplitude spectrum.
%     plot(f,abs(Y(1:NFFT/2+1))) 
%     title('Single-Sided Amplitude Spectrum of y(t)')
%     xlabel('Frequency (Hz)')
%     ylabel('|Y(f)|')
    
end
hold off;

guidata(hObject, handles);
