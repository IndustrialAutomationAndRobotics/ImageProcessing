ImOri = imread('C:\Users\lab E211\Desktop\greenday.jpg');
ImOriGray = rgb2gray(ImOri);

% Median filter
ImSPNoise = imnoise(ImOriGray,'salt & pepper', 0.02);
ImMedFil = medfilt2(ImSPNoise);
%imshow(ImSPNoise), figure, imshow(ImMedFil);
figure(1), subplot(1,2,1); imshow(ImSPNoise); subplot(1,2,2); imshow(ImMedFil);

% 1-D digital filter

data = [1:0.2:4];
windowSize = 5;
OneDfilter = filter(ones(1, windowSize)/windowSize,1,data);

% filtering of multidimensional images
A  = [2 2 2 2; 2 NaN 2 2; 2 2 2 2; 2 2 2 2];
h = [1 0; 0 1];
multiDimensionalImageFilter = imfilter(A, h);

% Convulation
B = rand(3);
C = rand(4);
Convolution = conv2(A,B);
ConvolutionSame = conv2(A,B,'same');

s = [1 2 1; 0 0 0; -1 -2 -1];
D = zeros(10);
D(3:7,3:7) = ones(5);
H = conv2(D, s);
V = conv2(D,s');
figure(2), subplot(1,3,1), mesh(H), subplot(1,3,2), mesh(V), subplot(1,3,3), mesh(sqrt(H.^2 + V.^2));

% Imfilter application

% Create a filter, h, that can be used to approximate linear camera motion
j = fspecial('motion', 50, 45);
% Apply the filter, using imfilter, to the image original to create a new
% image, filteredOri
ImfilteredOri = imfilter(ImOri,j); 
figure(3), subplot(1,2,1), imshow(ImOri), subplot(1,2,2), imshow(ImfilteredOri);

% Performing Linear Filtering of Images Using imfilter
% Filtering of images, either by correlation or convolution, can be
% performed using the toolbox fuction imfilter. This example filters an
% image with a 5-by-5 filter containing equal weights. Such a filter is
% often called an averaging filter.
k = ones(5,5)/25;
ImLinearFilter = imfilter(ImOri,k);
figure(3), subplot(1,2,1), imshow(ImOri), subplot(1,2,2), imshow(ImLinearFilter);

E = magic(5);
l = [-1 0 1];
z = imfilter(E, l);

E = uint8(magic(5));
x = imfilter(E, l);
c = imfilter(E,l,'conv');

% When you filter an image, zero padding can result in a dark band around
% the image, as shown in this example
g = ones(5,5)/25;
ImFilterAgain = imfilter(ImOri, g);
ImFilterAgain1 = imfilter(ImOri, g, 'replicate');
figure(4), subplot(1,3,1), imshow(ImOri), title('Original Image'),
subplot(1,3,2), imshow(ImFilterAgain), title('Filtered Image with Black Border'),
subplot(1,3,3), imshow(ImFilterAgain1), title('Filtered Image with Border Replication');

unsharpKernel = fspecial('unsharp');
ImFilterUnsharp = imfilter(ImOri, unsharpKernel);
figure(5), subplot(1,2,1), imshow(ImOri), title('Original Image'),
subplot(1,2,2), imshow(ImFilterUnsharp), title('Unsharp filter');

% Advanced filtering
figure(6),
subplot(2,2,1);
imshow(ImOri); title('Original Image');

motionKernel = fspecial('motion',20,45);
MotionBlur = imfilter(ImOri, motionKernel,'replicate');
subplot(2,2,2);
imshow(MotionBlur); title('Motion Blurred Image');

diskKernel = fspecial('disk', 10);
blurred = imfilter(ImOri, diskKernel, 'replicate');
subplot(2,2,3);
imshow(blurred); title('Blurred Image');

sharpKernel = fspecial('unsharp');
sharpened = imfilter(ImOri, sharpKernel, 'replicate');
subplot(2,2,4);
imshow(sharpened); title('Sharpened Image');

% adjust contrast of image
figure(7),
subplot(1,3,1);
imshow(ImOri); title('Ori Image');

ImAdjustContrast = imadjust(ImOri, [.2 .3 0; .6 .7 1], []);
subplot(1,3,2);
imshow(ImAdjustContrast); title('Adjust Contrast');

% using greythresh
level = graythresh(ImOri);
ImBinary = im2bw(ImOri, level);
subplot(1,3,3);
imshow(ImBinary); title('using threshold');

