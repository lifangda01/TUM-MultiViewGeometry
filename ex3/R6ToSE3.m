function [ T ] = R6ToSE3( xi )
% xi = [v w]
v = xi(1:3);
w = xi(4:6);
w_norm = norm(w);
w_hat = hat(w);
R = R3ToSO3(w);
% Get translation
T = eye(4);
T(1:3,1:3) = R;
T(1:3,4) = ((eye(3) - R) * w_hat * v' + w' * w * v') / (w_norm)^2;
end

