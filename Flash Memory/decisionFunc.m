function y = decisionFunc(N)

% Data for:
% tYrs = 5;
% Vp = 2.8;
% Verased = 1.4;
% deltaVp = 0.25;

a = 0.1566;
b = -0.0005279;
c = 2.638;
d = -4.999e-06;

y1 = a*exp(b*N) + c*exp(d*N);

% Same data, linear fit instead:

m = -1.72e-05;
c = 2.699;

y2 = m*N + c;

y = min(y1,y2);

end