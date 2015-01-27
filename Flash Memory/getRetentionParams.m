function [mu,sigma] = getRetentionParams(N,t,Vp,Verased,retention)

Ks = retention.Ks;
Kd = retention.Kd;
Km = retention.Km;
t0 = retention.t0;

mu = -Ks*(Vp-Verased)*Kd*(N^0.5)*log(1 + t/t0);
sigma = Ks*(Vp-Verased)*Km*(N^0.6)*log(1 + t/t0);

end