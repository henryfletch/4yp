% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio,iterations] = ldpc_BER_AWGN(G,H,l,sigma2,hDec)

% Input vector
[rows,cols] = size(G);
x_message = randi([0,1],1,rows);

%Encode
x = mod(x_message*G,2);
x_encoded = x;

%BPSK -> bin0 -> +1 and bin1 -> -1
x(x==1) = -1;
x(x==0) = 1;

%AWGN Channel
n = sqrt(sigma2)*randn(1,cols); % Noise vector
x = x + n;

%Calculate LLR
x = (2*x)/sigma2;

% Belief Propogation Stage
%[y,iterations] = BP_iterate(x,H,l);
%[~,y] = hDec.decode(x,l);
%iterations = l;
[y,iterations] = step(hDec,x');

%Convert from LLR to Binary
% for i = 1:length(y)
%     if y(i) > 0
%         y(i) = 0;
%     else
%         y(i) = 1;
%     end
% end

[biterr_num,biterr_ratio] = biterr(x_encoded,+y');

end