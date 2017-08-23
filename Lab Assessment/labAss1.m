IM1 = imread('C:\Users\lab E211\Desktop\enchantress.jpg');
IM2 = imread('C:\Users\lab E211\Desktop\dota2.jpg');

IM1CUT = IM1(30:130, 60:120);
IM2CUT = IM2(74:174, 15:75);

IM1CUT_rgb = IM1(30:130, 60:120, :);
IM2CUT_rgb = IM2(74:174, 15:75, :);

IM1ADD = imadd(IM1CUT, 25);
IM1MUL = immultiply(IM1CUT, 3);

IM1ADD_rgb = imadd(IM1CUT_rgb, 25);
IM1MUL_rgb = immultiply(IM1CUT_rgb, 3);

figure('Name', 'ORI'), subplot(2,2,1), imshow(IM1CUT), title('IM1 Grayscale'), subplot(2,2,2), imshow(IM2CUT), title('IM2 Grayscale'), subplot(2,2,3), imshow(IM1CUT_rgb), title('IM1 RGB'), subplot(2,2,4), imshow(IM2CUT_rgb), title('IM2 RGB');
figure('Name', 'Addition and Multiplication'), subplot(2,2,1), imshow(IM1ADD), title('add grayscale'), subplot(2,2,2), imshow(IM1MUL), title('mul grayscale'), subplot(2,2,3), imshow(IM1ADD_rgb), title('add rgb'), subplot(2,2,4), imshow(IM1MUL_rgb), title('mul rgb');

t = zeros(1,2);

tic;
for i = 1:101
    for j = 1:61
        IM1ADD_time1(i,j) = IM1CUT(i,j) + IM2CUT(i,j);
    end
end
t(1) = toc;

tic;
IM1ADD_time2 = imadd(IM1CUT, IM2CUT);
t(2) = toc;

figure('Name', 'Execution Time'), plot(t), text(1,t(1),'\leftarrow time 1'), text(2,t(2), '\leftarrow time 2');

IM2_double = im2double(IM2CUT);
IM2_bin = im2bw(IM2CUT, 0.4);

figure('Name', 'Convert to double and binary'), subplot(1,3,1), imshow(IM2CUT), title('ori'), subplot(1,3,2), imshow(IM2_double), title('double'), subplot(1,3,3), imshow(IM2_bin), title('binary');

IM2CUT_flip = fliplr(IM2CUT);

figure('Name', 'Horizontal Flip'), subplot(1,2,1), imshow(IM2CUT), title('ori'), subplot(1,2,2), imshow(IM2CUT_flip), title('horizontal flip');

IM2_row100 = IM2CUT(100, :);

figure('Name', 'Plot of grayscale value row 100'), plot(IM2_row100);





