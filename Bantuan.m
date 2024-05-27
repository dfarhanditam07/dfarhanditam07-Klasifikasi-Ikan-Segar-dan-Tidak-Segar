function varargout = Bantuan(varargin)
% BANTUAN MATLAB code for Bantuan.fig
%      BANTUAN, by itself, creates a new BANTUAN or raises the existing
%      singleton*.
%
%      H = BANTUAN returns the handle to a new BANTUAN or the handle to
%      the existing singleton*.
%
%      BANTUAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BANTUAN.M with the given input arguments.
%
%      BANTUAN('Property','Value',...) creates a new BANTUAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bantuan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bantuan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bantuan

% Last Modified by GUIDE v2.5 29-May-2023 12:20:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bantuan_OpeningFcn, ...
                   'gui_OutputFcn',  @Bantuan_OutputFcn, ...
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


% --- Executes just before Bantuan is made visible.
function Bantuan_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bantuan (see VARARGIN)

% Choose default command line output for Bantuan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bantuan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bantuan_OutputFcn(~, ~, handles) 
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
close Bantuan
