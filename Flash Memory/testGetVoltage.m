% Test Script
clear
tic
addpath('./Random Generators');

% System Parameters
SystemParams.N = 10000;
SystemParams.tYrs = 10;
SystemParams.Verased = 1.4;
SystemParams.Vp = 2.6;
SystemParams.deltaVp = 0.25;

length = 64000;
data = randi([1,1],length,1);

y = memoryGetVoltage(data,SystemParams);

histogram(y,100);
toc