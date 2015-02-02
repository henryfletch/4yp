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
            m_IJ(:,i) = h*x(i) + h*sum(w) - w; % m_IJ(:,i)
        end
    end
    
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
    
    % NEW! Clipping function
    m_JI((m_JI) > 500)=499; 
    m_JI((m_JI) < -500)=-499;
    
    %Get current variable node values
    sumVector = sum(m_JI);
    y = x + sumVector;
    
    %First stop check:
    % Values of y either +/- Inf? -> Break
    % Cannot resume if any value saturates to infinity anyway
%     if  any(abs(y) == inf)
%         iterations = iter;
%         return
%     end
    
    %Second stop check: Is a valid codeword? i.e. y*H' == 0
    %Hard Decision:
    for i = 1:length(y)
        if y(i) > 0
            y2(i) = 0;
        else
            y2(i) = 1;
        end
    end
    %Parity Check:
    test = sum(mod(y2*H',2));
    if test == 0
        iterations = iter;
        return
    end
    
end

end




