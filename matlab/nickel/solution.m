% Simulation
N = 30000;
M = 2000;

t_max = 500;
x_max = 10;
x_min = 0;

x = linspace(x_min, x_max, 500);
t = linspace(0, t_max, N);

% Constants
%Du, Dp, Dn = 1 ;
zeta = 1;
epsilon = 1;
beta = 1;
lambda = 1;
gamma = 1;
voltage = 1;

% PDE's
w_pp = @(x)84*x^2 - 26;
nickelfunc = @(x, t, u, dudx) expanded_nickelfunc(x, t, u, dudx, zeta, epsilon, beta, lambda, gamma, w_pp);

% IC
phi_ic = @(x) voltage*(2*x/(x_max-x_min-(x_max+x_min)/(x_max-x_min))); % Linear line
p_ic = @(x) 0.5;
n_ic = @(x) 0.5;
u_ic = @(x) tanh(3*x);
psi_ic = @(x) -18*tanh(5*x).*(1-tanh(5*x).^2); % Second derivitive of tanh(3x)

pdeic = @(x) expanded_pdeic(x, phi_ic, p_ic, n_ic, u_ic, psi_ic);

% BC
pdebc = @(xl, ul, xr, ur, t) expanded_pdebc(xl, ul, xr, ur, t, voltage);

% Solution and plot
sol = pdepe(0, nickelfunc, pdeic, pdebc, x, t);
phi = sol(:, :, 1);
p = sol(:, :, 2);
n = sol(:, :, 3);
u = sol(:, :, 4);

plot(x, u(N, :))
%hold on;
%surf(x, t, u)
xlabel("x")
ylabel("u")