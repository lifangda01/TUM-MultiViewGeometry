clear all;
w = [1, 2, 3];
w = w / norm(w)

R = R3ToSO3(w)
SO3ToR3(R)
%%
clear all;
w = [1, 2, 3];
w = w / norm(w);
xi = [1, 2, 3, w]

T = R6ToSE3(xi)
SE3ToR6(T)