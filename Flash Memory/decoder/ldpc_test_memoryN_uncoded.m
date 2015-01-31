% LDPC Graphing Run Script
% FIXED t, VARIABLE N
clear
close

addpath('../Random Generators');
addpath('../.');

% System Parameters
SystemParams.tYrs = 5;
SystemParams.Verased = 1.4;
SystemParams.Vp = 2.8;
SystemParams.deltaVp = 0.25;

% Retention Parameters
retentionData.Ks = 0.38;
retentionData.Kd = 4e-4;
retentionData.Km = 4e-6;
retentionData.t0 = 3600;

%Code Rate
Rc = 9/10;

%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);

% Belief Propogation Max Iterations
l = 50;
% MC Simulation Runs
mc_iters = 1000;

% Modulation Rate
Rm = 1; %Always 1 for BPSK

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
for N = 0:500:10000
    fprintf('N =%6.2f',N);
    fprintf('\n');
    tic;
    SystemParams.N = N;
    voltageHardDecision = decisionFunc(N);
    %Parfor Loop
    parfor_progress(mc_iters);
    parfor i = 1:mc_iters
        [~,errRatio(i)] = ldpc_BER_memoryN_uncoded(SystemParams,retentionData,voltageHardDecision);
    parfor_progress;
    end
    parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;N,mean(errRatio)];
end

