clear
addpath('./Random Generators');

Y = [];
N = 150000;

% System Parameters
alpha = 5000; % 5000 p/e cycles per year
tYrs = 5; %timeFunc(N,alpha);
t = tYrs*365*24*3600;
Vp = 2.8;
Verased = 1.4;
deltaVp = 0.25;
SystemParams.Vp = Vp;
SystemParams.deltaVp = deltaVp;

% Simulation Parameters
samples = 10e7;

% Initial Erased state
%Ve = gen_gaussian(Verased,0.35,samples);

% Initial Programmed state
%V0 = gen_uniform(Vp,Vp+deltaVp,samples);

% Random Telegraph Noise
lambda = 0.00025*N^0.5;
%RTN = gen_laplacian(lambda,samples);

% Retention Process
[mu_d,sigma_d] = getRetentionParams(N,t,Vp,Verased);
%retention = gen_gaussian(mu_d,sigma_d,samples);

% Adding random variables
%VtP = retention + V0 + RTN;
%VtE = Ve + RTN;

% %%%%%%%% MM GAUSSIAN TEST PLOT %%%%%%%%
% x = 0:0.01:5;
% total_mu = ((2*Vp+deltaVp)/2) + mu_d;
% total_sigma2 = ((deltaVp^2)/12) + sigma_d^2;
% gauss = normpdf(x,total_mu,sqrt(total_sigma2));
% plot(x,gauss);hold on;

%%%%%%%%%%% FULL CONVOLUTION TEST PLOT %%%%%%%%%%
x = 0:0.0001:5;
y = hachem_conv(x,mu_d,sigma_d,SystemParams,lambda);
plot(x,y,'r','LineWidth',1.5);hold on
%%%%
%%%%%%%%%%% MY CONVOLUTION PLOT %%%%%%%%%%%%
% a = SystemParams.Vp;
% b = SystemParams.Vp + SystemParams.deltaVp;
% y = (normcdf((x-a),mu_d,sigma_d) - normcdf((x-b),mu_d,sigma_d))./(b-a);
% plot(x,y,'--b','LineWidth',1.5);hold on
%%%%
%%%%%%%%%% MATCHED GAUSSIAN: RTN + RETENTION %%%%
total_mu = ((2*SystemParams.Vp+SystemParams.deltaVp)/2) + mu_d;
total_sigma2 = ((SystemParams.deltaVp^2)/12) + sigma_d^2 + 2*(0.00025*N^0.5)^2;
y = normpdf(x,total_mu,sqrt(total_sigma2));
plot(x,y,'--b','LineWidth',1.5); hold on

axis([1 3.5 0 6]);