function u0 = pdeic(x)

u0(1) = x;
u0(2) = 0.5;
u0(3) = 0.5;

%u0(4) = (2/10)*x - 1;
%y = 10*(x-0.5);

u0(4) = tanh(3*x);
u0(5) = -18*tanh(5*x).*(1-tanh(5*x)^2); % Second derivitive of tanh(10*(x-0.5))
u0 = u0';
end