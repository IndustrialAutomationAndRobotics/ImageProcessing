clear all
clc

ImOri = imread('C:\Users\lab E211\Desktop\labtest2.jpg');
ImOri = rgb2gray(ImOri); % change image to grayscale

% Apply salt and pepper noise to image
ImNoise = imnoise(ImOri, 'salt & pepper', 0.02);

% Apply Median filter using medfilt2 function
ImAfterFilterMedian = medfilt2(ImNoise, [2 3]);

% Show results

figure(1), subplot(1,2,1), imshow(ImNoise), title('Noise Image')
           subplot(1,2,2), imshow(ImAfterFilterMedian), title('After Median Filter');