function y = decisionFunc(N)

% Data for:
% tYrs = 5;
% Vp = 2.8;
% Verased = 1.4;
% deltaVp = 0.25;

a = 0.1697;
b = -0.0004547;
c = 2.625;
d = -4.273e-06;

y = a*exp(b*N) + c*exp(d*N);

end