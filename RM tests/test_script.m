clear

%%%%% INPUTS %%%%%
n = 5; %Message length
x = randi([0 1],1,n); %Random Binary data
[G,d] = rm(1,4); %Generator matrix
p = 0.1; %BSC Error probability
sigma = 0.2; %AWGN sigma value
%%%%%%%%%%%%%%%%%%

y = encoder(G,x);
printCapability(d);
n_block = length(y);

%%% Binary Symmetric Channel %%%
y_bsc = bsc(y,p);
[number,ratio] = biterr(y,y_bsc);

%%% AWGN Channel %%%
% 0 -> 1 
% 1 -> -1
% (BPSK Channel simulation)
% REF: [PDF3] page 4

y_bpsk = y;

for i = 1:n_block
    if y_bpsk(i) == 0
        y_bpsk(i) = 1;
    else
        y_bpsk(i) = -1;
    end
end

y_awgn = y_bpsk + randn(n_block,1)'*sigma^2;

% Log-Liklihood ratios (needed for BP?)
% REF: [PDF3] page 5

u_llr = (4*y_awgn)/(2*sigma^2);



