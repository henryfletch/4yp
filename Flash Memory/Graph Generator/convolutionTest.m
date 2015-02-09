% 
x = 0:0.01:4;
N = 1;
Vp = 2.8;
Verased = 1.4;
time = 5*365*24*3600;

% Gaussian Properties
Ks = 0.38;
Kd = 4e-4;
Km = 4e-6;
t0 = 3600;
mu = -Ks*(Vp-Verased)*Kd*(N^0.5)*log(1 + time/t0);
sigma2 = Ks*(Vp-Verased)*Km*(N^0.6)*log(1 + time/t0);
sigma = sqrt(sigma2);

%Uniform Properties
a = Vp;
b = Vp + 0.25;

combinedPDF = (normcdf((x-a),mu,sigma) - normcdf((x-b),mu,sigma))./(b-a);

plot(x,combinedPDF)
