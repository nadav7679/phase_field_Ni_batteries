function [pl, ql, pr, qr] = pdebc(xl, ul, xr, ur, t)
%  Because of the way pdepe treats BC, I needed to make an approximation
%  the Ne
% umann BC. 2/10 is approx dphi/dx at the boundary (linear phi). 
pl = [-2/10*ul(1); 2/10*ul(2); ul(3)+1];
ql = [1; 1; 0];
pr = [-2/10*ur(1); 2/10*ur(2); ur(3)-1];
qr = [1; 1; 0];


end