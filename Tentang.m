function varargout = Tentang(varargin)
% TENTANG MATLAB code for Tentang.fig
%      TENTANG, by itself, creates a new TENTANG or raises the existing
%      singleton*.
%
%      H = TENTANG returns the handle to a new TENTANG or the handle to
%      the existing singleton*.
%
%      TENTANG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TENTANG.M with the given input arguments.
%
%      TENTANG('Property','Value',...) creates a new TENTANG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tentang_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tentang_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tentang

% Last Modified by GUIDE v2.5 29-May-2023 12:18:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tentang_OpeningFcn, ...
                   'gui_OutputFcn',  @Tentang_OutputFcn, ...
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


% --- Executes just before Tentang is made visible.
function Tentang_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tentang (see VARARGIN)

% Choose default command line output for Tentang
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tentang wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tentang_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, ~)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Load the main GUI figure
openfig HalamanUtama.fig
% Close the "Bantuan" GUI figure
close Tentang
