clear all
clc

ImOri = imread('C:\Users\lab E211\Desktop\labtest2.jpg');
ImOri = rgb2gray(ImOri); % change image to grayscale

% Apply salt and pepper noise to image
ImNoise = imnoise(ImOri, 'salt & pepper', 0.02);

convKernel = [8 1 6;3 5 7;4 9 2];

ImAfterFilterConv = imfilter(ImNoise, convKernel, 'conv');

% Show results
% The result of a very bright image, The kernel use were not suitable to
% remove the noise.
figure(1), subplot(1,2,1), imshow(ImNoise), title('Noise Image')
           subplot(1,2,2), imshow(ImAfterFilterConv), title('After Using Convolution with given kernel');