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

%Code Rate
Rc = 9/10;

%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);
%H2 = full(H);

% MC Simulation Runs
mc_iters = 10000;
l = 50;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];

hEnc = comm.LDPCEncoder(H);
hDec = ldpcdec(H, 'cl\Kernels_sp.cl', 0.875);
hError = comm.ErrorRate;

for N = 36000:500:38000
    for t = 1:1:10
        fprintf('N = %6.2f',N);
        fprintf('\n');
        fprintf('t = %6.2f',t);
        fprintf('\n');
        tic;
        SystemParams.N = N;
        SystemParams.tYrs = t;
        %SystemParams.tYrs = timeFunc(N,alpha);
        voltageHardDecision = 0;% decisionFunc(N);
        %Parfor Loop
        %parfor_progress(mc_iters);
        for i = 1:mc_iters
            errRatio(i) = ocl_ldpc_BER_memoryN_coded(Rc,hEnc,hDec,hError,SystemParams,voltageHardDecision,H,l);
            %parfor_progress;
        end
        %parfor_progress(0);
        toc;
        %Output Matrix
        I = [I;N,t,mean(errRatio)];
    end
end
hDec.delete();
clear hdec;
