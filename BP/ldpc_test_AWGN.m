% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.876/H-3584-3140.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.876/G-3584-3140.mat');
G = G.G; %Dodgy work-around!

% Belief Propogation Iterations
l = 100;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 8:0.5:10
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic
    parfor i = 1:35
        [~,errRatio(i),iterations(i)] = ldpc_BER_AWGN(G,H,l,SNR);
    end
    toc
    I = [I;SNR,mean(iterations),mean(errRatio)];
end


