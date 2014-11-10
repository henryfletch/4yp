function G = polarGen(n,k)

% n = block length
% k = message bits

% Extract block length and convert
n_power = log2(n);

%Construct the 'hadamard' matrix
hadamardMatrix = hadamardGen(n_power);

%Extract the rows from the hadamard matrix
G = hadamardMatrix(n-k+1:n,:);
end
