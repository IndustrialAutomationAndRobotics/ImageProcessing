
cb = checkerboard(4,2);

cb_ref = imref2d(size(cb));

background = zeros(150);

figure(1),imshowpair(cb,cb_ref,background,imref2d(size(background)))

T = [1 0 0; 0 1 0; 100 0 1];
tform_t = affine2d(T);

Shear = [1 3 0; 3 1 0; 0 0 1];
tform_shear = affine2d(Shear);

Scale = [5 0 0; 0 5 0; 0 0 1];
tform_scale = affine2d(Scale);

R = [cosd(30) sind(30) 0; -sind(30) cosd(30) 0; 0 0 1];
tform_r = affine2d(R);

RT = R*T;

tform_rt = affine2d(RT);
[out,out_ref] = imwarp(cb,cb_ref,tform_shear);
figure(2), imshowpair(out, out_ref, background, imref2d(size(background)))