% Function: Takes input vector x, encodes using G, performs AWGN to given SNR,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio,iterations] = ldpc_BER_minsum_AWGN(G,H,l,sigma2,convergFactor)

% Input vector
[rows,cols] = size(G);
x = randi([0,1],1,rows);

%Encode
x = mod(x*G,2);
x_encoded = x;

%BPSK -> bin0 -> +1 and bin1 -> -1
for i = 1:length(x)
    if x(i) == 0
        x(i) = 1;
    else
        x(i) = -1;
    end
end

%AWGN Channel
n = sqrt(sigma2)*randn(1,cols); % Noise vector
x = x + n;

% Belief Propogation Stage
[y,iterations] = BP_iterate_minsum(x,H,l,convergFactor);

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