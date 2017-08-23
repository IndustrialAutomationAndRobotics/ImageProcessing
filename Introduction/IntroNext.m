image1 = imread('C:\Users\lab E211\Desktop\udanggray.jpg');
image2 = imread('C:\Users\lab E211\Desktop\udanglagisatu.jpg');

image2gray = rgb2gray(image2);

image2gray = imresize(image2gray, [470, 450]);

imageAdd = imadd(image1, image2gray);
imageSub = imsubtract(image1, image2gray);
imageMul = immultiply(image1, 2);
imageDiv = imdivide(image1, 2);

imageLine = image1(100,:);
plot(imageLine);
imageLineCol = image1(:,120);
imagePotong = image1(10:60, 100:120);

imKecik = imresize(image1,[120, 160]);
imKecikLagi = imresize(image1, [60, 80]);
imKecikSangat = imresize(image1, [30, 40]);
imKecikAnat = imresize(image1, [15, 20]);
imBesar = imresize(image1, 2);


figure(1), subplot(2,3,1), imshow(imBesar), subplot(2,3,2), imshow(imKecik), subplot(2,3,3), imshow(imKecikLagi), subplot(2,3,4), imshow(imKecikSangat), subplot(2,3,5), imshow(imKecikAnat);
figure(2), subplot(3,2,1), imshow(imageAdd), title('image Add'), subplot(3,2,2), imshow(imageSub), title('image Sub'), subplot(3,2,3), imshow(imageMul), title('image Multiply'), subplot(3,2,4), imshow(imageDiv), title('image Divide'), subplot(3,2,5), imshow(image1), title('image1'), subplot(3,2,6), imshow(image2gray), title('image2');
