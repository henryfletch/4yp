function k = dimension(r,m)

% Returns the value of k, for given r and m
% K is the message vector length for a given code

k = 1;

for i = 1:r
    k = k + nchoosek(m,i);
end

end
