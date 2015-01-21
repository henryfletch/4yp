clear
close

H = dvbs2ldpc(0.9);
N = 5000;

I = [];
tic
for EbNo = 2.5:0.1:4
    
    hEnc = comm.LDPCEncoder(H);
    hMod = comm.PSKModulator(2, 'BitInput',true);
    hChan = comm.AWGNChannel(...
        'NoiseMethod','Signal to noise ratio (Eb/No)','EbNo',EbNo);
    hDemod = comm.PSKDemodulator(2, 'BitOutput',true,...
        'DecisionMethod','Approximate log-likelihood ratio', ...
        'Variance', 1/10^(hChan.SNR/10));
    hDec = comm.gpu.LDPCDecoder('ParityCheckMatrix',H,'IterationTerminationCondition',...
        'Parity check satisfied');
    hError = comm.ErrorRate;
    
    parfor_progress(N);
    parfor i = 1:N
        data           = logical(randi([0 1], 58320, 1));
        encodedData    = step(hEnc, data);
        modSignal      = step(hMod, encodedData);
        receivedSignal = step(hChan, modSignal);
        demodSignal    = step(hDemod, receivedSignal);
        receivedBits   = step(hDec, demodSignal);
        errorStats     = step(hError, data, receivedBits);
        bitErr(i) = errorStats(1);
        parfor_progress;
    end
    
    I = [I; EbNo, mean(bitErr)];
    parfor_progress(0);
end
toc