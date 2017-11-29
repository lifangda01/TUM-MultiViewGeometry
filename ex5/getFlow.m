function [ velx, vely ] = getFlow( img, img2, std )
[h, w] = size(img);
% calc image gradients
dx = zeros(size(img));
dy = zeros(size(img));
dx(:,2:(end-1)) = 0.5*(img(:,3:end) - img(:,(1:end-2)));
dy(2:(end-1),:) = 0.5*(img(3:end,:) - img((1:end-2),:));

% create gaussian kernel
r = 2*std;
sz = 2*r+1;
kernel = fspecial('gaussian', [sz sz], std);

% calc tensor content and convolve it with Gaussian kernel
xx = conv2(dx .*dx, kernel, 'same');
yy = conv2(dy .*dy, kernel, 'same');
xy = conv2(dx .*dy, kernel, 'same');

% calc "time" gradient
dt = img2 - img;

% calc flow (with loop this time).
det = xx.*yy - xy.*xy;
dtdx = dt .* dx;
dtdy = dt .* dy;
ukernel = ones(sz,sz);
dtdxconv = conv2(dtdx, ukernel, 'same');
dtdyconv = conv2(dtdy, ukernel, 'same');
for i = 1:h
    for j = 1:w
        % need to calculate the scalar product to get int(dt*dx)
        velx(i,j) = (yy(i,j)*dtdxconv(i,j) - xy(i,j)*dtdyconv(i,j)) / det(i,j);
        vely(i,j) = (-xy(i,j)*dtdxconv(i,j) + xx(i,j)*dtdyconv(i,j)) / det(i,j);
    end
end

end