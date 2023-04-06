function [pl, ql, pr, qr] = expanded_pdebc_current(xl, ul, xr, ur, t, voltage)
% ul and ur are vactors of (phi, n, u, psi)

pl = [0; 0; 0; ul(4)];
ql = [1; 1; 1; 0];

pr = [0; 0; 0; ur(4)];
qr = [1; 1; 1; 0];

end