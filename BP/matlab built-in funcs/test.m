clear
close

I = [];
for EbNo = -4:0.5:2
    parfor i = 1:1000
        
    hEnc = comm.LDPCEncoder;
    hMod = comm.PSKModulator(2, 'BitInput',true);
    hChan = comm.AWGNChannel(...
        'NoiseMethod','Signal to noise ratio (Eb/No)','EbNo',EbNo);
    hDemod = comm.PSKDemodulator(2, 'BitOutput',true,...
        'DecisionMethod','Approximate log-likelihood ratio', ...
        'Variance', 1/10^(hChan.SNR/10));
    hDec = comm.LDPCDecoder;
    hError = comm.ErrorRate;
    
    data           = logical(randi([0 1], 32400, 1));
    encodedData    = step(hEnc, data);
    modSignal      = step(hMod, encodedData);
    receivedSignal = step(hChan, modSignal);
    demodSignal    = step(hDemod, receivedSignal);
    receivedBits   = step(hDec, demodSignal);
    errorStats     = step(hError, data, receivedBits);
    bitErr(i) = errorStats(1);
    end
    
    I = [I; EbNo, mean(bitErr)];
    
end
