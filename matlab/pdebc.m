function [pl, ql, pr, qr] = pdebc(xl, ul, xr, ur, t)
%  Because of the way pdepe treats BC, I needed to make an approximation
%  the Ne
% umann BC. 2/10 is approx dphi/dx at the boundary (linear phi). 

pl = [0; 0; ul(3)+1];
ql = [1; 1; 0];
pr = [0; 0; ur(3)-1];
qr = [1; 1; 0];


end