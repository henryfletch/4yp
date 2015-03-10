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

%%% DVB-S2 CODES %%%
%Code Rate
Rc = 9/10;
%Code size
Nc = 64800;
%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);

%%% TOSHIBA PEG CODES %%%
% addpath('../../LDPC data/Toshiba');
% H = load('H-4095-3367.mat');
% H = H.H;
% G = load('G-4095-3367.mat');
% G = G.G;
% Nc = 4095;
% Rc = 3367/4095;

% MC Simulation Runs
mc_iters = 1000;
l = 50;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
for N = 39000:1000:45000
    fprintf('N =%6.2f',N);
    fprintf('\n');
    hEnc = comm.LDPCEncoder(H); %G;
    hDec = comm.LDPCDecoder('ParityCheckMatrix',H,'IterationTerminationCondition',...
        'Parity check satisfied','OutputValue','Whole codeword');
    hError = comm.ErrorRate;
    tic;
    SystemParams.N = N;
    %SystemParams.tYrs = timeFunc(N,alpha);
    voltageHardDecision = 0;%decisionFunc(N);
    %Parfor Loop
    parfor_progress(mc_iters);
    parfor i = 1:mc_iters
        errRatio(i) = ldpc_BER_memoryN_coded(Rc,Nc,hEnc,hDec,hError,SystemParams,voltageHardDecision,H,l);
        parfor_progress;
    end
    parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;N,mean(errRatio)];
end
