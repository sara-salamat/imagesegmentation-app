function varargout = imageseg(varargin)
% IMAGESEG MATLAB code for imageseg.fig
%      IMAGESEG, by itself, creates a new IMAGESEG or raises the existing
%      singleton*.
%
%      H = IMAGESEG returns the handle to a new IMAGESEG or the handle to
%      the existing singleton*.
%
%      IMAGESEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGESEG.M with the given input arguments.
%
%      IMAGESEG('Property','Value',...) creates a new IMAGESEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageseg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageseg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageseg

% Last Modified by GUIDE v2.5 18-Aug-2020 20:56:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageseg_OpeningFcn, ...
                   'gui_OutputFcn',  @imageseg_OutputFcn, ...
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


% --- Executes just before imageseg is made visible.
function imageseg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageseg (see VARARGIN)

% Choose default command line output for imageseg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageseg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageseg_OutputFcn(hObject, eventdata, handles) 
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
[file,path] = uigetfile({'*.*'},'choose your image');

fullpathname = strcat(path , file);
imgtest = imread(fullpathname);
[bwoutput , rgboutput] = createMask(imgtest);
[yellow_area_bw , yellow_area] = createMask_yellowcenter(imgtest);
bwoutput = bwareaopen(bwoutput,700);
se = strel('disk' , 50);
yellow_area_bw = imclose(yellow_area_bw,se);
% yellow_area_bw = bwareaopen(yellow_area_bw,50);
s = regionprops(yellow_area_bw,'centroid');
centroids = cat(1,s.Centroid);
axes(handles.axes1);
imshow(imgtest);
axes(handles.axes2)
imshow(bwoutput)
hold on
plot(centroids(:,1),centroids(:,2),'b*');
hold off
axes(handles.axes3)
imshow(rgboutput)
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off
 
