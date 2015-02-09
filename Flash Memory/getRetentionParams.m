function [mu,sigma] = getRetentionParams(N,t,Vp,Verased)

% nasty hidden constants; these never change
Ks = 0.38;
Kd = 4e-4;
Km = 4e-6;
t0 = 3600;

mu = -Ks*(Vp-Verased)*Kd*(N^0.5)*log(1 + t/t0);
sigma = sqrt(Ks*(Vp-Verased)*Km*(N^0.6)*log(1 + t/t0));

end