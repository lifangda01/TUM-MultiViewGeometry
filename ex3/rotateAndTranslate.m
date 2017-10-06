function [ V ] = rotateAndTranslate(V, r, p, y, a, b, c)
% Assuming homogeneous coordinates
    R = eye(4);
    R = [[1, 0, 0, 0];
        [0, cos(r), -sin(r), 0];
        [0, sin(r), cos(r), 0];
        [0, 0, 0, 1]] * R;
    R = [[cos(p), 0, sin(p), 0];
        [0, 1, 0, 0];
        [-sin(p), 0, cos(p), 0];
        [0, 0, 0, 1]] * R;
    R = [[cos(y), -sin(y), 0, 0];
        [sin(y), cos(y), 0, 0];
        [0, 0, 1, 0];
        [0, 0, 0, 1]] * R;
    R(1:3,4) = [a, b, c]';
    V = R * V';
    V = V';
end