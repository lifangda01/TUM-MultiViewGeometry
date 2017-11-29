%% load input images and set parameters
img = imreadbw('img1.png');
img2 = imreadbw('img2.png');
img = imreadbw('small.png');
img2 = imreadbw('small2.png');
std = 2;

%% get Velocity
[velx, vely] = getFlow(img, img2, std);

%% plot images
subplot(1,2,1)
imshow(img)
subplot(1,2,2)
imshow(img2)

%% plot velocities
colormap jet
subplot(1,2,1)
imagesc(velx)
axis equal
subplot(1,2,2)
imagesc(vely)
axis equal

%% quiver plot
colormap gray
hold off
imagesc(img)
hold on
quiver(-velx*5, -vely*5);
