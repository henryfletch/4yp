% Belief Propogation Iteration Function

function [y,iterations] = BP_iterate(x,H,l)

iterations = l;

% x = Input LLR vector
% H = Graph connection matrix/Parity Check Matrix
% l = # Iterations
% y = Output LLR vector

%i = Message Nodes;
%j = Check Nodes;

% Need to calculate number of CHK and MSG nodes from H
[j_max,i_max] = size(H);

%Preallocate M_IJ and M_JI
m_IJ = zeros(i_max,j_max);
m_JI = zeros(j_max,i_max);

for iter = 0:l
    % All Message nodes:
    for i = 1:i_max
        % At each Message node:
        h = H(:,i);% Column vector of connections to check nodes
        
        % Message sent down each branch from MSG to CHK:j
        if iter == 0 % on initial iteration:
            m_IJ(i,find(h)) = x(i); % Message sent = initial conditions
        else % subsequently:
            w = m_JI(:,i);
            %inter = h'*sum(w);
            %inter(isnan(inter)) = 0; %Fixes NaN Overflow error with Inf
            m_IJ(i,:) = m_IJ(i,:) + h'*sum(w) - w';
        end
    end
    
    %%%%%%% OLD CODE START %%%%%%%
    
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
    sumVector = sum(m_JI);
    y = x + sumVector;
    
    %Test to see if we should break execution at this iteration
    % Values of y either +/- Inf? -> Break
    if  any(abs(y) == inf)
        iterations = iter;
        return
    end
    
    %%% OLD CODE ENDS %%%
    
    
%     %All Check nodes:
%     for j = 1:j_max
%         % At each Check node:
%         h = H(j,:);
%         h = h';
%         
%         % Message sent down each branch:
%         w = h.*m_IJ(:,j);
%         [row,~,v] = find(w); % v is non-zero elements
%         m_JI(j,row) = 2*atanh(prod(tanh(v./2))./(tanh(v./2)));
%         clear w v;
%     end
% 

end

end




