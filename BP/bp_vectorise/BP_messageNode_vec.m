% Belief Propogation
% Message Node Function

function y = BP_messageNode_vec(m_JI,j,i,j_max)

% Inputs: m_JI is the m(j,i) matrix, the messages from the CHK node to the
% MSG node from the previous operation.
% j is the current branch we are on i.e. sending output y to CHK node j
% i is the current MSG node we are at.
% j_max is the total number of CHK nodes.

% Important to ensure that the CHK node does not receive data from itself.
% i.e. we exclude row j from this calculation.

% First, select the messages for MSG node i:
%M = m_JI(:,i);
%M = M'; % Row vector of messages sent from j to i

sum = 0;
for j_ = 1:j_max
    if m_JI(j_,i) ~= 0 % Conditions: Not on current branch & branch exists
        if j_ ~= j
            sum = sum + m_JI(j_,i);
        end
    end
end

y = sum;

end