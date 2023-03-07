function u0 = expanded_pdeic(x, phi_ic, p_ic, n_ic, u_ic, psi_ic)

u0(1) = phi_ic(x);
u0(2) = p_ic(x);
u0(3) = n_ic(x);
u0(4) = u_ic(x);
u0(5) = psi_ic(x); % Second derivitive of u
u0 = u0';
end