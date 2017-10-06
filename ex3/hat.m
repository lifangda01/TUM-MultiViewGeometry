function [ w_hat ] = hat( w )
w_hat = zeros(3);
w_hat(1,2) = -w(3);
w_hat(1,3) = w(2);
w_hat(2,3) = -w(1);
w_hat = w_hat - w_hat';
end