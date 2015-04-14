clear all;close all;

% Plots the retention noise as an ideal graph
x = -1.6:0.001:0.2;
Vp = 2.6;
Verased = 1.4;
t = 10*365*24*3600;

for N = [50000,100000,200000]
[mu_d,sigma_d] = getRetentionParams(N,t,Vp,Verased);
y = normpdf(x,mu_d,sigma_d);
plot(x,y)
hold on
end
