% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../../LDPC data/Rate0.5/H-1008-504.mat');
%H = load('../Polar data/H-128-64-polar.mat');
H = sparse(H.H); %Dodgy work-around!

% "Generator Matrix"
G = load('../../LDPC data/Rate0.5/G-1008-504.mat');
%G = load('../Polar data/G-128-64-polar.mat');
G = sparse(G.G); %Dodgy work-around!

% Belief Propogation Iterations
l = 100;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 3.5:0.5:6
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic;
    parfor i = 1:10000
        [~,errRatio(i),iterations(i)] = ldpc_BER_minsum_AWGN(G,H,l,SNR);
    end
    toc
    I = [I;SNR,mean(iterations),mean(errRatio)];
end

