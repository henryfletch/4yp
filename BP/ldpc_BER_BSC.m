% Function: Takes input vector x, encodes using G, performs BSC with error
% rate p, and then decodes using Belief Propogation (iterations l), and
% finally displays BER.

function [biterr_num,biterr_ratio] = ldpc_BER_BSC(G,H,l,p)

% Input vector
[rows,~] = size(G);
x = randi([0,1],1,rows);

%Encode
x = mod(x*G,2);
x_encoded = x;

% Binary Symmetric Channel
x = bsc(x,p);

%BPSK -> bin0 -> +1 and bin1 -> -1
for i = 1:length(x)
    if x(i) == 0
        x(i) = 1;
    else
        x(i) = -1;
    end
end

% Belief Propogation Stage
y = BP_iterate(x,H,l);

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