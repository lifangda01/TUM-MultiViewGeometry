function [ X ] = vec2skew( x )
% Convert a 3D vector to its skew symmetrical form.
X = [0,-x(3),x(2);x(3),0,-x(1);-x(2),x(1),0];
end

