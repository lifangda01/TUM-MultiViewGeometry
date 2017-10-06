function [ w ] = SO3ToR3( R )
if trace(R) == 3
    w = [0, 0, 0];
    return
end
% SO3 to R3
w_norm = acos((trace(R) - 1) / 2);
w = w_norm / (2 * sin(w_norm)) ...
    * [R(3,2) - R(2,3), R(1,3) - R(3,1), R(2,1) - R(1,2)];
end

