function [c, f, s] = pnpfun(x, t, u, dudx)
% u is a vactor of (p, n, phi)
% dudx is the spatial derivitive of u

c = [1; 1; 0];
f = [dudx(1) + u(1)*dudx(3) ; dudx(2) - u(2)*dudx(3); dudx(3)];
s = [0; 0; u(1)-u(2)];

end