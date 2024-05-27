function varargout = Pengolahan(varargin)
% PENGOLAHAN MATLAB code for Pengolahan.fig
%      PENGOLAHAN, by itself, creates a new PENGOLAHAN or raises the existing
%      singleton*.
%
%      H = PENGOLAHAN returns the handle to a new PENGOLAHAN or the handle to
%      the existing singleton*.
%
%      PENGOLAHAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PENGOLAHAN.M with the given input arguments.
%
%      PENGOLAHAN('Property','Value',...) creates a new PENGOLAHAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pengolahan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pengolahan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pengolahan

% Last Modified by GUIDE v2.5 29-May-2023 13:11:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pengolahan_OpeningFcn, ...
                   'gui_OutputFcn',  @Pengolahan_OutputFcn, ...
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


% --- Executes just before Pengolahan is made visible.
function Pengolahan_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pengolahan (see VARARGIN)

% Choose default command line output for Pengolahan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pengolahan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pengolahan_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.jpg');
if ~isequal(filename, 0)
    img = im2double(imread(fullfile(pathname, filename)));
    axes(handles.axes1);
    imshow(img);
    title('Citra Asli');
    set(handles.edit1, 'String', filename);
    handles.img = img;
    guidata(hObject, handles);
else
    % jika tidak ada file yang dipilih maka akan kembali
    return
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img;
img_gray = rgb2gray(img);
bw = imbinarize(img_gray);
bw = imcomplement(bw);
bw = imfill(bw, 'holes');
bw = bwareaopen(bw, 1000);
axes(handles.axes2);
imshow(bw);
title('Citra biner');
handles.img_gray = img_gray;
handles.bw = bw;
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img;
img_gray = rgb2gray(img);
bw = imbinarize(img_gray, 0.40);
bw = imcomplement(bw);
bw = imfill(bw, 'holes');
% area opening
bw = bwareaopen(bw, 1000);
% melakukan ekstraksi komponen RGB
R = img(:, :, 1); % Red
G = img(:, :, 2); % Green
B = img(:, :, 3); % Blue
% mengubah nilai background menjadi nol
R(~bw) = 0;
G(~bw) = 0;
B(~bw) = 0;
hsv = rgb2hsv(img);
H = hsv(:, :, 1);
S = hsv(:, :, 2);
V = hsv(:, :, 3);
H(~bw) = 0;
S(~bw) = 0;
V(~bw) = 0;
axes(handles.axes3);
imshow(hsv);
title('Citra HSV');
handles.R = R;
handles.G = G;
handles.B = B;
handles.H = H;
handles.S = S;
handles.V = V;
handles.bw = bw;
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, ~, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% memanggil variabel Img, Img_gray, & bw yang ada di lokasi handles
img = handles.img;
img_gray = handles.img_gray;
bw = handles.bw;
% ekstraksi ciri warna RGB
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
R(~bw) = 0;
G(~bw) = 0;
B(~bw) = 0;
Red = sum(sum(R))/sum(sum(bw));
Green = sum(sum(G))/sum(sum(bw));
Blue = sum(sum(B))/sum(sum(bw));
% ekstraksi ciri warna HSV
HSV = rgb2hsv(img);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);
H(~bw) = 0;
S(~bw) = 0;
V(~bw) = 0;
Hue = sum(sum(H))/sum(sum(bw));
Saturation = sum(sum(S))/sum(sum(bw));
Value = sum(sum(V))/sum(sum(bw));
% ekstraksi ciri tekstur GLCM
img_gray(~bw) = 0;
GLCM = graycomatrix(img_gray,'Offset',[0 1; -1 1; -1 0; -1 -1]);
stats = graycoprops(GLCM,{'contrast','correlation','energy','homogeneity'});
Contrast = mean(stats.Contrast);
Correlation = mean(stats.Correlation);
Energy = mean(stats.Energy);
Homogeneity = mean(stats.Homogeneity);
% mengisi hasil ekstraksi ciri pada variabel ciri_ikan
ciri_segar = cell(10,2);
ciri_segar{1,1} = 'Red';
ciri_segar{2,1} = 'Green';
ciri_segar{3,1} = 'Blue';
ciri_segar{4,1} = 'Hue';
ciri_segar{5,1} = 'Saturation';
ciri_segar{6,1} = 'Value';
ciri_segar{7,1} = 'Contrast';
ciri_segar{8,1} = 'Correlation';
ciri_segar{9,1} = 'Energy';
ciri_segar{10,1} = 'Homogeneity';
ciri_segar{1,2} = num2str(Red);
ciri_segar{2,2} = num2str(Green);
ciri_segar{3,2} = num2str(Blue);
ciri_segar{4,2} = num2str(Hue);
ciri_segar{5,2} = num2str(Saturation);
ciri_segar{6,2} = num2str(Value);
ciri_segar{7,2} = num2str(Contrast);
ciri_segar{8,2} = num2str(Correlation);
ciri_segar{9,2} = num2str(Energy);
ciri_segar{10,2} = num2str(Homogeneity);
% menampilkan ciri_ikan pada tabel
set(handles.uitable1,'Data',ciri_segar,'RowName',1:10)
ciri_test = [Red,Green,Blue,Hue,Saturation,Value,...
    Contrast,Correlation,Energy,Homogeneity];
% menyimpan variabel ciri_uji pada lokasi handles
handles.ciri_test = ciri_test;
guidata(hObject, handles)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(~, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Memuat variabel ciri_test dari objek handles
ciri_test = handles.ciri_test;

% Memuat model yang telah dilatih sebelumnya
load Mdl

% Melakukan prediksi dengan menggunakan model pada data ciri_test
result = predict(Mdl,ciri_test);

% Memeriksa hasil prediksi dan menampilkan output yang sesuai
if result == 1
    A1 = 'Ikan Segar';
    set(handles.edit1,'string',A1);
    helpdlg('Ikan Segar');
    disp('Ikan Segar');
else
    A3 = 'Ikan Tidak Segar';
    set(handles.edit1,'string',A3);
    helpdlg('Ikan Tidak Segar');
    disp('Ikan Tidak Segar')
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(~, ~, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Membersihkan dan mengatur ulang tampilan dari tiga objek axes dan beberapa objek lainnya
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

% Menghapus isi dari objek edit1
set(handles.edit1,'String',[])

% Menghapus isi dari objek uitable1
set(handles.uitable1,'Data',[])



function edit1_Callback(~, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(~, ~, ~)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openfig HalamanUtama.fig
% untuk menutup GUI
close Pengolahan
