%Function to calculate minimum

function y = minFunc(v)

% v is a vector of incoming messages to check node
% y is a vector of the minimum value of entire v excluding that return
% index.

n = length(v);
A = repmat(v,1,n);
A(eye(n)==1)=inf;
y = min(abs(A))';

end