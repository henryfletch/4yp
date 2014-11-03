% Belief Propogation
% Check Node Function

function y = BP_checkNode(m_IJ,i,j,i_max)

% Inputs: m is the m(i,j) matrix: the messages from the MSG node to
% the CHK node from the previous operation. 
% i is the current branch we are on, i.e. sending output y to MSG node i
% j is the current CHK node we are at.
% i_max is total number of MSG nodes

% Important to ensure that the MSG node does not receive data from itself
% i.e we exclude row i from this calculation.

% First, select the messages for CHK node j
%M = m_IJ(:,j); % M is a column vector of input messages to j
%M = M'; % Now a row vector of messages from i to j

product = 1;
for i_ = 1 : i_max
    if m_IJ(i_,j) ~= 0 % Conditions: Not current branch + branch exists?
        if i_ ~= i
            product = product * tanh(m_IJ(i_,j)/2);
        end
    end
end

y = product;

end

        

