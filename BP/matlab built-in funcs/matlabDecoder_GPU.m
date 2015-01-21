clear
close

I = [];
tic
for EbNo = 2:0.1:3
    display(EbNo)
    
    parfor i = 1:10000
        hEnc = comm.LDPCEncoder;
        hMod = comm.PSKModulator(2, 'BitInput',true);
        hChan = comm.AWGNChannel(...
            'NoiseMethod','Signal to noise ratio (Eb/No)','EbNo',EbNo);
        hDemod = comm.PSKDemodulator(2, 'BitOutput',true,...
            'DecisionMethod','Approximate log-likelihood ratio', ...
            'Variance', 1/10^(hChan.SNR/10));
        hDec = comm.gpu.LDPCDecoder;
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
toc