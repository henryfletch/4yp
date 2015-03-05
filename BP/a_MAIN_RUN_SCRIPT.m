% LDPC Monte-Carlo Run Script
clear
close
addpath('./minSum');
addpath('./opencl-LDPC');

%%%%%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%%%%

% Parity Check Matrix (H)
H = load('../LDPC data/Toshiba/H-4095-3367.mat');
% Generator Matrix (G)
G = load('../LDPC data/Toshiba/G-4095-3367.mat');

% Belief Propogation Max Iterations
l = 50;
% MC Simulation Runs/Blocks
N = 10000;
% MinSum Convergence Factor
convergFactor = 0.7;

% EbNo Range
EbNoRange = 3:0.2:4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H = sparse(H.H);
G = sparse(G.G);

%hDec = ldpcdec(H, 'opencl-LDPC\cl\Kernels_sp.cl', 0.875);
hDec = comm.LDPCDecoder...
    ('ParityCheckMatrix',H,'OutputValue','Whole codeword',...
    'DecisionMethod','Hard decision',...
    'IterationTerminationCondition','Parity check satisfied',...
    'MaximumIterationCount',l,...
    'NumIterationsOutputPort',true);

% Modulation Rate
Rm = 1; %Always 1 for BPSK
% Code Rate Calculation
[m,n] = size(G);
Rc = m/n;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
for EbNo = EbNoRange
    fprintf('SNR =%6.2f',EbNo);
    fprintf('\n');
    tic;
    % Noise Variance Extraction
    sigma2 = getVariance(EbNo,Rc,Rm);
    %Parfor Loop
    parfor_progress(N);
    parfor i = 1:N
        [~,errRatio(i),~] = ldpc_BER_AWGN(G,H,l,sigma2,hDec);
        parfor_progress;
    end
    parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;EbNo,mean(errRatio),N];
end

