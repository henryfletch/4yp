% Belief Propogation Iteration Function

function y = BP_iterate(x,H,l)

global iterator;

% x = Input LLR vector
% H = Graph connection matrix/Parity Check Matrix
% l = # Iterations
% y = Output LLR vector

% Need to calculate number of CHK and MSG nodes from H
[j_max,i_max] = size(H);

%Preallocate M_IJ and M_JI
m_IJ = zeros(i_max,j_max);
m_JI = zeros(j_max,i_max);

for iter = 0:l
    % All Message nodes:
    for i = 1:i_max
        % At each Message node:
        h = H(:,i);
        h = h';% Row vector of connections to check nodes
        
        % Message sent down each branch from MSG to CHK:
        for j = 1:j_max
            if h(j) == 1 % i.e. if MSG i is connected to check j
                if iter == 0 % on initial iteration:
                    m_IJ(i,j) = x(i); % Message sent = initial conditions
                else % subsequently:
                    m_IJ(i,j) = m_IJ(i,j) + BP_messageNode(m_JI,j,i,j_max);
                end
            else
                m_IJ(i,j) = 0;
            end
        end
    end
    
    %All Check nodes:
    for j = 1:j_max
        % At each Check node:
        h = H(j,:); % Row vector of connections to that node
        
       % Message sent down each branch:
       for i = 1:i_max
           if h(i) == 1 % i.e. if Check j is connected to Message node i
               m_JI(j,i) = 2*atanh(BP_checkNode(m_IJ,i,j,i_max));
           else
               m_JI(j,i) = 0;
           end
       end
    end
    
    %Get current variable node values
    for i = 1:i_max
        sum = 0;
        for j = 1:j_max
            sum = sum + m_JI(j,i);
        end
        y(i) = x(i) + sum;
    end
    
    %Test to see if we should break execution at this iteration
    % Values of y either +/- Inf? -> Break
    if isnan(range(abs(y)))
        iterator = iter;
        return
    end
    
end



