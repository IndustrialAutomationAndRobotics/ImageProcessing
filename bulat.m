ori = imread('C:\Users\computer\Desktop\bulatwithref.jpeg');
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

binaryNoBorder = imclearborder(binaryDil, 6);
figure, imshow(binaryNoBorder), title('cleared border image');

B = bwboundaries(binaryNoBorder,'noholes');
stat = regionprops(binaryNoBorder,'Centroid');
figure,imshow(binaryNoBorder), hold on
for k = 1 : length(B)
    b = B{k};
    c = stat(k).Centroid;
    plot(b(:,2),b(:,1),'g','linewidth',2);
    text(c(1),c(2),num2str(k),'backgroundcolor','g');
end
hold off
firstCentroid = stat(1).Centroid;
firstBoundary = B{1};
firstBoundaryX = firstBoundary(:,2);
firstBoundaryY = firstBoundary(:,1);


firstRadii = sqrt((firstBoundaryX - firstCentroid(1)).^2 + (firstBoundaryY - firstCentroid(2)).^2);
firstRadiiMean = mean(firstRadii);

secondCentroid = stat(2).Centroid;
secondBoundary = B{2};
secondBoundaryX = secondBoundary(:,2);
secondBoundaryY = secondBoundary(:,1);

secondRadii = sqrt((secondBoundaryX - secondCentroid(1)).^2 + (secondBoundaryY - secondCentroid(2)).^2)
secondRadiiMean = mean(secondRadii);

cmp = bwconncomp(binaryNoBorder);
S = regionprops(cmp, {'BoundingBox'});

figure, imshow(binaryNoBorder)

for i = 1:length(S)
    rectangle('Position', [S(i).BoundingBox(1), S(i).BoundingBox(2),S(i).BoundingBox(3),S(i).BoundingBox(4)], 'EdgeColor','r'),
end

xRef = S(3).BoundingBox(3);
yRef = S(3).BoundingBox(4);

pixelToCM = yRef / 5.3;
realLength1 = firstRadiiMean / pixelToCM;
realLength2 = secondRadiiMean / pixelToCM;
% binaryFill = imfill(binaryDil, 'holes');
% %figure, imshow(binaryFill), title('binary image with filled holes');
% 
% 
% 
% seD = strel('diamond', 1);
% binaryErode = imerode(binaryNoBorder, seD);
% binaryErode = imerode(binaryErode, seD);
% %figure, imshow(binaryErode), title('Segmented Image');
% 
% binaryOutline = bwperim(binaryErode);
% %figure, imshow(binaryOutline), title('Outline of the image');
% 
% Segout = ori;
% Segout(binaryOutline) = 255;
% %figure, imshow(Segout), title('The outline of the segmented image');