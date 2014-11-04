% LDPC Graphing Run Script

clear
close

% "Parity Check Matrix" or graph connections
H = load('../LDPC data/Rate0.5/H-96-48.mat');
H = H.H; %Dodgy work-around!

% "Generator Matrix"
G = load('../LDPC data/Rate0.5/G-96-48.mat');
G = G.G; %Dodgy work-around!

% Belief Propogation & Simulation Iterations
l = 100; %MAX value
monteCarlo = 500; %Parfor

% Loop to go over all values of SNR, as well as perform multiple iterations
I = [];
for SNR = 0:0.1:5
    fprintf('SNR =%6.2f',SNR);
    fprintf('\n');
    tic
    parfor i = 1:monteCarlo
        [biterrs(i),errRatio(i),iterations(i)] = ldpc_BER_AWGN(G,H,l,SNR);
    end
    toc
    blockFailures = nnz(biterrs); 
    I = [I;SNR,monteCarlo,mean(iterations),blockFailures,mean(errRatio)];
    %save('output.mat','Z');
end


