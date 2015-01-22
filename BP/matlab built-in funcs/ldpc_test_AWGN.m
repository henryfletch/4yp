% LDPC Graphing Run Script
clear
close

%Code Rate
Rc = 9/10;

%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);

% Belief Propogation Max Iterations
l = 50;
% MC Simulation Runs
N = 20000;

% Modulation Rate
Rm = 1; %Always 1 for BPSK

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
for EbNo = 5.11
    fprintf('SNR =%6.2f',EbNo);
    fprintf('\n');
    tic;
    % Noise Variance Extraction
    sigma2 = getVariance(EbNo,Rc,Rm);
    %Parfor Loop
    parfor_progress(N);
    parfor i = 1:N
        [~,errRatio(i),iterations(i)] = ldpc_BER_AWGN(H,l,sigma2);
    parfor_progress;
    end
    parfor_progress(0);
    toc;
    %Output Matrix
    I = [I;EbNo,mean(iterations),mean(errRatio)];
end

