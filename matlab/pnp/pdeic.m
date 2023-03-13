function u0 = pdeic(x)
% initial conditions for the pnp L=10
u0(1) = 0.5;
u0(2) = 0.5;
u0(3) = (2/10)*x - 1;
u0 = u0';
end