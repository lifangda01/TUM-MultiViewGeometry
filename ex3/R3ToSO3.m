function [ R ] = R3ToSO3( w )
% Vector to skew symmetric
w_hat = hat(w);
% Skew symmetric to R, using Rodrigues
w_norm = norm(w);
R = eye(3) ...
    + w_hat / w_norm * sin(w_norm) ...
    + w_hat * w_hat / w_norm^2 * (1 - cos(w_norm));
end