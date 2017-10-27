ori = imread('C:\Users\computer\Desktop\newim\panjangLagiBaru1.jpeg');
ori = rgb2gray(ori);
figure, imshow(ori), title('original image');


oriFilter = imsharpen(ori);
oriFilter = medfilt2(oriFilter, [20 20]);
figure, imshow(oriFilter), title('original image after filter');

[~, threshold] = edge(oriFilter, 'sobel');
fudgeFactor = .5;
binaryMask = edge(oriFilter, 'sobel', threshold * fudgeFactor);
%figure, imshow(binaryMask), title('binary gradient mask');

se90 = strel('line', 5, 90);
se0 = strel('line', 5, 0);
binaryDil = imdilate(binaryMask, [se90 se0]);
%figure, imshow(binaryDil), title('dilated gradient mask');

binaryFill = imfill(binaryDil, 'holes');
%figure, imshow(binaryFill), title('binary image with filled holes');

binaryNoBorder = imclearborder(binaryFill, 6);
%figure, imshow(binaryNoBorder), title('cleared border image');

seD = strel('diamond', 1);
binaryErode = imerode(binaryNoBorder, seD);
binaryErode = imerode(binaryErode, seD);
%figure, imshow(binaryErode), title('Segmented Image');

binaryOutline = bwperim(binaryErode);
%figure, imshow(binaryOutline), title('Outline of the image');

Segout = ori;
Segout(binaryOutline) = 255;
%figure, imshow(Segout), title('The outline of the segmented image');