% LDPC Monte-Carlo Run Script
clear
close
addpath('./minSum');

%%%%%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%%%%

% Parity Check Matrix (H)
H = load('../LDPC data/Rate0.5/H-96-48-v2.mat');
% Generator Matrix (G)
G = load('../LDPC data/Rate0.5/G-96-48-v2.mat');

% Belief Propogation Max Iterations
l = 50;
% MC Simulation Runs
N = 100;
% MinSum Convergence Factor
convergFactor = 0.7;

% EbNo Range
EbNoRange = 0:1:5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H = sparse(H.H);
G = sparse(G.G);

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
    %parfor_progress(N);
    for i = 1:N
        [~,errRatio(i),iterations(i)] = ldpc_BER_AWGN(G,H,l,sigma2);
        %parfor_progress;
    end
    %parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;EbNo,mean(iterations),mean(errRatio)];
end

