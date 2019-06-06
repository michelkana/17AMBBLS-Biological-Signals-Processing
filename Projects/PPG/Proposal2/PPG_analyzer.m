function varargout = PPG_analyzer(varargin)
% PPG_ANALYZER MATLAB code for PPG_analyzer.fig
%      PPG_ANALYZER, by itself, creates a new PPG_ANALYZER or raises the existing
%      singleton*.
%
%      H = PPG_ANALYZER returns the handle to a new PPG_ANALYZER or the handle to
%      the existing singleton*.
%
%      PPG_ANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PPG_ANALYZER.M with the given input arguments.
%
%      PPG_ANALYZER('Property','Value',...) creates a new PPG_ANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PPG_analyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PPG_analyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PPG_analyzer

% Last Modified by GUIDE v2.5 20-May-2013 18:20:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PPG_analyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @PPG_analyzer_OutputFcn, ...
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
end


% --- Executes just before PPG_analyzer is made visible.
function PPG_analyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PPG_analyzer (see VARARGIN)

% Choose default command line output for PPG_analyzer
handles.output = hObject;
handles.raw_ppg_toggle=0;
handles.ppg_filtered_toggle=0;
handles.ppg_peaks_toggle=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PPG_analyzer wait for user response (see UIRESUME)
% uiwait(handles.PPG_analyzer);
end


% --- Outputs from this function are returned to the command line.
function varargout = PPG_analyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.PPG_analyzer)
figure(1), clf(1)
imshow('closing_picture.jpg')
end


% --- Executes on button press in PP_interval.
function PP_interval_Callback(hObject, eventdata, handles)
% hObject    handle to PP_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Import handles
ppg=handles.ppg;
time=handles.time;
Fs=handles.Fs; 
HR=handles.HR;


ppg_f=handles.ppg_f;


peak_distance_thr=round(HR*.51*Fs/60);
[peaks locs]=findpeaks(ppg_f,'MINPEAKDISTANCE',peak_distance_thr);

PP_interval=diff(locs)/500;
locs(end)=[];
PP_time=time(locs);
plot(PP_time,PP_interval)
title('Peak to Peak Interval')
xlabel('time [s]')
ylabel('Interval [s]')

mean_PP_interval=mean(PP_interval);

handles.mean_PP_interval=mean_PP_interval;
handles.PP_interval=PP_interval;
handles.PP_time=PP_time;
set(handles.mean_PP_interval_value,'String',num2str(mean_PP_interval));

guidata(hObject,handles)


end


% --- Executes on button press in PH.
function PH_Callback(hObject, eventdata, handles)
% hObject    handle to PH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ppg=handles.ppg;
time=handles.time;
Fs=handles.Fs; 
HR=handles.HR;



    
    
ppg_f=handles.ppg_f;
    
    


peak_distance_thr=round(HR*.51*Fs/60);
[peaks_max locs_max]=findpeaks(ppg_f,'MINPEAKDISTANCE',peak_distance_thr);
[peaks_min locs_min]=findpeaks(-ppg_f,'MINPEAKDISTANCE',peak_distance_thr);
peaks_min=-peaks_min;

%plot(time,ppg,time,ppg_f,time(locs_max),peaks_max,'x',time(locs_min),peaks_min,'x')



time2=time';

%peak amplitude
Peak_data=[peaks_max,time2(locs_max);peaks_min,time2(locs_min)];
Peaks_sorted=sortrows(Peak_data,2);
Peaks_diff=diff(Peaks_sorted(:,1));

Peak_Height=abs(Peaks_diff);
Peak_Height(1:2:end)=[];

time_PH=Peaks_sorted(:,2)';
time_PH(end)=[];
time_PH(1:2:end)=[];

plot(time_PH,Peak_Height)
title('Pulse Height')
xlabel('time [s]')
ylabel('Pulse Height [mV]')

mean_Peak_Height=mean(Peak_Height);




handles.mean_Peak_Height=mean_Peak_Height;
handles.Peak_Height=Peak_Height;
handles.time_PH=time_PH;
handles.Peaks_sorted=Peaks_sorted;

set(handles.mean_Pulse_Height_value,'String',num2str(mean_Peak_Height));

MAP=105*exp(-4*mean_Peak_Height)+0.2*exp(18*mean_Peak_Height);
set(handles.MAP_value,'String',num2str(MAP));

guidata(hObject,handles)


end



function sampling_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to sampling_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampling_frequency as text
%        str2double(get(hObject,'String')) returns contents of sampling_frequency as a double

handles.Fs=str2double(get(hObject,'String'));
guidata(hObject,handles)
end

