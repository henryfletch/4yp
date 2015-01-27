clear
addpath('./Random Generators');

for Vp = [2.6]

% System Parameters
N = 100;
tYrs = 1;
t = tYrs*365*24*3600;
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
retentionStrut.Ks = 0.38;
retentionStrut.Kd = 4e-4;
retentionStrut.Km = 4e-6;
retentionStrut.t0 = 3600;
[mu_d,sigma_d] = getRetentionParams(N,t,Vp,Verased,retentionStrut);
retention= gen_gaussian(mu_d,sigma_d,samples);

% Adding random variables
VtP = V0 + RTN + retention;
VtE = Ve + RTN;

histogram(VtP,200,'DisplayStyle','stairs');
hold on;

end
histogram(VtE,200,'DisplayStyle','stairs');

