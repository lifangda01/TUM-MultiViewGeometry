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
if det(U) < 0 || det(V) < 0
    [U,S,V] = svd(-A);
end
E = reshape(V(:,9),3,3);
% project E to essential space
[U,S,V] = svd(E);
if det(U) < 0 || det(V) < 0
    [U,S,V] = svd(-E);
end
% S
% det(U) 
% det(V)
E = U * diag([1,1,0]) * V';
% calculate R and T
Rz1 = [0,1,0;-1,0,0;0,0,1];
Rz2 = [0,-1,0;1,0,0;0,0,1];
R1 = U * Rz1 * V';
R2 = U * Rz2 * V';
T1 = U * Rz1 * U';
T2 = U * Rz2 * U';
T1 = skew2vec(T1);
T2 = skew2vec(T2);
% do reconstruction
backproject(R1,T1,X1,X2,npts);
backproject(R1,T2,X1,X2,npts);
backproject(R2,T1,X1,X2,npts);
backproject(R2,T2,X1,X2,npts);
