function [pl, ql, pr, qr] = expanded_pdebc_current(xl, ul, xr, ur, t, voltage)
% ul and ur are vactors of (phi, p, n, u, psi)

pl = [0; 0; 1; 0; ul(5)];
ql = [1; 1; 1; 1; 0];

pr = [0; 0; 1; 0; ur(5)];
qr = [1; 1; 1; 1; 0];

end