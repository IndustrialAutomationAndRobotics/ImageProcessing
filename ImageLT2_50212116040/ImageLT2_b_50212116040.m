clear all
clc

ImMoon = imread('C:\Users\lab E211\Desktop\moon.jpg');

%Resize the image and change it to grayscale
ImMoon = imresize(ImMoon, [345 439]);
ImMoon = rgb2gray(ImMoon);

% Create a laplacian kernel using fspecial function
laplacianKernel = fspecial('laplacian');

% Create A Laplacian filtered image.
ImAfterLaplace = imfilter(ImMoon, laplacianKernel);

% Sharpen the original image with imsharpen fucntion
ImAfterSharpen = imsharpen(ImMoon);

% Subtract the SharpenImage with the original Image
ImAfterSubtract = ImAfterSharpen - ImMoon;

% Show Result
% From the result, we can see that by using the laplacian filter, we get
% better sharpen filter than using imsharpen fucntion.
figure(1), subplot(2,2,1), imshow(ImMoon), title('Original Image')
           subplot(2,2,2), imshow(ImAfterLaplace), title('Laplacian Filter');
           subplot(2,2,3), imshow(ImAfterSharpen), title('Sharpened Image');
           subplot(2,2,4), imshow(ImAfterSubtract), title('Subtracted Sharpened with Original Image');