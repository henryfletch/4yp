%This function takes any length binary data, x, and then encodes it using
%the given Generator Matrix, into a data stream y. If x does not divide
%perfectly, padded 0's are added at the end

function y = codeCombine(x,G)

n = size(x); %Message length

% Need to discover max block length
[k,~] = size(G); %Max block size is k

% Does the message divide perfectly?
% If not, pad with zeros
if rem(n/k,1) ~= 0
    numBlocksReq = floor(n/k) + 1; %Number of message blcks needed
    sizeDiff = numBlocksReq*k - n; %Difference between 'x_old' and 'x_padded'
    
    %Add 'sizeDiff' 0's onto end of x
    for i = 1:sizeDiff
        x = [x,0];
    end
    n=length(x); %Recalculate new n
end

%Continue with encoding blockwise
x = reshape(x,k,(n/k))'; %Reshape x into a matrix. 1 row = 1 message block

parfor i = 1:(n/k) %Go through each row of x_block and encode into matrix y
    y(i,:) = encoder(G,x(i,:));
end

y = reshape(y',1,[]); %Output message vector, y

end

