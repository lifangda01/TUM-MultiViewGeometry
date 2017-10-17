close all;
clear all;

img_dist = imreadbw('img1.jpg');

K = [ 388.6795 0  343.7415;
       0  389.4250 234.6182;
       0 0 1];

KNew = [250 0.0 512;
        0 250 384;
        0.0 0.0 1.0];

h_new = 768;
w_new = 1024;
[h_dist, w_dist] = size(img_dist);
% Back project the xy coords in the undistorted image to camera coordinate
[x_new, y_new] = meshgrid(1:w_new, 1:h_new);
xy_new = [reshape(x_new, 1, w_new*h_new); reshape(y_new, 1, w_new*h_new); ones(1,w_new*h_new)];
xy_bp = inv(KNew) * xy_new;
% Project the camera coordinates to pixel coordinates as in the distorted
% image
r = sqrt(sum(xy_bp(1:2, :).^2, 1));
f = 1 ./ (0.926 * r) .* atan(2 * r * tan(0.926 / 2));
xy_bp(1, :) = xy_bp(1, :) .* f;
xy_bp(2, :) = xy_bp(2, :) .* f;
xy_dist = K * xy_bp;
% Look up the new image pixel values
[x_dist, y_dist] = meshgrid(1:w_dist, 1:h_dist);
img_undist = interp2(x_dist, y_dist, img_dist, xy_dist(1,:), xy_dist(2,:));
img_undist = reshape(img_undist, h_new, w_new);

subplot(1,2,2)
imagesc(img_dist)
colormap gray
axis equal
subplot(1,2,1)
imagesc(img_undist)
colormap gray
axis equal

%%
close all;
clear all;

img_dist = imreadbw('img2.jpg');

K = [279.7399 0 347.32012;
     0 279.7399 234.99819;
     0 0 1];

KNew = [300 0.0 512;
        0 300 384;
        0.0 0.0 1.0];
    
h_new = 768;
w_new = 1024;
[h_dist, w_dist] = size(img_dist);
% Back project the xy coords in the undistorted image to camera coordinate
[x_new, y_new] = meshgrid(1:w_new, 1:h_new);
xy_new = [reshape(x_new, 1, w_new*h_new); reshape(y_new, 1, w_new*h_new); ones(1,w_new*h_new)];
xy_bp = inv(KNew) * xy_new;
% Project the camera coordinates to pixel coordinates as in the distorted
% image
r = sqrt(sum(xy_bp(1:2, :).^2, 1));
f = 1 - 0.3407*r + 0.057*r.^2 -0.0046*r.^3 + 0.00014*r.^4;
xy_bp(1, :) = xy_bp(1, :) .* f;
xy_bp(2, :) = xy_bp(2, :) .* f;
xy_dist = K * xy_bp;
% Look up the new image pixel values
[x_dist, y_dist] = meshgrid(1:w_dist, 1:h_dist);
img_undist = interp2(x_dist, y_dist, img_dist, xy_dist(1,:), xy_dist(2,:));
img_undist = reshape(img_undist, h_new, w_new);

subplot(1,2,2)
imagesc(img_dist)
colormap gray
axis equal
subplot(1,2,1)
imagesc(img_undist)
colormap gray
axis equal