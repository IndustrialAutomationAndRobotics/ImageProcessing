ImOri = imread('C:\Users\lab E211\Desktop\bulan.jpg');

filta = fspecial('unsharp');
filtaLap = fspecial('laplacian');

ImSharp = imfilter(ImOri, filta);
ImSharpLap = imfilter(ImOri, filtaLap);
ImTolak = ImOri - ImSharpLap;

figure(1),subplot(2,2,1), imshow(ImOri), title('Original Image'), 
subplot(2,2,2), imshow(ImSharpLap), title('Laplacian Image')
subplot(2,2,3), imshow(ImSharp), title('Filtered Image')
subplot(2,2,4), imshow(ImTolak), title('Laplacian Tolak');


ImBone = imread('C:\Users\lab E211\Desktop\tulang.jpg');
ImBone = rgb2gray(ImBone);
ImBone = im2double(ImBone);

ImBoneLap = imfilter(ImBone, filtaLap);
ImBoneSharp = ImBone - ImBoneLap;
filtaSobel = fspecial('sobel');
filtaAve5 = fspecial('average', [5 5]);
ImBoneSobel = imfilter(ImBoneSharp, filtaSobel);
ImBoneAve = imfilter(ImBoneSobel, filtaAve5);
ImBoneTolak = ImBoneSharp - ImBoneAve;
ImBoneTambah = ImBone + ImBoneTolak;








figure(2), subplot(2,4,1), imshow(ImBone), title('Tulang'),
subplot(2,4,2), imshow(ImBoneLap), title('Laplacian'),
subplot(2,4,3), imshow(ImBoneSharp), title('Laplacian tolak'),
subplot(2,4,4), imshow(ImBoneSobel), title('Sobel'),
subplot(2,4,5), imshow(ImBoneAve), title('Average'),
subplot(2,4,6), imshow(ImBoneTolak), title('Tolak'),
subplot(2,4,7), imshow(ImBoneTambah), title('Tambah'),
subplot(2,4,8), imshow(ImBonePow), title('Power');

%https://www.mathworks.com/matlabcentral/fileexchange/56934-power-law-transformation-of-an-image?focused=6272237&tab=function
[m,n] = size(ImBone);
ImBonePow = zeros(m,n);
c = 1;
y = 1.2;
g = [0.5 0.7 0.9 1 2 3 4 5 6];

for r=1:length(g)
for i = 1:m
    for j = 1 : n
        ImBonePow(i,j) = c * ImBoneTambah(i,j).^g(r);
    end
end
figure, imshow(ImBonePow); title('Power-law trasnformation');xlabel('Gamma = '), xlabel(g(r));
end