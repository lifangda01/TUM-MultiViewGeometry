close all;
clear all;

[V,F,P] = openOFF('model.off');

%% Visualize the 3D model
P = patch('Vertices', V, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
axis equal;
shading interp;
camlight right;
camlight left;

%% Perspective projection
camera_matrix = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 1];
vertices = [V'; ones(1, 19105)];
pixels = camera_matrix * vertices;
subplot(1,2,1)
scatter(pixels(1,:), pixels(2,:), 'filled')

%% Parallel Projection
vertices = [V'; ones(1, 19105)];
subplot(1,2,2)
scatter(vertices(1,:), vertices(2,:), 'filled')