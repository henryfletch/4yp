clear
addpath('./Random Generators');

Y = [];

%parfor iN = 21:45;

%N = iN*1000;
N = 2000;

% System Parameters
alpha = 5000; % 5000 p/e cycles per year
tYrs = 5; %timeFunc(N,alpha);
t = tYrs*365*24*3600;
Vp = 2.8;
Verased = 1.4;
deltaVp = 0.25;

% Simulation Parameters
samples = 10e7;

% Initial Erased state
Ve = gen_gaussian(Verased,0.35,samples);

% Initial Programmed state
V0 = gen_uniform(Vp,Vp+deltaVp,samples);

% Random Telegraph Noise
lambda = 0.00025*N^0.5;
RTN = gen_laplacian(lambda,samples);

% Retention Process
[mu_d,sigma_d] = getRetentionParams(N,t,Vp,Verased);
retention = gen_gaussian(mu_d,sigma_d,samples);

% Adding random variables
VtP = retention + V0 + RTN;
VtE = Ve + RTN;

% %%%%%%%% GAUSSIAN TEST PLOT %%%%%%%%
% x = 0:0.01:5;
% total_mu = ((2*Vp+deltaVp)/2) + mu_d;
% total_sigma2 = ((deltaVp^2)/12) + sigma_d^2;
% gauss = normpdf(x,total_mu,sqrt(total_sigma2));
% plot(x,gauss);hold on;

%%%%%%%%%%% RTN + RETENTION %%%%%%%%%%
Vrr = retention + RTN;
histogram(Vrr,10e2,'DisplayStyle','stairs','Normalization','pdf');

%histogram(VtP,1000,'DisplayStyle','stairs','Normalization','pdf');
%[numberP,edgesP] = histcounts(VtP,1000);
hold on;

%histogram(VtE,1000,'DisplayStyle','stairs','Normalization','pdf');
%[numberE,edgesE] = histcounts(VtE,1000);

%midpoint = getMidpoint(numberP,edgesP,numberE,edgesE);

%Y(iN,:) = [N,midpoint];
%end
%axis([0 4 0 5]);