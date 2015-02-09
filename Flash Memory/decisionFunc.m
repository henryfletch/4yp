function y = decisionFunc(N)

% Data for:
% tYrs = 5;
% Vp = 2.8;
% Verased = 1.4;
% deltaVp = 0.25;

a = 0.1855;
b = -0.0004369;
c = 2.552;
d = -4.907e-06;

y1 = a*exp(b*N) + c*exp(d*N);
y=y1;
% Same data, linear fit instead:
% 
% m = -1.72e-05;
% c = 2.699;
% 
% y2 = m*N + c;
% 
% y = min(y1,y2);

end