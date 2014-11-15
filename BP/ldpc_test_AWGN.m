% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.7/H-0.7-273-192.mat');
%H = load('../Polar data/H-128-64-polar.mat');
H = sparse(H.H); %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.7/G-0.7-273-192.mat');
%G = load('../Polar data/G-128-64-polar.mat');
G = sparse(G.G); %Dodgy work-around!

% Belief Propogation Iterations
l = 150;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 2:0.5:7
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic;
    parfor i = 1:1000
        [~,errRatio(i),iterations(i)] = ldpc_BER_AWGN(G,H,l,SNR);
    end
    toc
    I = [I;SNR,mean(iterations),mean(errRatio)];
end

