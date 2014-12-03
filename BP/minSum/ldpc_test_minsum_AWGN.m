% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../../LDPC data/Rate0.876/H-3584-3140.mat');
%H = load('../Polar data/H-128-64-polar.mat');
H = sparse(H.H); %Dodgy work-around!

% "Generator Matrix"
G = load('../../LDPC data/Rate0.876/G-3584-3141-v2.mat');
%G = load('../Polar data/G-128-64-polar.mat');
G = sparse(G.G); %Dodgy work-around!

% Belief Propogation Iterations
l = 70;

% MinSum Correction factor: 0 < convergFactor < 1
convergFactor = 0.7;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 6.5:0.5:7.5
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    N = 10000;
    tic;
    parfor_progress(N);
    parfor i = 1:N
        [~,errRatio(i),iterations(i)] = ldpc_BER_minsum_AWGN(G,H,l,SNR,convergFactor);
        parfor_progress;
    end
    parfor_progress(0);
    toc
    I = [I;SNR,mean(iterations),mean(errRatio),N];
end

