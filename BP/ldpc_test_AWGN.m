% LDPC Graphing Run Script

clear
close

global iterator;

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.5/H-96-48.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.5/G-96-48.mat');
G = G.G; %Dodgy work-around!

% Belief Propogation Iterations
l = 15;

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 0:0.1:5
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic
    for i = 1:10
        [~,~] = ldpc_BER_AWGN(G,H,l,SNR);
        iterations(i) = iterator; 
    end
    toc
    I = [I;SNR,mean(iterations)];
    %save('output.mat','Z');
end


