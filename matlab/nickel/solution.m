% Simulation
N = 1000;
M = 100;

t_max = 50;
x_max = 10;
x_min = -10;

x = linspace(x_min, x_max, M);
t = linspace(0, t_max, N);

% Constants
Du = 1;
Dn = 1;
zeta = 1;
epsilon = 50;
beta = 1;
lambda = 3;
gamma = 1;
voltage = 0;

% PDE's
%w_pp = @(x)60*x.^2 -30*x - 16;
w_pp = @(x) 30*x.^2 - 8.8;

nickelfunc = @(x, t, u, dudx) expanded_nickelfunc(x, t, u, dudx, Du, Dn, zeta, epsilon, beta, lambda, gamma, w_pp);

% IC
phi_ic = @(x) -voltage*(2*x/(x_max-x_min-(x_max+x_min)/(x_max-x_min))); % Linear line
n_ic = @(x) (x>0) * 0.6;
u_ic = @(x) 0.9*tanh(5*x);
psi_ic = @(x) -0.9*50*tanh(5*x).*(sech(5*x).^2); % Second derivitive of tanh(3x)

pdeic = @(x) expanded_pdeic(x, phi_ic, n_ic, u_ic, psi_ic);



% BC
pdebc = @(xl, ul, xr, ur, t) expanded_pdebc(xl, ul, xr, ur, t, voltage);

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

  p_u = plot(x, u(i, :), Color="black", DisplayName="u(x)");
  p_phi = plot(x, phi(i, :), Color="green", DisplayName="\phi(x)");
  p_n = plot(x, n(i, :), Color="blue", LineStyle="--", DisplayName="C_e(x)");
  
  pause(0.01)
  delete(p_u)
  delete(p_n)  
  delete(p_phi)
end
