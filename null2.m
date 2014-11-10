%Computes the null space of a binary matrix A over GF(2)
% SOURCE: http://www.mathworks.com/matlabcentral/fileexchange/48264--nullspace-=null2-a-/content/null2.m
% BSD License

function [NullSpace]=null2(A)
A=mod(A,2);
%number of constraints:
m=size(A,1);
%number of variables:
n=size(A,2);
%number of independent constraints:
r=gfrank(A,2);

%Take care of the trivial cases:
if (r==n)
    NullSpace=[];
elseif (r==0)
    NullSpace=eye(n,n);
end


%Add one constraint at a time.
%Maintain a matrix X whose columns obey all constraints examined so far.

%Initially there are no constraints:
X=eye(n,n);

for i=1:m
    y=mod(A(i,:)*X,2);
    % identify 'bad' columns of X which are not orthogonal to y
    % and 'good' columns of X which are orthogonal to y
    GOOD=[X(:,find(not(y)))];
    %convert bad columns to good columns by taking pairwise sums
    if (nnz(y)>1)
      BAD=[X(:,find(y))];
      BAD=mod(BAD+circshift(BAD,1,2),2);
      BAD(:,1)=[];
    else
        BAD=[];
    end
    X=[GOOD,BAD];
end%for i

NullSpace=X;

end

% Copyright (c) 2014, Sergey Bravyi
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
