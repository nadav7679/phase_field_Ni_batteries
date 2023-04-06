% Simulation
N = 2000;
M = 100;


t_max = 20000;
x_max = 10;
x_min = -10;

x = linspace(x_min, x_max, M);
t = linspace(0, t_max, N);

% Constants
Du = 1;
Dn = 1;
alpha = 1;
epsilon = 80;
beta = 1;
lambda = 3;
gamma = 1;
voltage = 0;

% PDE's
w_pp = @(x) 30*x.^2 - 8.8;
nickelfunc = @(x, t, u, dudx) expanded_nickelfunc(x, t, u, dudx, Du, Dn, alpha, epsilon, beta, lambda, gamma, w_pp);

% IC - start with steady state
load("final_values")
plot(x, u_end)

phi_ic = @(new_x) interp1(x, phi_end, new_x);
n_ic = @(new_x) interp1(x, n_end, new_x);
u_ic = @(new_x) interp1(x, u_end, new_x);
psi_ic = @(new_x) interp1(x, psi_end, new_x);

pdeic = @(x) expanded_pdeic(x, phi_ic, n_ic, u_ic, psi_ic);

% BC
pdebc = @(xl, ul, xr, ur, t) expanded_pdebc_output(xl, ul, xr, ur, t, voltage);



% Solution and plot
sol = pdepe(0, nickelfunc, pdeic, pdebc, x, t);
phi = sol(:, :, 1);
n = sol(:, :, 2);
u = sol(:, :, 3);
psi = sol(:, :, 4);


%animation
figure()
grid()
title("Nickel Hydroxide steady state")
xlabel("x")
ylim([-1.1, 2.5])
legend()
hold on;

for i=1:N

  if mod(i, 10) == 0
      subplot(2, 1, 1)
      % p_u = plotyy(x, u(i, :), x, n(i, :));
      p_u = plot(x, u(i, :), Color="black", DisplayName="u(x)");
      %p_phi = plot(x, phi(i, :), Color="green", DisplayName="\phi(x)");

      subplot(2, 1, 2)
      p_n = plot(x, n(i, :), "b", DisplayName="C_e");
      

      pause(0.01)
      delete(p_u)
      delete(p_n)
      %delete(p_phi)
  end
end