% --- Executes during object creation, after setting all properties.
function sampling_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampling_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)
% hObject    handle to import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load data
Fs=handles.Fs;

[filename, pathname]=uigetfile('*.txt');

Path=fullfile(pathname,filename);


data=importdata(Path);

ppg=data(:,1);

%create time axis
time=[0:length(ppg)-1]/Fs;
handles.time=time;

   
        %HR estimator
        
        Fpass = 0.5;                % Passband Frequency
        Fstop = 2;               % Stopband Frequency
        Dpass = 0.057501127785;   % Passband Ripple
        Dstop = 0.0031622776602;  % Stopband Attenuation
        dens  = 20;               % Density Factor
        
        % Calculate the order from the parameters using FIRPMORD.
        [N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);
        
        % Calculate the coefficients using the FIRPM function.
        b  = firpm(N, Fo, Ao, W, {dens});
        Hd = dfilt.dffir(b);
        
        
        ppg_f2=filter(Hd,ppg);
        
        
        [peaks locs]=findpeaks(ppg_f2);
        
        H_peaks=time(locs);
        interval=diff(H_peaks);
        
        interval2=interval;
        interval2(interval<.6*mean(interval))=[];
        
        HR=60/mean(interval2);
        
        handles.HR=HR;
        
        
%Filter data  
    Fpass = 1;                % Passband Frequency
    Fstop = 12;               % Stopband Frequency
    Dpass = 0.057501127785;   % Passband Ripple
    Dstop = 0.0031622776602;  % Stopband Attenuation
    dens  = 20;               % Density Factor
    
    % Calculate the order from the parameters using FIRPMORD.
    [N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);
    
    % Calculate the coefficients using the FIRPM function.
    b  = firpm(N, Fo, Ao, W, {dens});
    Hd = dfilt.dffir(b);
    
    
    
    
    ppg_f=filter(Hd,ppg);
    handles.ppg_f=ppg_f;


handles.ppg=ppg;

set(handles.HR_value,'String',num2str(HR));


plot(time,ppg)
title('Raw PPG signal')
xlabel('time [s]')
ylabel('Amplitude [mV]')



guidata(hObject,handles)


end



% --- Executes on button press in LF_HF.
function LF_HF_Callback(hObject, eventdata, handles)
% hObject    handle to LF_HF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

HR=handles.HR;
ppg_f=handles.ppg_f;
Fs=handles.Fs;


peak_distance_thr=round(HR*.51*Fs/60);
[peaks locs]=findpeaks(ppg_f,'MINPEAKDISTANCE',peak_distance_thr);

PP_interval=diff(locs)/500;

%double Fs
PPi_double=zeros(1,length(PP_interval)*2);
PPi_double([1:2:end])=PP_interval;
PPi_double([2:2:end])=PP_interval;

Fs=2*60/HR;

L = length(PPi_double);
y=PPi_double;
%Convert to frequency domain 
NFFT = 2^nextpow2(L);
Y = fft(y,NFFT)/L; 
f = Fs/2*linspace(0,1,NFFT/2+1); 

spec=2*abs(Y(1:NFFT/2+1));
 
%Plot single sided amplitude spectrum
plot(f,spec) 
title('Amplitude Spectrum of PP interval')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%Integrate the area under the curve in frequency band 0.04-0.15 (LF)
int_spec = exp(interp1(log(f),log(spec),log(0.04:.01:0.15),'linear','extrap'));
LF=trapz(0.04:.01:0.15,int_spec);

%Integrate the area under the curve in frequency band 0.15-0.4 (HF)
int_spec = exp(interp1(log(f),log(spec),log(0.15:.01:0.5),'linear','extrap'));
HF=trapz(0.15:.01:0.5,int_spec);


set(handles.HF_value,'String',num2str(HF));
set(handles.LF_value,'String',num2str(LF));

guidata(hObject,handles)

end



function mean_PP_interval_value_Callback(hObject, eventdata, handles)
% hObject    handle to mean_PP_interval_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mean_PP_interval_value as text
%        str2double(get(hObject,'String')) returns contents of mean_PP_interval_value as a double
end


% --- Executes during object creation, after setting all properties.
function mean_PP_interval_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mean_PP_interval_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function mean_Pulse_Height_value_Callback(hObject, eventdata, handles)
% hObject    handle to mean_Pulse_Height_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mean_Pulse_Height_value as text
%        str2double(get(hObject,'String')) returns contents of mean_Pulse_Height_value as a double
end



% --- Executes during object creation, after setting all properties.
function mean_Pulse_Height_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mean_Pulse_Height_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function LF_value_Callback(hObject, eventdata, handles)
% hObject    handle to LF_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LF_value as text
%        str2double(get(hObject,'String')) returns contents of LF_value as a double
end


