function [pl, ql, pr, qr] = expanded_pdebc_current(xl, ul, xr, ur, t, voltage)
% ul and ur are vactors of (phi, p, n, u, psi)

pl = [ul(1) + voltage; 0; 0.3*ul(3); 0; ul(5)];
ql = [0; 1; 1; 1; 0];

pr = [ur(1) - voltage; 0; -0.3*ur(3); 0; ur(5)];
qr = [0; 1; 1; 1; 0];

end