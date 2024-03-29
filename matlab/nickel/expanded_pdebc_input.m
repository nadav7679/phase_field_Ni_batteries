function [pl, ql, pr, qr] = expanded_pdebc_input(xl, ul, xr, ur, t, voltage)
% ul and ur are vactors of (phi, n, u, psi)

pl = [ul(1); 0; 0; ul(4)];
ql = [0; 1; 1; 0];

pr = [ur(1); -0.001; 0; ur(4)];
qr = [0; 1; 1; 0];

end