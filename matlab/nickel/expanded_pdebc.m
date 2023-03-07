function [pl, ql, pr, qr] = expanded_pdebc(xl, ul, xr, ur, t, voltage)
% ul and ur are vactors of (phi, p, n, u, psi)

pl = [ul(1)+voltage; 0; 0; 0; 0];
ql = [0; 1; 1; 1; 1];

pr = [ur(1)-voltage; 0; 0; 0; 0];
qr = [0; 1; 1; 1; 1];

end