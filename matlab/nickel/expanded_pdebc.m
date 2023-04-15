function [pl, ql, pr, qr] = expanded_pdebc(xl, ul, xr, ur, t, voltage)
% ul and ur are vactors of (phi, n, u, psi)

pl = [0; 0; 0; ul(4)];
ql = [1; 1; 1; 0];

pr = [ur(1)+voltage; 0; 0; ur(4)];
qr = [0; 1; 1; 0];

end