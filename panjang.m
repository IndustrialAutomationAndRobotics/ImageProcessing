ori = imread('C:\Users\computer\Desktop\panjangwithref1resize.jpg');
%info = imfinfo('C:\Users\computer\Desktop\panjangitamresize.jpg');

%ori = imresize(ori, 0.2);
ori = rgb2gray(ori);

kern = 1/25*ones(5,5);
%ori = imfilter(ori, kern);
ori = medfilt2(ori, [30 30]);
%figure, imshow(ori), title('original image');

[~, threshold] = edge(ori, 'sobel');
fudgeFactor = .5;
binaryMask = edge(ori, 'sobel', threshold * fudgeFactor);
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
binarySegmented = imerode(binaryNoBorder, seD);
binarySegmented = imerode(binarySegmented, seD);
binarySegmented = imerode(binarySegmented, seD);
figure, imshow(binarySegmented), title('segmented image');

cmp = bwconncomp(binarySegmented);
S = regionprops(cmp, {'BoundingBox'});

figure(), imshow(binarySegmented)

for i = 1:length(S)
    rectangle('Position',S.BoundingBox,'EdgeColor','LineWidth',2)
end
% [b,x] = S.BoundingBox(3);
% y = S.BoundingBox(4);
% 
% binaryOutline = bwperim(binarySegmented);
% Segout = ori;
% Segout(binaryOutline) = 255;
% 
% 
% %res = info.Unit;
% resX = info.Width;
% resY = info.Height;
% 
% % if strcmp(res, 'Inch')
% %     lebar = 2.54 * x / resX;
% %     tinggi = 2.54 * y / resY;
% % else
% %     lebar = x / resX;
% %     tinggi = y / resY;
% % end
% 
% lebar = 2.54 * x / resX;
% tinggi = 2.54 * y / resY;
% 
% figure, imshow(Segout), rectangle('Position', [S.BoundingBox(1), S.BoundingBox(2),S.BoundingBox(3),S.BoundingBox(4)], 'EdgeColor','r'), title(y);
% 
