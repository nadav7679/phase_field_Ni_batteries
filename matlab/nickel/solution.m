x = linspace(-1, 1, 500);
t = linspace(0, 2000, 10000);

m = 0;
%nickelfun(x, t, [1,2,3,4,5], [1,2,3,4,5])
sol = pdepe(m, @nickelfun, @pdeic, @pdebc, x, t);

phi = sol(:, :, 1);
p = sol(:, :, 2);
n = sol(:, :, 3);
u = sol(:, :, 4);

plot(x, u(10000, :))
%hold on;
%surf(x, t, u)
xlabel("x")
ylabel("u")