clear
addpath('./Random Generators');

Y = [];

for N = 100000

% System Parameters
tYrs = 5;
t = tYrs*365*24*3600;
Vp = 2.8;
Verased = 1.4;
deltaVp = 0.25;

% Simulation Parameters
samples = 10e6;

% Initial Erased state
Ve = gen_gaussian(Verased,0.35,samples);

% Initial Programmed state
V0 = gen_uniform(Vp,Vp+deltaVp,samples);

% Random Telegraph Noise
lambda = 0.00025*N^0.5;
RTN = gen_laplacian(lambda,samples);

% Retention Process
[mu_d,sigma_d] = getRetentionParams(N,t,Vp,Verased);
retention= gen_gaussian(mu_d,sigma_d,samples);

% Adding random variables
VtP = retention + V0 + RTN;
VtE = Ve + RTN;

histogram(VtP,1000,'DisplayStyle','stairs','Normalization','pdf');
%[numberP,edgesP] = histcounts(VtP,1000);
hold on;

histogram(VtE,1000,'DisplayStyle','stairs','Normalization','pdf');
%[numberE,edgesE] = histcounts(VtE,1000);

%midpoint = getMidpoint(numberP,edgesP,numberE,edgesE);

%Y = [Y;N,midpoint];
end