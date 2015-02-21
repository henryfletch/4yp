% LDPC Graphing Run Script
% FIXED t, VARIABLE N
clear
close

addpath('../Random Generators');
addpath('../.');

% System Parameters
alpha = 5000; % Expected P/E Cycles per year
SystemParams.tYrs = 5;
SystemParams.Verased = 1.4;
SystemParams.Vp = 2.8;
SystemParams.deltaVp = 0.25;
SystemParams.tSecs = SystemParams.tYrs*365*24*3600;

%Code Rate
Rc = 9/10;

%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);
%H2 = full(H);

% MC Simulation Runs
mc_iters = 5;
l = 50;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
for N = 40000
    fprintf('N =%6.2f',N);
    fprintf('\n');
    hEnc = comm.LDPCEncoder(H);
    hDec = comm.LDPCDecoder('ParityCheckMatrix',H,'IterationTerminationCondition',...
        'Parity check satisfied','OutputValue','Whole codeword');
    hError = comm.ErrorRate;
    tic;
    SystemParams.N = N;
    %SystemParams.tYrs = timeFunc(N,alpha);
    voltageHardDecision = decisionFunc(N);
    %Parfor Loop
    parfor_progress(mc_iters);
    for i = 1:mc_iters
        errRatio(i) = ldpc_BER_memoryN_coded(Rc,hEnc,hDec,hError,SystemParams,voltageHardDecision,H,l);
        parfor_progress;
    end
    parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;N,mean(errRatio)];
end
