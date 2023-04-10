% Simulation
N = 5000;
M = 500;
animate = false;

t_max = 20000;
x_max = 10;
x_min = -10;

x = linspace(x_min, x_max, M);
t = linspace(0, t_max, N);

% Constants
Du = 1;
Dn = 1;
alpha = 1;
epsilon = 50;
beta = 1;
lambda = 3;
voltage = 0;

% PDE's
w_pp = @(x) 30*x.^2 - 8.8;
nickelfunc = @(x, t, u, dudx) expanded_nickelfunc(x, t, u, dudx, Du, Dn, alpha, epsilon, beta, lambda, w_pp);

% IC - start with steady state
phi_ic = @(x) -voltage*(2*x/(x_max-x_min-(x_max+x_min)/(x_max-x_min))); 
n_ic = @(x) (x > 0.5)* 0.9 ;
u_ic = @(x) 0.9*tanh(5*(x));
psi_ic = @(x) -0.9*(50*tanh(5*(x)).*(sech(5*(x)).^2)); % Second derivitive of tanh(3x)

%phi_ic = phi(end, :);
%n_ic = n(end, :);
%u_ic = u(end, :);
%psi_ic = psi(end, :);

pdeic = @(x) expanded_pdeic(x, phi_ic, n_ic, u_ic, psi_ic);

% BC
pdebc = @(xl, ul, xr, ur, t) expanded_pdebc_input(xl, ul, xr, ur, t, voltage);



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

if (animate)
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
end


phi_end = phi(end, :);
n_end = n(end, :);
u_end = u(end, :);
psi_end = psi(end, :);
save("final_values", "phi_end", "n_end", "u_end", "psi_end")

tiledlayout(1,2)
colororder(["black", "blue"]);

% Left plot
ax1 = nexttile;
yyaxis(ax1, 'left')
plot(ax1, x, u(1,:), LineWidth=2, DisplayName="u(x)")
ylim(ax1, [-1.1, 1.1])
grid(ax1, "on")

yyaxis(ax1, 'right')
plot(ax1, x, n(1, :), LineWidth=2.2, DisplayName = "n(x)", LineStyle="--")
ylim(ax1, [-0.1, 1.1])
yticklabels(ax1, [])
legend(ax1);
xlabel(ax1, "x");

% Right plot
ax2 = nexttile;
yyaxis(ax2, 'left')
plot(ax2, x, u(end,:), LineWidth=2, DisplayName="u(x)")
ylim(ax2, [-1.1, 1.1])
yticklabels(ax2, [])
grid(ax2, "on")

yyaxis(ax2, 'right')
plot(ax2, x, n(end, :), LineWidth=2.2, DisplayName = "n(x)", LineStyle="--")
ylim(ax2, [-0.1, 1.1])
xlabel("x");

