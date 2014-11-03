% LDPC Graphing Run Script
clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.5/H-1008-504.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.5/G-1008-504.mat');
G = G.G; %Dodgy work-around!

% Belief PropogationIterations
l = 15;

% Loop to go over all values of p, as well as perform multiple iterations
% per probability value
Z = [];
for p = 0:0.001:0.05
    fprintf('P =%6.4f',p);
    fprintf('\n');
    tic;
    parfor i = 1:100
        [~,biterr_ratio(i)] = ldpc_BER_BSC(G,H,l,p);
    end
    toc;
    Z = [Z;p,mean(biterr_ratio)];
end


