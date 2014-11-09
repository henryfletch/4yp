% Belief Propogation
% Message Node Function

function sum = BP_messageNode_vec(m_JI,i)

% Inputs: m_JI is the m(j,i) matrix, the messages from the CHK node to the
% MSG node from the previous operation.
% i is the current MSG node we are at.

% Important to ensure that the CHK node does not receive data from itself.
% i.e. we exclude row j from this calculation.

% First, select the messages for MSG node i:
%M = m_JI(:,i);
%M = M'; % Row vector of messages sent from j to i

%for j_ = 1:j_max
        %if j_ ~= j
sum = sum(m_JI(:,i)); % This sums ALL messages


end