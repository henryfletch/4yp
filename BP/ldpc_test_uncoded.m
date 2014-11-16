% LDPC Graphing Run Script

clear
close

% Loop to go over all values of SNR, as well as perform multiple iterations
U = [];
for SNR = 6:0.01:9
    parfor i = 1:1000
        [~,biterr_ratio(i)] = ldpc_BER_uncoded(SNR);
    end
    U = [U;SNR,mean(biterr_ratio)];
    %save('output.mat','Z');
end


