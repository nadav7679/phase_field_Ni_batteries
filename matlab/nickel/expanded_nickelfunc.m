function [c, f, s] = expanded_nickelfunc(x, t, u, dudx, Du, Dn, zeta, epsilon, beta, lambda, gamma, w_pp)
% u is a vactor of (phi, n, u, psi)
% dudx is the spatial derivitive of u

v1 = 1+u(3);
v2 = 1-u(3);
recombination = (v2.*u(2) - v1.*(1-u(2)))/2;

poisson_flux = epsilon.*dudx(1);
n_flux = (1-u(2)).*(dudx(2) - u(2).*dudx(1));
u_flux = dudx(3) + beta.*v1.*v2.*w_pp(u(3)).*dudx(3) - v1.*v2.*lambda.*dudx(4);
psi_flux = dudx(3);

c = [0; 1; 1; 0];
f = [poisson_flux; Dn*n_flux; Du*u_flux; psi_flux];
s = [-u(2); -recombination; recombination; -u(4)];

end