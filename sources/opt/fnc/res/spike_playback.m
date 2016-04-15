function varargout = spike_playback(varargin)
% SPIKE_PLAYBACK MATLAB code for spike_playback.fig
%      SPIKE_PLAYBACK, by itself, creates a new SPIKE_PLAYBACK or raises the existing
%      singleton*.
%
%      H = SPIKE_PLAYBACK returns the handle to a new SPIKE_PLAYBACK or the handle to
%      the existing singleton*.
%
%      SPIKE_PLAYBACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPIKE_PLAYBACK.M with the given input arguments.
%
%      SPIKE_PLAYBACK('Property','Value',...) creates a new SPIKE_PLAYBACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spike_playback_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spike_playback_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spike_playback

% Last Modified by GUIDE v2.5 12-Jul-2015 07:52:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spike_playback_OpeningFcn, ...
                   'gui_OutputFcn',  @spike_playback_OutputFcn, ...
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


% --- Executes just before spike_playback is made visible.
function spike_playback_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spike_playback (see VARARGIN)

% Choose default command line output for spike_playback

handles.neucube=varargin{1};
 if(~isfield(handles.neucube,'neucube_output_visualization'))
     msgbox('Error in rendering the playback...the reservoir may not be trained')
     handles.output = hObject; 
     guidata(hObject, handles);
     return
 else
    numSteps = size(handles.neucube.neucube_output_visualization,2);
    set(handles.spike_slider, 'Min', 1);
    set(handles.spike_slider, 'Max', numSteps);
    set(handles.spike_slider, 'Value', 1);
    set(handles.spike_slider, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);
    set(handles.time_txt,'String',1)
    show_spike_visualization(handles.neucube,handles.neucube.neucube_output_visualization(:,1),handles);
    handles.output = hObject; 

 % save the current/last slider value
%  handles.lastSliderVal = get(handles.spike_slider,'Value');
% Update handles structure
    guidata(hObject, handles);
 end


% % add a continuous value change listener
%  if ~isfield(handles,'hListener')
%     handles.hListener = ...
%         addlistener(handles.spike_slider,'ContinuousValueChange',@respondToContSlideCallback);
%  end
 % set the slider range and step size



% UIWAIT makes spike_playback wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spike_playback_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function spike_slider_Callback(hObject, eventdata, handles)
% hObject    handle to spike_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
t=round(get(handles.spike_slider,'Value'));
set(handles.time_txt,'String',t)
show_spike_visualization(handles.neucube,handles.neucube.neucube_output_visualization(:,t),handles);




% --- Executes during object creation, after setting all properties.
function spike_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spike_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% % --- Executes on slider movement.
%  function respondToContSlideCallback(hObject, eventdata)
%  % hObject    handle to slider1 (see GCBO)
%  % eventdata  reserved - to be defined in a future version of MATLAB
%  % Hints: get(hObject,'Value') returns position of slider
%  %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%  % first we need the handles structure which we can get from hObject
%  handles = guidata(hObject);
%  % get the slider value and convert it to the nearest integer that is less
%  % than this value
%  newVal = floor(get(hObject,'Value'));
%  % set the slider value to this integer which will be in the set {1,2,3,...,12,13}
%  set(hObject,'Value',newVal);
%  % now only do something in response to the slider movement if the 
%  % new value is different from the last slider value
%  if newVal ~= handles.lastSliderVal
%      % it is different, so we have moved up or down from the previous integer
%      % save the new value
%      handles.lastSliderVal = newVal;
%      guidata(hObject,handles);
%     % display the current value of the slider
%     
%         %disp(['at slider value ' num2str(get(hObject,'Value'))]);
%  end






function time_txt_Callback(hObject, eventdata, handles)
% hObject    handle to time_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_txt as text
%        str2double(get(hObject,'String')) returns contents of time_txt as a double


% --- Executes during object creation, after setting all properties.
function time_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in playback_tgl.
function playback_tgl_Callback(hObject, eventdata, handles)
% hObject    handle to playback_tgl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of playback_tgl

if(get(hObject,'Value'))
   simulation_time=size(handles.neucube.neucube_output_visualization,2);
   current_time=round(get(handles.spike_slider,'Value'));
   for t=current_time:simulation_time
        if(~get(hObject,'Value'))
            break;
        end
        set(handles.spike_slider,'Value',t);
        set(handles.time_txt,'String',t);
        show_spike_visualization(handles.neucube,handles.neucube.neucube_output_visualization(:,t),handles);
   end

end


% --- Executes on button press in show_feature_spike_toggle.
function show_feature_spike_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to show_feature_spike_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'Pointer','watch');
global texthandles circlehandles
neucube=handles.neucube;
neuinput=neucube.input_mapping{1};
Names=neucube.input_mapping{2};
axes(handles.spike_axes);
hold on

rng(1);
classcolor=colormap(jet(size(neuinput,1)));
ix=randperm(size(neuinput,1));
classcolor=classcolor(ix,:);

if get(handles.show_feature_spike_toggle,'value')==1
    for k=1:size(neuinput,1)
        texthandles{k}=text(neuinput(k,1)+1,neuinput(k,2)+1,neuinput(k,3)+1,Names{k},'color',classcolor(k,:),'FontSize',12,'FontWeight','bold');
        circlehandles{k}=plot3(neuinput(k,1),neuinput(k,2),neuinput(k,3),'o','MarkerFaceColor',classcolor(k,:),'MarkerSize',10);
    end
else
    for k=1:length(texthandles)
        if ishandle(texthandles{k})
            delete(texthandles{k});
        end
        if ishandle(circlehandles{k})
            delete(circlehandles{k});
        end
    end
    texthandles=[];
    circlehandles=[];
end
%hold off
set(gcf,'Pointer','arrow');
