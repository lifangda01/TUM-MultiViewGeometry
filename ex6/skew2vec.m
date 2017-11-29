function [ x ] = skew2vec( X )
% Convert a skew symmetrical to its 3D vector form.
x = [X(3,2);X(1,3);X(2,1)];
end