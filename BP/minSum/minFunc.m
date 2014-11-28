%Function to calculate minimum

function y = minFunc(v)

% v is a vector of incoming messages to check node
% y is a vector of the minimum value of entire v excluding that return
% index.

n = length(v);
y = zeros(n,1);
for i = 1:n
    vtemp=v;
    vtemp(i) = inf;
    y(i) = min(abs(vtemp));
end

end