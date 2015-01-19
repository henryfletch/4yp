% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio,iterations] = ldpc_BER_AWGN(G,H,l,sigma2)

% Input vector
[rows,cols] = size(G);
x_message = randi([0,1],1,rows);

%Encode
x = mod(x_message*G,2);
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
[y,iters] = BP_iterate_matlab(x,H,l);
iterations = iters;
y=y';

[biterr_num,biterr_ratio] = biterr(x_encoded,y);

end