% --- Executes during object creation, after setting all properties.
function LF_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LF_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function HF_value_Callback(hObject, eventdata, handles)
% hObject    handle to HF_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HF_value as text
%        str2double(get(hObject,'String')) returns contents of HF_value as a double
end


% --- Executes during object creation, after setting all properties.
function HF_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HF_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function HR_value_Callback(hObject, eventdata, handles)
% hObject    handle to HR_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HR_value as text
%        str2double(get(hObject,'String')) returns contents of HR_value as a double
end


% --- Executes during object creation, after setting all properties.
function HR_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HR_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in raw_ppg.
function raw_ppg_Callback(hObject, eventdata, handles)
% hObject    handle to raw_ppg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of raw_ppg
handles.raw_ppg_toggle=get(hObject,'Value');
guidata(hObject,handles)
end

% --- Executes on button press in ppg_filtered.
function ppg_filtered_Callback(hObject, eventdata, handles)
% hObject    handle to ppg_filtered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ppg_filtered
handles.ppg_filtered_toggle=get(hObject,'Value');
guidata(hObject,handles)
end

% --- Executes on button press in ppg_peaks.
function ppg_peaks_Callback(hObject, eventdata, handles)
% hObject    handle to ppg_peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ppg_peaks
handles.ppg_peaks_toggle=get(hObject,'Value');
guidata(hObject,handles)
end

% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


ppg=handles.ppg;
time=handles.time;
ppg_f=handles.ppg_f;
Fs=handles.Fs; 
HR=handles.HR;

if isfield(handles,'Peaks_sorted')==0
    peak_distance_thr=round(HR*.51*Fs/60);
    [peaks_max locs_max]=findpeaks(ppg_f,'MINPEAKDISTANCE',peak_distance_thr);
    [peaks_min locs_min]=findpeaks(-ppg_f,'MINPEAKDISTANCE',peak_distance_thr);
    peaks_min=-peaks_min;
    time2=time';
    %peak amplitude
    Peak_data=[peaks_max,time2(locs_max);peaks_min,time2(locs_min)];
    Peaks_sorted=sortrows(Peak_data,2);

    
else
    Peaks_sorted=handles.Peaks_sorted;
end
    




peaks_locs=Peaks_sorted(:,2);
peaks_heights=Peaks_sorted(:,1);

raw_ppg_toggle=handles.raw_ppg_toggle;
ppg_peaks_toggle=handles.ppg_peaks_toggle;
ppg_filtered_toggle=handles.ppg_filtered_toggle;

cla %clear image axis

hold on
if raw_ppg_toggle==1
    plot(time,ppg,'b')
    
end
if ppg_filtered_toggle==1
    plot(time,ppg_f,'g')
end
if ppg_peaks_toggle==1
    plot(peaks_locs,peaks_heights,'or')
end

if raw_ppg_toggle==1
    if ppg_filtered_toggle==1
        if ppg_peaks_toggle==1
            legend('Raw PPG','Filtered PPG','PPG Peaks')
        else
            legend('Raw PPG','Filtered PPG')
        end
        
    else
        if ppg_peaks_toggle==1
            legend('Raw PPG','PPG Peaks')
        else
            legend('Raw PPG')
        end
    end
else
    if ppg_filtered_toggle==1
        if ppg_peaks_toggle==1
            legend('Filtered PPG','PPG Peaks')
        else
            legend('Filtered PPG')
        end
        
    else
        if ppg_peaks_toggle==1
            legend('PPG Peaks')
        end
    end
end

       

title('PPG signal')
xlabel('time [s]')
ylabel('Amplitude [mV]')



hold off
if isfield(handles,'T1')==1
    if isfield(handles,'T2')==1
        T1=handles.T1;
        T2=handles.T2;
        xlim([T1,T2])
       
    end
end

end


function t1_Callback(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1 as text
%        str2double(get(hObject,'String')) returns contents of t1 as a double
handles.T1=str2double(get(hObject,'String'));
guidata(hObject,handles)
end

% --- Executes during object creation, after setting all properties.
function t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function t2_Callback(hObject, eventdata, handles)
% hObject    handle to t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2 as text
%        str2double(get(hObject,'String')) returns contents of t2 as a double
handles.T2=str2double(get(hObject,'String'));
guidata(hObject,handles)
end


% --- Executes during object creation, after setting all properties.
function t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function MAP_value_Callback(hObject, eventdata, handles)
% hObject    handle to MAP_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MAP_value as text
%        str2double(get(hObject,'String')) returns contents of MAP_value as a double
end


% --- Executes during object creation, after setting all properties.
function MAP_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MAP_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
