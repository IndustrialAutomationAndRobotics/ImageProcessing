
cb = checkerboard;
figure(1), imshow(cb);

cb_ref = imref2d(size(cb));

T = [1 0 0; 0 1 0; 20 30 1];

tform = affine2d(T);

[cb_translated, cb_translated_ref] = imwarp(cb,tform);

figure(2), subplot(1,2,1);
imshow(cb,cb_ref);
subplot(1,2,2);
imshow(cb_translated,cb_translated_ref);

cb_translated_ref = cb_ref;
cb_translated_ref.XWorldLimits(2) = cb_translated_ref.XWorldLimits(2) + 20; + 20;
cb_translated_ref.YWorldLimits(2) = cb_translated_ref.YWorldLimits(2) + 20;

[cb_translated, cb_translated_ref] = imwarp(cb, tform, 'OutputView', cb_translated_ref);

figure(3), subplot(1,2,1);
imshow(cb, cb_ref);
subplot(1,2,2);
imshow(cb_translated,cb_translated_ref);