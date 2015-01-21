function y = mem_retention(x,time,N,Verased,Vp)

%Hidden constants!
Ks = 0.38;
Kd = 4e-4;
Km = 4e-6;
t0 = 3600;

%Calculate mu and sigma from PDF: FlashCapacity.pdf (page 4 equation(s) 9)
mu = -Ks*(Vp-Verased)*Kd*(N^0.5)*log(1 + time/t0);
sigma = Ks*(Vp-Verased)*Km*(N^0.6)*log(1 + time/t0);

y = normpdf(x,mu,sqrt(sigma));
y(isnan(y)) = 0;

end