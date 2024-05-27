clc; clear; close all; warning off all;

%%% ikan segar
% membaca file citra
nama_folder = 'data latih/ikan segar';
nama_file = dir(fullfile(nama_folder,'*.JPG'));
jumlah_file = numel(nama_file);

% inisialisasi variabel ciri_segar dan target_segar
ciri_segar = zeros(jumlah_file,10); % 10 nilai
target_segar = zeros(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    % membaca file citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    Img_gray = rgb2gray(Img);
    % mengkonversi citra grayscale menjadi citra biner
    bw = imbinarize(Img_gray,.45);
    % melakukan operasi komplemen
    bw = imcomplement(bw);
    % melakukan operasi morfologi
    % 1. filling holes
    bw = imfill(bw,'holes');
    % 2. area opening
    bw = bwareaopen(bw,1000);
    
    % melakukan ekstraksi komponen RGB
    R = Img(:,:,1); % Red
    G = Img(:,:,2); % Green
    B = Img(:,:,3); % Blue
    
    % mengubah nilai piksel background menjadi nol (menghilangkan
    % background)
    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;
    RGB = cat(3,R,G,B);
    
    % segmentasi
    HSV = rgb2hsv(Img);
    H = Img(:,:,1); % komponen H
    S = Img(:,:,2); % komponen S
    V = Img(:,:,3); % komponen V
    Hue = sum(sum(H))/sum(sum(bw));
    Saturation = sum(sum(S))/sum(sum(bw));
    Value = sum(sum(V))/sum(sum(bw));
    Red = sum(sum(R))/sum(sum(bw));
    Green = sum(sum(G))/sum(sum(bw));
    Blue = sum(sum(B))/sum(sum(bw));
    
    % melakukan ekstraksi ciri tektur GLCM
    Img_gray(~bw) = 0;
    % membentuk matriks co-occurences
    GLCM = graycomatrix(Img_gray,'Offset',[0 1; -1 1; -1 0; -1 -1]);
    stats = graycoprops(GLCM,{'Contrast','Correlation','Energy','Homogeneity'});
    Contrast = mean(stats.Contrast);
    Correlation = mean(stats.Correlation);
    Energy = mean(stats.Energy);
    Homogeneity = mean(stats.Homogeneity);
    
    % mengisi variabel ciri_segar dengan ciri hasil ekstraksi
    ciri_segar(n,1) = Red;
    ciri_segar(n,2) = Green;
    ciri_segar(n,3) = Blue;
    ciri_segar(n,4) = Hue;
    ciri_segar(n,5) = Saturation;
    ciri_segar(n,6) = Value;
    ciri_segar(n,7) = Contrast;
    ciri_segar(n,8) = Correlation;
    ciri_segar(n,9) = Energy;
    ciri_segar(n,10) = Homogeneity;

    % mengisi variabel target_segar
    target_segar(n,1) = 1; 
end

%%% ikan tidak segar
% membaca file citra
nama_folder = 'data latih/ikan tidak segar';
nama_file = dir(fullfile(nama_folder,'*.jpg'));
jumlah_file = numel(nama_file);

% inisialisasi variabel ciri_tidaksegar dan target_tidaksegar
ciri_tidaksegar = zeros(jumlah_file,10); % 10 nilai
target_tidaksegar = zeros(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    % membaca file citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    
    % mengkonversi citra rgb menjadi citra grayscale
    Img_gray = rgb2gray(Img);

    % mengkonversi citra grayscale menjadi citra biner
    bw = imbinarize(Img_gray,.40);
    
    % melakukan operasi komplemen
    bw = imcomplement(bw);
    
    % melakukan operasi morfologi
    % 1. filling holes
    bw = imfill(bw,'holes');
    
    % 2. area opening
    bw = bwareaopen(bw,1000);
    
    % melakukan ekstraksi komponen RGB
    R = Img(:,:,1); % Red
    G = Img(:,:,2); % Green
    B = Img(:,:,3); % Blue
    
    % mengubah nilai piksel background menjadi nol (menghilangkan
    % background)
    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;
    RGB = cat(3,R,G,B);

    % segmentasi
    HSV = rgb2hsv(Img);
    H = Img(:,:,1); % komponen H
    S = Img(:,:,2); % komponen S
    V = Img(:,:,3); % komponen V
    Hue = sum(sum(H))/sum(sum(bw));
    Saturation = sum(sum(S))/sum(sum(bw));
    Value = sum(sum(V))/sum(sum(bw));
    Red = sum(sum(R))/sum(sum(bw));
    Green = sum(sum(G))/sum(sum(bw));
    Blue = sum(sum(B))/sum(sum(bw));

    % melakukan ekstraksi ciri tektur GLCM
    Img_gray(~bw) = 0;
    % membentuk matriks co-occurences
    GLCM = graycomatrix(Img_gray,'Offset',[0 1; -1 1; -1 0; -1 -1]);
    stats = graycoprops(GLCM,{'Contrast','Correlation', 'Energy','Homogeneity'});
    Contrast = mean(stats.Contrast);
    Correlation = mean(stats.Correlation);
    Energy = mean(stats.Energy);
    Homogeneity = mean(stats.Homogeneity);

    % mengisi variabel ciri_tidaksegar dengan ciri hasil ekstraksi
    ciri_tidaksegar(n,1) = Red;
    ciri_tidaksegar(n,2) = Green;
    ciri_tidaksegar(n,3) = Blue;
    ciri_tidaksegar(n,4) = Hue;
    ciri_tidaksegar(n,5) = Saturation;
    ciri_tidaksegar(n,6) = Value;
    ciri_tidaksegar(n,7) = Contrast;
    ciri_tidaksegar(n,8) = Correlation;
    ciri_tidaksegar(n,9) = Energy;
    ciri_tidaksegar(n,10) = Homogeneity;

    % mengisi variabel target_tidaksegar
    target_tidaksegar(n,1) = 2;
end

% menyusun variabel target_latih
ciri_latih = [ciri_segar;ciri_tidaksegar];
target_latih = [target_segar;target_tidaksegar];

% melakukan pelatihan menggunakan algoritma k-nn
Mdl = fitcknn(ciri_latih,target_latih,'NumNeighbors',5,'Standardize',1);

% membaca kelas keluaran hasil pelatihan 
hasil_latih = predict(Mdl,ciri_latih);

% menyimpan variabel Mdl hasil pelatihan
save Mdl Mdl 