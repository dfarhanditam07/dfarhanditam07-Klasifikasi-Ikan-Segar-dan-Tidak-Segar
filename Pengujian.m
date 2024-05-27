clc; clear; close all; warning off all; 

% Load the trained k-nn model
load Mdl

% Prompt the user to select an image file
[nama_file, nama_folder] = uigetfile('*.JPG');

% Check if a file is selected
if ~isequal(nama_file, 0)
    % Read the RGB image
    Img = im2double(imread(fullfile(nama_folder, nama_file)));

    % Convert the RGB image to grayscale
    Img_gray = rgb2gray(Img);

    % Convert the grayscale image to binary
    bw = imbinarize(Img_gray, .40);

    % Perform image processing operations
    bw = imcomplement(bw); % Invert the binary image
    bw = imfill(bw, 'holes'); % Fill holes in the binary image
    bw = bwareaopen(bw, 1000); % Remove small objects from the binary image

    % Extract RGB components
    R = Img(:, :, 1); % Red channel
    G = Img(:, :, 2); % Green channel
    B = Img(:, :, 3); % Blue channel

    % Set background pixels to zero (remove background)
    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;

    % Segment the image using HSV color space
    HSV = rgb2hsv(Img);
    H = Img(:, :, 1); % Hue component
    S = Img(:, :, 2); % Saturation component
    V = Img(:, :, 3); % Value component
    Hue = sum(sum(H)) / sum(sum(bw));
    Saturation = sum(sum(S)) / sum(sum(bw));
    Value = sum(sum(V)) / sum(sum(bw));
    Red = sum(sum(R)) / sum(sum(bw));
    Green = sum(sum(G)) / sum(sum(bw));
    Blue = sum(sum(B)) / sum(sum(bw));

    % Prepare the feature vector for testing
    ciri_test = Value;

    % Perform fish freshness classification
    hasil_test = predict(Mdl, ciri_test);

    % Display the original image and the predicted class
    figure, imshow(Img)
    title({['File Name: ', nama_file], ['Predicted Class: ', hasil_test]})
else
    % If no file is selected, return
    return
end