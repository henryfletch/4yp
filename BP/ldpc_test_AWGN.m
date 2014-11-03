% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.5/H-9972-4986.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.5/G-9972-4986.mat');
G = G.G; %Dodgy work-around!

% Belief Propogation Iterations
l = 2;

% Loop to go over all values of SNR, as well as perform multiple iterations
Z = [];
for SNR = 6:0.5:7
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic
    %parfor i = 1:floor(SNR*100+150)
        [~,biterr_ratio(1)] = ldpc_BER_AWGN(G,H,l,SNR);
    %end
    toc
    Z = [Z;SNR,mean(biterr_ratio)];
    %save('output.mat','Z');
end


