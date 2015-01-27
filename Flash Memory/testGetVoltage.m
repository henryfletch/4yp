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

% Retention Parameters
retentionData.Ks = 0.38;
retentionData.Kd = 4e-4;
retentionData.Km = 4e-6;
retentionData.t0 = 3600;

length = 64000;
data = randi([0,1],1,length);

for i = 1:length
    b = data(i);
    y(i) = memoryGetVoltage(b,SystemParams,retentionData);
end

histogram(y,100);
toc