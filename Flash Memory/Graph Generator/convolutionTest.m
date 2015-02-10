% 
x = 0:0.01:4;
N = 100000;
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
hold on

% Time domain approach
% data=[];
% for x2 = 0:0.01:6
% t = (a+mu):0.001:(b+mu);
% integrand = exp(((t-x2).^2)./(2.*sigma2));
% integrated = (1/((b-a)*sqrt(2*pi*sigma2))) * trapz(integrand);
% data = [data;x2,1./integrated];
% end
% norm = 1/trapz(data(:,2));
% plot(data(:,1),data(:,2))