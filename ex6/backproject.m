function backproject(R,T,X1,X2,npts)
% Reconstruct the 3D points
% homo system for reconstruction
M = zeros(npts*3,npts+1);
for i = 1:npts
   M((i*3-2):(i*3),i) = vec2skew(X2(i,:)) * R * X1(i,:)';
   M((i*3-2):(i*3),npts+1) = vec2skew(X2(i,:)) * T;
end
[V,D] = eig(M' * M);
% back project
lambda1 = V(1:npts,1);
gamma = V(npts+1,1);
if all(lambda1 > 0)
    Xb1 = zeros(npts,3);
    for i = 1:npts
       Xb1(i,:) = lambda1(i) * X1(i,:);
    end
    Xb2 = zeros(npts,3);
    for i = 1:npts
       Xb2(i,:) = lambda1(i) * R * X1(i,:)' + gamma * T;
    end
    if all(Xb2(:,3) > 0)
        subplot(1,2,1)
        scatter3(Xb1(:,1),Xb1(:,2),Xb1(:,3));
        axis equal; xlabel('x'); ylabel('y'); zlabel('z');
        title('Camera Frame 1');
        subplot(1,2,2)
        scatter3(Xb2(:,1),Xb2(:,2),Xb2(:,3));
        axis equal; xlabel('x'); ylabel('y'); zlabel('z');
        title('Camera Frame 2');
    end
end