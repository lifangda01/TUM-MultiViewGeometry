%% close figure
close all;

%% load & display model
clear all;
[V,F,P] = openOFF('model.off');

% task 1b
% normalize the model coordinates
c = mean(V);
Vsize = size(V);
numVer = Vsize(1);
Vnorm = V - repmat(c, numVer, 1); 
Vhomo = [Vnorm, ones(numVer, 1)];
% rotate and translate
V = rotateAndTranslate(Vhomo, deg2rad(5), 0, deg2rad(25), 0.5, 0.2, 0.1);
V = V(:, 1:3);

%% display model again (possibly with changed vertex positions V)
figure
P = patch('Vertices', V, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
axis equal;
shading interp;
camlight right;
camlight left;