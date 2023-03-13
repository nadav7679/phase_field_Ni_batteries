% Simulation
N = 2000;
M = 1000;

t_max = 200;
x_max = 4;
x_min = -4;

x = linspace(x_min, x_max, M);
t = linspace(0, t_max, N);

% Constants
Du = 1;
Dp = 1;
Dn = 1;
zeta = 1;
epsilon = 1;
beta = 1;
lambda = 1;
gamma = 1;
voltage = 1;

% PDE's
w_pp = @(x)84*x.^2 - 26;
nickelfunc = @(x, t, u, dudx) expanded_nickelfunc(x, t, u, dudx, Du, Dn, Dp, zeta, epsilon, beta, lambda, gamma, w_pp);

% IC
phi_ic = @(x) voltage*(2*x/(x_max-x_min-(x_max+x_min)/(x_max-x_min))); % Linear line
p_ic = @(x) 0.5;
n_ic = @(x) 0.5;

u_ic = @(x) tanh(5*x);
psi_ic = @(x) -50*tanh(5*x).*(sech(5*x).^2); % Second derivitive of tanh(3x)

pdeic = @(x) expanded_pdeic(x, phi_ic, p_ic, n_ic, u_ic, psi_ic);



% BC
pdebc = @(xl, ul, xr, ur, t) expanded_pdebc(xl, ul, xr, ur, t, voltage);

% Solution and plot
sol = pdepe(0, nickelfunc, pdeic, pdebc, x, t);
phi = sol(:, :, 1);
p = sol(:, :, 2);
n = sol(:, :, 3);
u = sol(:, :, 4);
psi = sol(:, :, 5);

%animation
figure()
grid()
title("Nickel Hydroxide steady state")
xlabel("x")
ylim([-1.1, 1.1])
legend()
hold on;

for i=1:N

  p_u = plot(x, u(i, :), Color="black", DisplayName="u(x)")  
  p_n = plot(x, n(i, :), Color="blue", LineStyle="--", DisplayName="C_n(x)")  
  p_p = plot(x, p(i, :), Color="red", LineStyle="--", DisplayName="C_p(x)")
  
  pause(0.1/i)
  delete(p_u)
  delete(p_n)
  delete(p_p)
end

% plot(x, u(1, :), DisplayName="initial")
% hold on;
% plot(x, u(N, :), DisplayName="final")
% legend()

% Animate


%hold on;
%surf(x, t, u)
xlabel("x")
ylabel("u")