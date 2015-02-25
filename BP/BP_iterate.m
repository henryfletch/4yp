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
nonzeros = nnz(H);

%Preallocate M_IJ and M_JI as sparse matrices
m_IJ = spalloc(j_max,i_max,nonzeros);
m_JI = spalloc(j_max,i_max,nonzeros);

H_ = H';
for iter = 0:l
    
    %All Message nodes:
    if iter == 0 % on initial iteration:
        m_IJ = bsxfun(@times,x,H);
    else % subsequently:
        a = (x + sum(m_JI));
        b = bsxfun(@times,a,H);
        m_IJ = b - m_JI;
    end
    
    m_IJ_2 = m_IJ'./2; %Transpose: Memory access is then much quicker!
    
    c = tanh(m_IJ_2);
    d = spfun(@log,c);
    e = sum(d);
    f = bsxfun(@times,e,H_);
    g = f - d;
    g = spfun(@exp,g);
    m_JI = 2*atanh(g);
    m_JI = m_JI';

    % Clipping function
    m_JI((m_JI) > 1000)=999;
    m_JI((m_JI) < -1000)=-999;
    
    %Get current variable node values
    sumVector = sum(m_JI);
    y = x + sumVector;
    
    %Stop check: Is a valid codeword? i.e. y*H' == 0
    %Hard Decision:
    y2(y>0) = 0;
    y2(y<0) = 1;
    
    %Parity Check:
    test = sum(mod(y2*H_,2));
    if test == 0
        iterations = iter;
        return
    end
end
end




