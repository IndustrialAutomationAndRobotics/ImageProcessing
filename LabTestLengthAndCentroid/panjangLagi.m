% read our image
ori = imread('D:\Workspace\ImageProcessing\LabTestLengthAndCentroid\panjangLagiLagi2.jpeg');
ori = rgb2gray(ori);
figure, imshow(ori), title('original image');

% apply med filter to remove white spots
oriFilter = medfilt2(ori, [50 50]);
figure, imshow(oriFilter), title('original image after filter');

% Image Segmentation Process
% Using edge to get the binary image of our object
[~, threshold] = edge(oriFilter, 'sobel');
fudgeFactor = .5;
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
x = S(1). BoundingBox(3);
xRef = S(2).BoundingBox(3);

% use the pixel length to get the pixelToCM ratio
pixelToCM = xRef / 5;
% divide object pixel length with ratio to get actual length
realLength = x / pixelToCM;
str = sprintf('Length of object = %.2f cm', realLength);

% The length is not the same because of perspective distortion
figure, imshow(Segout)

for i = 1:length(S)
    rectangle('Position', [S(i).BoundingBox(1), S(i).BoundingBox(2),S(i).BoundingBox(3),S(i).BoundingBox(4)], 'EdgeColor','r'),
end

title(str);

% use bwboundaries to get the plot values of our object
B = bwboundaries(binaryErode,'noholes');

BoundaryRef = B{2};
BoundaryRefY = BoundaryRef(:,1);
BoundaryObj = B{1};
BoundaryObjY = BoundaryObj(:,1);

MaxBoundaryObjY = max(BoundaryObjY);
MinBoundaryRefY = min(BoundaryRefY);

% crop our image
refCrop = imcrop(binaryErode,[1 (MinBoundaryRefY) 1080 10]);
objCrop = imcrop(binaryErode, [1 (MaxBoundaryObjY - 25) 1080 25]);
figure, imshow(refCrop);
figure, imshow(objCrop);

% use the data from crop image to get the pixelToCM ratio and actual length
cmpRefCrop = bwconncomp(refCrop);
SRefCrop = regionprops(cmpRefCrop, {'BoundingBox'});
xRefCrop = SRefCrop. BoundingBox(3);

cmpObjCrop = bwconncomp(objCrop);
SObjCrop = regionprops(cmpObjCrop, {'BoundingBox'});
xObjCrop = SObjCrop.BoundingBox(3);

pixelToCMCrop = xRefCrop / 5;
realLengthCrop = xObjCrop / pixelToCMCrop;
str = sprintf('Length of object = %.2f cm', realLengthCrop);

figure, imshow(refCrop),
rectangle('Position', [SRefCrop. BoundingBox(1), SRefCrop. BoundingBox(2),SRefCrop. BoundingBox(3),SRefCrop. BoundingBox(4)], 'EdgeColor','r');
figure, imshow(objCrop), title(str),
rectangle('Position', [SObjCrop.BoundingBox(1), SObjCrop.BoundingBox(2),SObjCrop.BoundingBox(3),SObjCrop.BoundingBox(4)], 'EdgeColor','r');

