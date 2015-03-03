clear
 
addpath('convolutionFunction');
% 
x = -3:0.001:1;
N = 10000;
Vp = 2.8;
Verased = 1.4;
time = 5*365*24*3600;

% Retention Gaussian Properties
Ks = 0.38;
Kd = 4e-4;
Km = 4e-6;
t0 = 3600;
mu_ret = -Ks*(Vp-Verased)*Kd*(N^0.5)*log(1 + time/t0);
sigma2_ret = Ks*(Vp-Verased)*Km*(N^0.6)*log(1 + time/t0);
sigma_ret = sqrt(sigma2_ret);

% RTN (laplacian) properties
lambda = 0.00025*N^0.5;

%Uniform Properties
a = Vp;
b = Vp + 0.25;

y = rtnRet(x,mu_ret,sigma_ret,lambda);
area = trapz(x,y);
plot(x,y/area);hold on
%y2 = ((sigma_ret^2./((sigma_ret^2/lambda) + mu_ret - x)) - (sigma_ret^2./(-(sigma_ret^2/lambda) + mu_ret - x)));
%plot(x,y2);
yRet = normpdf(x,mu_ret,sigma_ret);
plot(x,yRet); hold on
