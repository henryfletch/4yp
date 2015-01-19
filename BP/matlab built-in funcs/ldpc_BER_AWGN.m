% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio,iterations] = ldpc_BER_AWGN(H,l,sigma2)

% Input vector
x = randi([0,1],1,32400);

%Encode
x = bp_encoder(x,H);
x=x';
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
n = sqrt(sigma2)*randn(1,64800); % Noise vector
x = x + n;

% Belief Propogation Stage
[y,iterations] = BP_iterate(x,H,l);

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