function E = encoder(G,M)

% G is the (Generator) Matrix
% M is the message to be encoded

%Dimension checking:
k = size(G);
k = k(1);
K = length(M);

if k ~= K
    fprintf('The matrix dimension is:')
    disp(k);
    error('Dimensions of Message and chosen code do not agree!');
end

%Multiply M*G, modulo-2 since binary!
E = mod(M*G,2);

end



    