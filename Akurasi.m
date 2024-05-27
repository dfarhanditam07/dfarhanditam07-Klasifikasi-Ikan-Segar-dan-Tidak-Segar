%%% ikan segar (pengujian)
nama_folder = 'data uji/ikan segar';
nama_file = dir(fullfile(nama_folder,'*.JPG'));
jumlah_file = numel(nama_file);

% inisialisasi variabel ciri_segar_uji dan target_segar_uji
ciri_segar_uji = zeros(jumlah_file,10); % 10 nilai
target_segar_uji = zeros(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file uji
for n = 1:jumlah_file
    % membaca file citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    Img_gray = rgb2gray(Img);
    % ... (rest of the image processing steps)

    % mengisi variabel ciri_segar_uji dengan ciri hasil ekstraksi
    ciri_segar_uji(n,1) = Red;
    ciri_segar_uji(n,2) = Green;
    ciri_segar_uji(n,3) = Blue;
    ciri_segar_uji(n,4) = Hue;
    ciri_segar_uji(n,5) = Saturation;
    ciri_segar_uji(n,6) = Value;

    % melakukan ekstraksi ciri tektur GLCM
    Img_gray(~bw) = 0;
    % membentuk matriks co-occurences
    GLCM = graycomatrix(Img_gray,'Offset',[0 1; -1 1; -1 0; -1 -1]);
    stats = graycoprops(GLCM,{'Contrast','Correlation','Energy','Homogeneity'});
    Contrast = mean(stats.Contrast);
    Correlation = mean(stats.Correlation);
    Energy = mean(stats.Energy);
    Homogeneity = mean(stats.Homogeneity);
    
    ciri_segar_uji(n,7) = Contrast;
    ciri_segar_uji(n,8) = Correlation;
    ciri_segar_uji(n,9) = Energy;
    ciri_segar_uji(n,10) = Homogeneity;

    % mengisi variabel target_segar_uji
    target_segar_uji(n,1) = 1;
end

%%% ikan tidak segar (pengujian)
nama_folder = 'data uji/ikan tidak segar';
nama_file = dir(fullfile(nama_folder,'*.jpg'));
jumlah_file = numel(nama_file);

% inisialisasi variabel ciri_tidaksegar_uji dan target_tidaksegar_uji
ciri_tidaksegar_uji = zeros(jumlah_file,10); % 10 nilai
target_tidaksegar_uji = zeros(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file uji
for n = 1:jumlah_file
    % membaca file citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    % ... (rest of the image processing steps)

    % mengisi variabel ciri_tidaksegar_uji dengan ciri hasil ekstraksi
    ciri_tidaksegar_uji(n,1) = Red;
    ciri_tidaksegar_uji(n,2) = Green;
    ciri_tidaksegar_uji(n,3) = Blue;
    ciri_tidaksegar_uji(n,4) = Hue;
    ciri_tidaksegar_uji(n,5) = Saturation;
    ciri_tidaksegar_uji(n,6) = Value;

    % melakukan ekstraksi ciri tektur GLCM
    Img_gray(~bw) = 0;
    % membentuk matriks co-occurences
    GLCM = graycomatrix(Img_gray,'Offset',[0 1; -1 1; -1 0; -1 -1]);
    stats = graycoprops(GLCM,{'Contrast','Correlation', 'Energy','Homogeneity'});
    Contrast = mean(stats.Contrast);
    Correlation = mean(stats.Correlation);
    Energy = mean(stats.Energy);
    Homogeneity = mean(stats.Homogeneity);
    
    ciri_tidaksegar_uji(n,7) = Contrast;
    ciri_tidaksegar_uji(n,8) = Correlation;
    ciri_tidaksegar_uji(n,9) = Energy;
    ciri_tidaksegar_uji(n,10) = Homogeneity;

    % mengisi variabel target_tidaksegar_uji
    target_tidaksegar_uji(n,1) = 2;
end

% menyusun variabel target_uji
ciri_uji = [ciri_segar_uji;ciri_tidaksegar_uji];
target_uji = [target_segar_uji;target_tidaksegar_uji];

% melakukan pengujian menggunakan model k-NN
hasil_uji = predict(Mdl, ciri_uji);

% menghitung nilai akurasi pengujian
akurasi = (sum(target_uji == hasil_uji) / numel(target_uji)) * 100;

% menampilkan nilai akurasi pengujian
disp(['Akurasi Pengujian = ', num2str(akurasi), ' %'])