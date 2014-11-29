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
l = 50;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 3:0.5:6
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    N = floor(100*SNR^(3));
    tic;
    parfor_progress(N);
    parfor i = 1:N
        [~,errRatio(i),iterations(i)] = ldpc_BER_minsum_AWGN(G,H,l,SNR);
        parfor_progress;
    end
    parfor_progress(0);
    toc
    I = [I;SNR,mean(iterations),mean(errRatio),N];
end

