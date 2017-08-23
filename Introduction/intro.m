image = imread('C:\Users\lab E211\Desktop\smallfish.jpg');


%convert image to grayscale
imagegray = rgb2gray(image);

% convert image to binary
imagebin = dither(imagegray);

% convert variable to double
imagedouble = im2double(image);

% convert image to indexed image
[imageind, map] = rgb2ind(imagedouble, 32);

% cuts out the upper left corner of the image
for i = 1:256
    for j = 1:256
        imagered(i,j) = image(i,j);
    end
end



figure('Name','Original Image'), imshow(image);
figure('Name','Indexed Image')
imshow(imageind)
colormap(map)
figure('Name','Binary Image'), imshow(imagebin);
figure('Name','GrayScale Image'), imshow(imagegray);
figure('Name', 'Reduced Image'), imshow(imagered);
figure('Name', 'Double Image'), imshow(imagedouble);