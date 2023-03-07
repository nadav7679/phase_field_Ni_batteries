function [c, f, s] = nickelfun(x, t, u, dudx)
% u is a vactor of (phi, p, n, u, psi)
% dudx is the spatial derivitive of u

%Du, Dp, Dn = 1 ;
zeta = 1;
epsilon = 1;
beta = 1;
lambda = 1;
gamma = 1;

v1 = 1+u(4);
v2 = 1-u(4);

% w = @(x) x^4 - x^2
w_pp = 84*u(4)^2 - 26;
u_flux_ions = zeta*v1*v2*(dudx(4)*((u(2))+u(3)) + dudx(2)*v1 - dudx(3)*v2);

poisson_flux = epsilon*dudx(1);
p_flux = zeta*u(2)*v1*dudx(4) + u(2)*dudx(1) + dudx(2);
n_flux = -zeta*u(3)*v2*dudx(4) - u(3)*dudx(1) + dudx(3);
u_flux = beta*v1*v2*w_pp*dudx(4) - v1*v2*lambda*dudx(5) + u_flux_ions + dudx(4);
psi_flux = dudx(4);

c = [0; 1; 1; 1; 0];
f = [poisson_flux; p_flux; n_flux; u_flux; psi_flux];
s = [u(3)-u(2); -gamma*u(2)*u(3); -gamma*u(2)*u(3); 0; -u(5)];

end