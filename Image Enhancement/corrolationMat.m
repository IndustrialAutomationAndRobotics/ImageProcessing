clear all
clc

ImOli = imread('C:\Users\lab E211\Desktop\supongubub2.jpg');
ImOliGray = rgb2gray(ImOli);
kern = 1/9*ones(3,3);
kernBesar = 1/25*ones(5,5);
kernBesarGile = 1/100*ones(10,10);

weighted = [1,2,1;2,4,2;1,2,1];
weightedKern = 1/16*weighted;

ImSmooth = imfilter(ImOli,kern);
ImSmoothBesar = imfilter(ImOli,kernBesar);
ImSmoothBesarGile = imfilter(ImOli,kernBesarGile);
ImWeightedSmooth = imfilter(ImOli, weightedKern);

ImNoise = imnoise(ImOliGray, 'salt & pepper', 0.2);
ImNoNoise = medfilt2(ImNoise, [5 5]);

ImNoiseGaussian = imnoise(ImOliGray, 'gaussian',0,0.01);
ImNoiseLocalVar = imnoise(ImOliGray, 'localvar',  0.01);

figure(1), subplot(2,2,1), imshow(ImOli), subplot(2,2,2), imshow(ImSmooth), subplot(2,2,3), imshow(ImSmoothBesar), subplot(2,2,4), imshow(ImSmoothBesarGile);
figure(2), imshow(ImWeightedSmooth);
figure(3), subplot(2,1,1), imshow(ImNoise), subplot(2,1,2), imshow(ImNoNoise);
figure(4), subplot(2,1,1), imshow(ImNoiseGaussian), subplot(2,1,2), imshow(ImNoiseLocalVar);


A = [17, 24, 1, 8, 15; 23, 5, 7, 14, 16; 4, 6, 13, 20, 22; 10, 12, 19, 21, 3; 11, 18, 25, 2, 9];
h = [8, 1, 6; 3, 5, 7; 4, 9, 2];

B = imfilter(A,h);

C = imfilter(A, h, 'conv');

D = imfilter(A, h, 'replicate');

E = medfilt2(A, [3 3]);