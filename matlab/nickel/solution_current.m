% Simulation
N = 2000;
M = 800;

t_max = 50;
x_max = 4;
x_min = -4;

x = linspace(x_min, x_max, M);
t = linspace(0, t_max, N);

% Constants
Du = 1;
Dp = 1;
Dn = 1;
zeta = 0.5;
epsilon = 1;
beta = 1;
lambda = 1;
gamma = 1;
voltage = 1;

% PDE's
w_pp = @(x)84*x.^2 - 26;
nickelfunc = @(x, t, u, dudx) expanded_nickelfunc(x, t, u, dudx, Du, Dn, Dp, zeta, epsilon, beta, lambda, gamma, w_pp);

% IC - start with steady state
phi_ic = @(x) sin(x*pi/(x_max-x_min)); 
p_ic = @(x) -(nthroot(x, 3))/(x_max-x_min);
n_ic = @(x) (nthroot(x, 3))/(x_max-x_min);

u_ic = @(x) 0.9*tanh(5*(x));
psi_ic = @(x) 0.9*(-50*tanh(5*(x)).*(sech(5*(x)).^2)); % Second derivitive of tanh(3x)

pdeic = @(x) expanded_pdeic(x, phi_ic, p_ic, n_ic, u_ic, psi_ic);



% BC
pdebc = @(xl, ul, xr, ur, t) expanded_pdebc_current(xl, ul, xr, ur, t, voltage);

% Solution and plot
sol = pdepe(0, nickelfunc, pdeic, pdebc, x, t);
phi = sol(:, :, 1);
p = sol(:, :, 2);
n = sol(:, :, 3);
u = sol(:, :, 4);
psi = sol(:, :, 5);

plot(x, u(1, :), DisplayName="initial")
hold on;
plot(x, u(N, :), DisplayName="final")
legend()


%hold on;
%surf(x, t, u)
xlabel("x")
ylabel("u")