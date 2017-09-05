clear all
clc

ImOri = imread('C:\Users\lab E211\Desktop\labtest2.jpg');
ImOri = rgb2gray(ImOri); % change image to grayscale

% Apply salt and pepper noise to image
ImNoise = imnoise(ImOri, 'salt & pepper', 0.02);

% Create average kernel. Since the size is [3 3], the value inside will all
% be 1/9
averageKernel = ones(3,3) / 9;

% Apply averaging filter
ImAfterFilterAverage = imfilter(ImNoise, averageKernel, 'replicate');

% Show results
% The noise from the image is still visible, and we get the result of a slightly
% blurred image.
figure(1), subplot(1,2,1), imshow(ImNoise), title('Noise Image')
           subplot(1,2,2), imshow(ImAfterFilterAverage), title('After Averaging Filter');