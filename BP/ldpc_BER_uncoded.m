% Function: Takes input vector x, performs AWGN to given SNR,
% and then displays BER.

function [biterr_num,biterr_ratio] = ldpc_BER_uncoded(SNR)

% Input vector
x = randi([0,1],1,48);
x_encoded = x;

%BPSK -> bin0 -> +1 and bin1 -> -1
for i = 1:length(x)
    if x(i) == 0
        x(i) = 1;
    else
        x(i) = -1;
    end
end

%AWGN
y = awgn(x,SNR);

%Convert from LLR to Binary
for i = 1:length(y)
    if y(i) > 0
        y(i) = 0;
    else
        y(i) = 1;
    end
end

[biterr_num,biterr_ratio] = biterr(x_encoded,y);

end