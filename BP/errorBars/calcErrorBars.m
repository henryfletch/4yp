% Calculates the actual value of the error bars given the total number of
% monte carlo iterations vs the number of error blocks
% SOURCE: MacKay LDPC paper appendix!
% Type is either 'pos' or 'neg' for +ve/-ve bars.
function p = calcErrorBars(type,r,n)

if strcmp(type,'pos')
    p = (r./n).*exp(2.*sqrt((n-r)./(r.*n)));
elseif strcmp(type,'neg')
    p = (r./n).*exp(-2.*sqrt((n-r)./(r.*n)));
else
    error('Incorrect input arguments!');
end
end