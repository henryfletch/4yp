function A = zeroOneFunc(m)

%%%%% This creates a row vector like:
%%%%% 000...001 where n = 2^m 

A(1:2^m) = 0;
A(2^m) = 1;

end