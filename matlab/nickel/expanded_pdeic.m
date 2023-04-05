function u0 = expanded_pdeic(x, phi_ic, n_ic, u_ic, psi_ic)

u0(1) = phi_ic(x);
u0(2) = n_ic(x);
u0(3) = u_ic(x);
u0(4) = psi_ic(x); % Second derivitive of u
u0 = u0';
end