% read our image
ori = imread('D:\Workspace\ImageProcessing\LabTestLengthAndCentroid\panjangwithref1resize.jpg');
ori = rgb2gray(ori);
figure, imshow(ori), title('original image');

% apply med filter to remove white spots
oriFilter = medfilt2(ori, [30 30]);
figure, imshow(oriFilter), title('original image after filter');

% Image Segmentation Process
% Using edge to get the binary image of our object
[~, threshold] = edge(oriFilter, 'sobel');
fudgeFactor = 1;
binaryMask = edge(oriFilter, 'sobel', threshold * fudgeFactor);
figure, imshow(binaryMask), title('binary gradient mask');

% dilate the line to make sure it is connected
se90 = strel('line', 5, 90);
se0 = strel('line', 5, 0);
binaryDil = imdilate(binaryMask, [se90 se0]);
figure, imshow(binaryDil), title('dilated gradient mask');

% fill our outline image
binaryFill = imfill(binaryDil, 'holes');
figure, imshow(binaryFill), title('binary image with filled holes');

% get rid of the white spots at the border
binaryNoBorder = imclearborder(binaryFill, 6);
figure, imshow(binaryNoBorder), title('cleared border image');

% erode the image so that it is the same size as the original image
seD = strel('diamond', 1);
binaryErode = imerode(binaryNoBorder, seD);
binaryErode = imerode(binaryErode, seD);
figure, imshow(binaryErode), title('Segmented Image');

% get outline and overlay it with original image
binaryOutline = bwperim(binaryErode);
figure, imshow(binaryOutline), title('Outline of the image');

Segout = ori;
Segout(binaryOutline) = 255;
figure, imshow(Segout), title('The outline of the segmented image');

% Find connected component in binary image
cmp = bwconncomp(binaryErode);

% Measure properties of image regions
S = regionprops(cmp, {'BoundingBox'});
y = S(1).BoundingBox(4);
yRef = S(2).BoundingBox(4);

% use the pixel length to get the pixelToCM ratio
pixelToCM = yRef / 5;
% divide object pixel length with ratio to get actual length
realLength = y / pixelToCM;
str = sprintf('Length of object = %.2f cm',realLength);

% The length is not the same because of perspective distortion
figure, imshow(Segout)

for i = 1:length(S)
    rectangle('Position', [S(i).BoundingBox(1), S(i).BoundingBox(2),S(i).BoundingBox(3),S(i).BoundingBox(4)], 'EdgeColor','r'),
end

title(str);

% example image shows perspective distortion
imContoh = imread('C:\Users\computer\Desktop\panjang.jpg');
figure, imshow(imContoh), title('example image on actual grid');

% draw the bounding box with actual length
realPixel = 20 * pixelToCM;
pixelDif = y - realPixel;
yOffset = pixelDif / 2;

figure, imshow(Segout)
rectangle('Position', [S(1).BoundingBox(1), S(1).BoundingBox(2) + yOffset,S(1).BoundingBox(3),realPixel], 'EdgeColor','r'),
rectangle('Position', [S(2).BoundingBox(1), S(2).BoundingBox(2),S(2).BoundingBox(3),S(2).BoundingBox(4)], 'EdgeColor','r'),
title('The real length of object is 20 cm');