% LDPC Graphing Run Script
clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.876/H-3584-3140.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.876/G-3584-3140.mat');
G = G.G; %Dodgy work-around!

% Belief PropogationIterations
l = 100;

% Loop to go over all values of p, as well as perform multiple iterations
% per probability value
Z = [];
for p = 0:0.005:0.05
    fprintf('P =%6.4f',p);
    fprintf('\n');
    tic;
    for i = 1:1
        [~,biterr_ratio(i),iterations(i)] = ldpc_BER_BSC(G,H,l,p);
    end
    toc;
    Z = [Z;p,mean(iterations),mean(biterr_ratio)];
end


