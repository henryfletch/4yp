% LDPC Graphing Run Script
% FIXED t, VARIABLE N
clear
close

addpath('../../Random Generators');
addpath('../.');
addpath('../../.');

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

% %%% TOSHIBA PEG CODES %%%
% addpath('../../../LDPC data/Toshiba');
% H = load('H-4095-3367.mat');
% H = H.H;
% G = load('G-4095-3367.mat');
% G = G.G;
% Nc = 4095;
% Rc = 3367/4095;

% MC Simulation Runs
mc_iters = 10;
l = 50;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];

hEnc = comm.LDPCEncoder(H);
hDec = ldpcdec(H, 'cl\Kernels_sp.cl', 0.875);
hError = comm.ErrorRate;

for N = 35500:500:38000
    fprintf('N = %6.2f',N);
    fprintf('\n');
    tic;
    SystemParams.N = N;
    voltageHardDecision = 0;% decisionFunc(N);
    %Loop
    for i = 1:mc_iters
        errRatio(i) = ocl_ldpc_BER_memoryN_coded(Rc,Nc,hEnc,hDec,hError,SystemParams,voltageHardDecision,H,l);
    end
    toc;
    %Output Matrix
    I = [I;N,mean(errRatio),mc_iters];
end
hDec.delete();
clear hdec;
