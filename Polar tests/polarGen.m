% Polar test function
% Generates G, a generator matrix for polar coding
% One input: n (integer)
% n is essentially the dimension of the generator matrix

function G = polarGen(n)

F = [1, 0; 1, 1];
f = F;

if n == 1
    G = F;
    return
end

for i = 1:(n-1)
    F = kron(F,f);
end

G = F;

end

    
