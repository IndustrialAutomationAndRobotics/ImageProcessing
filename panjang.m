ori = imread('C:\Users\computer\Desktop\panjangwithref1resize.jpg');
ori = rgb2gray(ori);
figure, imshow(ori), title('original image');

oriFilter = medfilt2(ori, [30 30]);
figure, imshow(oriFilter), title('original image after filter');

[~, threshold] = edge(oriFilter, 'sobel');
fudgeFactor = .5;
binaryMask = edge(oriFilter, 'sobel', threshold * fudgeFactor);
figure, imshow(binaryMask), title('binary gradient mask');

se90 = strel('line', 5, 90);
se0 = strel('line', 5, 0);
binaryDil = imdilate(binaryMask, [se90 se0]);
figure, imshow(binaryDil), title('dilated gradient mask');

binaryFill = imfill(binaryDil, 'holes');
figure, imshow(binaryFill), title('binary image with filled holes');

binaryNoBorder = imclearborder(binaryFill, 6);
figure, imshow(binaryNoBorder), title('cleared border image');

seD = strel('diamond', 1);
binaryErode = imerode(binaryNoBorder, seD);
binaryErode = imerode(binaryErode, seD);
figure, imshow(binaryErode), title('Segmented Image');

binaryOutline = bwperim(binaryErode);
figure, imshow(binaryOutline), title('Outline of the image');

Segout = ori;
Segout(binaryOutline) = 255;
figure, imshow(Segout), title('The outline of the segmented image');

%Find connected component in binary image
cmp = bwconncomp(binaryErode);
%Measure properties of image regions
S = regionprops(cmp, {'BoundingBox'});
y = S(1).BoundingBox(4);
yRef = S(2).BoundingBox(4);

pixelToCM = yRef / 5;
realLength = y / pixelToCM;
str = sprintf('Length of object = %.2f cm',realLength);

figure, imshow(Segout)

for i = 1:length(S)
    rectangle('Position', [S(i).BoundingBox(1), S(i).BoundingBox(2),S(i).BoundingBox(3),S(i).BoundingBox(4)], 'EdgeColor','r'),
end

title(str);

imContoh = imread('C:\Users\computer\Desktop\panjang.jpg');
figure, imshow(imContoh), title('example image on actual grid');
realPixel = 20 * pixelToCM;
pixelDif = y - realPixel;
yOffset = pixelDif / 2;

figure, imshow(Segout)
rectangle('Position', [S(1).BoundingBox(1), S(1).BoundingBox(2) + yOffset,S(1).BoundingBox(3),realPixel], 'EdgeColor','r'),
rectangle('Position', [S(2).BoundingBox(1), S(2).BoundingBox(2),S(2).BoundingBox(3),S(2).BoundingBox(4)], 'EdgeColor','r'),
title('The real length of object is 20 cm');