% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.5/H-96-48.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.5/G-96-48.mat');
G = G.G; %Dodgy work-around!

% Belief Propogation Iterations
l = 100;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 0:1:7
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic;
    parfor i = 1:300
        [~,errRatio(i),iterations(i)] = ldpc_BER_AWGN(G,H,l,SNR);
    end
    toc
    I = [I;SNR,mean(iterations),mean(errRatio)];
end

