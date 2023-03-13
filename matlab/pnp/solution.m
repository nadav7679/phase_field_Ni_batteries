x = linspace(0, 10, 100);
t = linspace(0, 10, 5000);

m = 0;
sol = pdepe(m, @pnpfun, @pdeic, @pdebc, x, t);

p = sol(:, :, 1);
n = sol(:, :, 2);
phi = sol(:, :, 3);

surf(x, t, p)
xlabel("Distance x")
ylabel("Time t")