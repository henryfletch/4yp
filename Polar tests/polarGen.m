function G = polarGen(n,k)

% n = block length
% k = message bits

% Extract block length and convert
n_power = log2(n);
if nnz(mod(n_power,1))
    error('N (Block length) must be powers of 2!');
end

%Construct the 'hadamard' matrix
hadamardMatrix = hadamardGen(n_power);

%Extract the rows from the hadamard matrix
G = hadamardMatrix(n-k+1:n,:);
end
