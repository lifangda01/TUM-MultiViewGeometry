function [ xi ] = SE3ToR6( T )
% Get w
R = T(1:3, 1:3);
w = SO3ToR3(R);
w_norm = norm(w);
w_hat = hat(w);
% Get v
v = 1 \ ((eye(3) - R) * w_hat + w' * w) * T(1:3, 4) * (w_norm)^2;  
xi = [v', w];
end

