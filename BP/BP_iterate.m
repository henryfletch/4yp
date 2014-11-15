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

%Preallocate M_IJ and M_JI as sparse matrices
m_IJ = spalloc(j_max,i_max,200);
m_JI = spalloc(j_max,i_max,200);

for iter = 0:l
    %All Message nodes:
    for i = 1:i_max
        % At each Message node:
        h = H(:,i);% Column vector of connections to check nodes
        
        % Message sent down each branch from MSG to CHK:j
        if iter == 0 % on initial iteration:
            m_IJ(find(h),i) = x(i); % Message sent = initial conditions
        else % subsequently:
            w = m_JI(:,i);
            m_IJ(:,i) = m_IJ(:,i) + h*sum(w) - w;
        end
    end
    
    
%%%%Slower test code below%%
%     if iter == 0
%         for i = 1:i_max
%             h = H(:,i);
%             m_IJ(find(h),i) = x(i);
%         end
%     else
%         B = repmat(sum(m_JI),j_max,1);
%         m_IJ = m_IJ + B.*H - m_JI;
%     end
    

    m_IJ_2 = m_IJ'; %Transpose: Memory access is then much quicker!
    %All Check nodes:
    for j = 1:j_max
        % At each Check node:
        %h = H(j,:);
        %h = h';
        
        % Message sent down each branch:
        w = m_IJ_2(:,j);
        [row,~,v] = find(w); % v is non-zero elements
        m_JI(j,row) = 2*atanh(prod(tanh(v./2))./(tanh(v./2)));
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
    
    
end

end




