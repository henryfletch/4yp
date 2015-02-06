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

% MC Simulation Runs
mc_iters = 2000;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
for N = 0:200:10000
    fprintf('N =%6.2f',N);
    fprintf('\n');
    tic;
    SystemParams.N = N;
    voltageHardDecision = decisionFunc(N);
    %Parfor Loop
    parfor_progress(mc_iters);
    parfor i = 1:mc_iters
        [~,errRatio(i)] = ldpc_BER_memoryN_uncoded(SystemParams,voltageHardDecision);
    parfor_progress;
    end
    parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;N,mean(errRatio)];
end

