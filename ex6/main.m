close all;
clear;
% images
img1 = imread('batinria0.tif');
img2 = imread('batinria1.tif');
% matching pairs
[x1,y1,x2,y2] = getpoints2();
% read figures
subplot(1,2,1)
imshow(img1)
hold on
scatter(x1,y1)
hold off
subplot(1,2,2)
imshow(img2)
hold on
scatter(x2,y2)
hold off
npts = 12;
% intrinsics
K1 = [844.310547 0 243.413315; 0 1202.508301 281.529236; 0 0 1];
K2 = [852.721008 0 252.021805; 0 1215.657349 288.587189; 0 0 1];
K1inv = inv(K1);
K2inv = inv(K2);
X1 = K1inv * [x1';y1';ones(1,npts)];
X2 = K2inv * [x2';y2';ones(1,npts)];
X1 = X1';
X2 = X2';
% homo system
A = zeros(npts,9);
for i = 1:npts
    A(i,:) = kron(X1(i,:),X2(i,:));
end
[U,S,V] = svd(A);
if det(U) < 0 | det(V) < 0
    [U,S,V] = svd(-A);
end
E = reshape(V(9,:),3,3);
% project E to essential space
[U,S,V] = svd(E);
E = U * diag([1,1,0]) * V';
% calculate R and T
% R = U * [0,1,0;-1,0,0;0,0,1] * V';
% T = U * [0,-1,0;1,0,0;0,0,1] * U';
R = U * [0,-1,0;1,0,0;0,0,1] * V';
T = U * [0,1,0;-1,0,0;0,0,1] * U';
T = skew2vec(T);
% homo system for reconstruction
M = zeros(npts*3,npts+1);
for i = 1:npts
   M((i*3-2):(i*3),i) = vec2skew(X2(i,:)) * R * X1(i,:)';
   M((i*3-2):(i*3),npts+1) = vec2skew(X2(i,:)) * T;
end
[U,S,V] = svd(M' * M);
% back project
lambda = V(npts+1,1:npts);
gamma = V(npts+1,npts+1);
X = zeros(npts,3);
for i = 1:npts
   X(i,:) = lambda(i) * R * X1(i,:)' + gamma * T;
end
X
figure
scatter3(X(:,1),X(:,2),X(:,3));
